class_name GameManager

extends Node

@onready var placement_layer : TileMapLayer = $PlacementLayer

signal updated_rooms(rooms: Array[Room])

# used for calculating area of rooms, not sure how else to implement besides
# making this a global variable...
var area_count : int = 0
var rooms : Array[Room] # array of all rooms

class RoomData:
	var name: String
	var cells: Array[Vector2i]
	
	func _init(_name, _cells):
		name = _name
		cells = _cells

# Do a complete search of all room types
func handle_block_placed() -> void:
	rooms.clear()
	# TODO: Add for the rest of the tile types
	var stone_data = RoomData.new(
		"stone",
		placement_layer.get_used_cells_by_id(2, Tile.STONE_TILE),
	)
	var grass_data = RoomData.new(
		"grass",
		placement_layer.get_used_cells_by_id(2, Tile.GRASS_TILE),
	)
	
	for room_data in [stone_data, grass_data]:
		var cells = room_data.cells
		while len(cells) > 0:
			var coords = cells[0]
			do_dfs(coords, cells)
			var room : Room = Room.new(room_data.name, area_count)
			rooms.push_front(room)
			area_count = 0 # reset the count
			
	# emit a signal with the new rooms
	updated_rooms.emit(rooms)
	
	
func do_dfs(coords: Vector2i, cells: Array[Vector2i]) -> void:
	# TODO: Do we need to check boundaries?
	# Check if the current set of coordinates exists
	if (cells.find(coords) == -1):
		return
	
	# When you process a set of coordinates, remove it from cells
	# AND increment area count
	area_count += 1
	var index = cells.find(coords)
	cells.remove_at(index)
	
	var up = Vector2i(coords.x, coords.y - 1)
	var right = Vector2i(coords.x + 1, coords.y)
	var down = Vector2i(coords.x, coords.y + 1)
	var left = Vector2i(coords.x - 1, coords.y)
	do_dfs(up, cells)
	do_dfs(right, cells)
	do_dfs(down, cells)
	do_dfs(left, cells)
