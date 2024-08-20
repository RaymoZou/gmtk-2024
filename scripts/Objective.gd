"""
An Objective is specific to a room type and has a specific type that indicates what type of Objective it is (eg. AreaObjective)

All Objectives should implement _init and check methods
"""

class_name Objective

var description : String
var room_type : Tile.TILE_TYPE
var type: ObjectiveType
var status : Status = Status.INCOMPLETE # incomplete by default

enum ObjectiveType { AREA, RELATIVE }
enum Status {INCOMPLETE, COMPLETE}

class AreaObjective extends Objective:
	var area: int

	func _init(_description, _room_type, _area) -> void:
		description = _description
		room_type = _room_type
		type = ObjectiveType.AREA
		status = Status.INCOMPLETE
		area = _area

	func check(rooms: Array[Room]) -> void:
		var room_found = false
		for room : Room in rooms:
			if room.cells.size() >= area and room.type == room_type:
				room_found = true
				break
		status = Status.COMPLETE if room_found else Status.INCOMPLETE

#class RelativeObjective extends Objective:
	#
	#var adj_type : Vector2 # this is the type of tile comparing against
	#
	#func _init(_description, _room_type, _adj_type) -> void:
		#description = _description
		#type = ObjectiveType.RELATIVE
		#room_type = _room_type
		#adj_type = _adj_type
		#
	## takes a room and a type and determines if there is an adjacent tile
	## of that type to the given room
	#func has_adjacent(room : Room, type : Vector2) -> bool:
		#
		#return false
		#
	#func check(rooms: Array[Room]) -> void:
		#var room_found = false
		#for room in rooms:
			#if room.type == type and has_adjacent(room, adj_type):
				#break
		#status = Status.COMPLETE if room_found else Status.INCOMPLETE


# Specifies the MINIMUM dimensions required
# Set a dimension to value of 1 to effectively ignore it
# Do not set to 0 otherwise it act funny
# TODO: Add flag to toggle whether the requirement is minimum or maximum
class DimensionObjective extends Objective:
	var width: int
	var height: int

	func _init(_description, _room_type, _width, _height) -> void:
		description = _description
		room_type = _room_type
		type = ObjectiveType.AREA
		status = Status.INCOMPLETE
		width = _width
		height = _height

	func check(rooms: Array[Room]) -> void:
		var room_found = false
		var filtered_rooms = rooms.filter(func(room: Room): return room.type == room_type)
		for room in filtered_rooms:
			room.cells.sort_custom(coords_sort_fn)
			for cell in room.cells:
				var curr_width = 0
				var curr_col = cell
				# Greedily try to satisfy width requirement as long as there's a next cell
				while curr_width < width and curr_col != null:
					# Greedily try to satisfy height requirement as long as there's a next cell
					var curr_height = 0
					var curr_row = curr_col
					while curr_height < height and curr_row != null:
						curr_height += 1
						if curr_height == height:
							break # No point in looking for the next row if we're already tall enough
						var next_row_ind = room.cells.find(Vector2i(curr_row.x, curr_row.y + 1))
						curr_row = room.cells[next_row_ind] if next_row_ind != -1 else null
					
					# Ie. this current column is not tall enough
					if curr_height != height:
						break

					# Current column is tall enough, so look for the next one
					curr_width += 1
					var next_col_ind = room.cells.find(Vector2i(curr_col.x + 1, cell.y))
					curr_col = room.cells[next_col_ind] if next_col_ind != -1 else null

				if curr_width == width:
					room_found = true
					break
		
		status = Status.COMPLETE if room_found else Status.INCOMPLETE


	# Sort so that the most negative x and most negative y coordinate is the first
	# Ideally this helps with processing because we add +1 in the check() function implementation
	func coords_sort_fn(a: Vector2i, b: Vector2i) -> bool:
		if a.x < b.x:
			return true
		if a.x == b.x:
			return a.y < b.y
		return false
