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

class RelativeObjective extends Objective:
	
	var adj_type : Vector2 # this is the type of tile comparing against
	
	func _init(_description, _room_type, _adj_type) -> void:
		description = _description
		type = ObjectiveType.RELATIVE
		room_type = _room_type
		adj_type = _adj_type
		
	# takes a room and a type and determines if there is an adjacent tile
	# of that type to the given room
	func has_adjacent(room : Room, type : Vector2) -> bool:
		
		return false
		
	func check(rooms: Array[Room]) -> void:
		var room_found = false
		for room in rooms:
			if room.type == type and has_adjacent(room, adj_type):
				break
		status = Status.COMPLETE if room_found else Status.INCOMPLETE
