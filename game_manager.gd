class_name GameManager

extends Node

@onready var placement_layer : TileMapLayer = $PlacementLayer

class RoomData:
	var name: String
	var cells: Array[Vector2i]
	
	func _init(_name, _cells):
		name = _name
		cells = _cells

# Do a complete search of all room types
func _on_placement_layer_block_placed() -> void:
	# TODO: Add for the rest of the tile types
	var stone_data = RoomData.new(
		"stone",
		placement_layer.get_used_cells_by_id(2, TILE.STONE_TILE),
	)
	var grass_data = RoomData.new(
		"grass",
		placement_layer.get_used_cells_by_id(2, TILE.GRASS_TILE),
	)
	
	for room_data in [stone_data, grass_data]:
		var cells = room_data.cells
		var num_rooms = 0
		while len(cells) > 0:
			var coords = cells[0]
			do_dfs(coords, cells)
			num_rooms += 1
		print("Number of %s rooms: %d" % [room_data.name, num_rooms])
	
	
func do_dfs(coords: Vector2i, cells: Array[Vector2i]) -> void:
	# TODO: Do we need to check boundaries?
	# Check if the current set of coordinates exists
	if (cells.find(coords) == -1):
		return
	
	# When you process a set of coordinates, remove it from cells
	var currentInd = cells.find(coords)
	cells.remove_at(currentInd)
	
	var up = Vector2i(coords.x, coords.y - 1)
	var right = Vector2i(coords.x + 1, coords.y)
	var down = Vector2i(coords.x, coords.y + 1)
	var left = Vector2i(coords.x - 1, coords.y)
	do_dfs(up, cells)
	do_dfs(right, cells)
	do_dfs(down, cells)
	do_dfs(left, cells)
