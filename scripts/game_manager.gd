class_name GameManager

extends Node

@onready var placement_layer : TileMapLayer = $PlacementLayer

signal updated_rooms(rooms: Array[Room])

var rooms : Array[Room] # array of all rooms
var rooms_are_connected: bool

class LayerData:
	var type: Tile.TILE_TYPE
	var cells: Array[Vector2i]
	
	func _init(_type, _cells):
		type = _type
		cells = _cells

# Do a complete search of all room types
func handle_cell_layout_change() -> void:
	rooms.clear()
	# TODO: Add for the rest of the tile types
	var stone_data = LayerData.new(
		Tile.TILE_TYPE.STONE,
		placement_layer.get_used_cells_by_id(2, Tile.STONE_TILE),
	)
	var grass_data = LayerData.new(
		Tile.TILE_TYPE.GRASS,
		placement_layer.get_used_cells_by_id(2, Tile.GRASS_TILE),
	)
	
	var water_data = LayerData.new(
		Tile.TILE_TYPE.WATER,
		placement_layer.get_used_cells_by_id(2, Tile.WATER_TILE),
	)
	
	var layers : Array[LayerData]
	layers.push_back(stone_data)
	layers.push_back(grass_data)
	layers.push_back(water_data)
	
	for layer in layers:
		var cells = layer.cells
		while len(cells) > 0:
			var coords = cells[0] # initial starting coords
			var result : Array[Vector2i] = do_dfs(coords, cells, [])
			var room : Room = Room.new(layer.type, result)
			rooms.push_front(room)
	
	# Check that all rooms are connected
	# The same logic as above, except we don't separate by room type
	#var all_cells = placement_layer.get_used_cells()
	#var num_rooms = 0
	#while (len(all_cells) > 0):
		#var coords = all_cells[0]
		#do_dfs(coords, all_cells, [])
		#num_rooms += 1
	#rooms_are_connected = num_rooms == 1
	
	# emit a signal with the new rooms
	updated_rooms.emit(rooms)


# This needs to return area as an int beacuse Godot passes primitives by value, not reference
func do_dfs(coords: Vector2i, cells: Array[Vector2i], visited: Array[Vector2i]) -> Array[Vector2i]:
	# TODO: Do we need to check boundaries?
	# Check if the current set of coordinates exists
	if (cells.find(coords) == -1):
		return visited
	
	# When you process a set of coordinates, remove it from cells
	# AND increment area count
	visited.push_front(coords)
	var index = cells.find(coords)
	cells.remove_at(index)
	
	var up = Vector2i(coords.x, coords.y - 1)
	var right = Vector2i(coords.x + 1, coords.y)
	var down = Vector2i(coords.x, coords.y + 1)
	var left = Vector2i(coords.x - 1, coords.y)
	do_dfs(up, cells, visited)
	do_dfs(right, cells, visited)
	do_dfs(down, cells, visited)
	do_dfs(left, cells, visited)

	rooms.push_front(visited)
	return visited
	
