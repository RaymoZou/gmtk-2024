extends TileMapLayer

@onready var camera : Camera2D = $"../Camera2D"
var TILESHEET_INDEX : int = 2 # this shouldn't change if we're just using 1 spritesheet

# TODO: change this to change the type of block we're placing down
var STONE_TILE : Vector2 = Vector2(6, 5)
#var atlas_coords : Vector2 = Vector2.ZERO
const ZOOM_AMOUNT : float = 0.1

# returns the mouse position in tile coordinates
func get_tile_position() -> Vector2:
	return local_to_map(get_global_mouse_position())
	
# TODO: eemit a signal to update whether conditions are met or not
# TODO: add block placing by left click dragging
# place a block if there is no block at the cursor location
func place_block(position: Vector2):
	var atlas_cell = get_cell_atlas_coords(position)
	if atlas_cell != Vector2i(-1, -1):
		print("there is already a block there!")
	else:
		print("placing block at " + str(position))
		set_cell(position, TILESHEET_INDEX, STONE_TILE)
	
	# TODO: Based on the type of block placed, run the following function to return
	# - Number of rooms of that type
	# - The area of each room
	# - eg. "kitchen: [ 13, 8 ]"
	const room_type_atlas_vec = Vector2i(6,5) # TODO: Set this to the type of block placed
	var cells = $".".get_used_cells_by_id(2, room_type_atlas_vec)
	var num_rooms = find_rooms(cells)
	print("number of rooms", num_rooms)
	
func find_rooms(cells: Array[Vector2i]) -> int:
	var num_rooms = 0
	while len(cells) > 0:
		var coords = cells[0]
		do_dfs(coords, cells)
		num_rooms += 1
	return num_rooms
	
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
	
# remove the block at the cursor position
func remove_block(position: Vector2):
	var atlas_cell = get_cell_atlas_coords(position) # (-1, -1) if there is no tile there
	if atlas_cell == Vector2i(-1, -1):
		print("there is no block to remove")
	else:
		print("block removed!")
		erase_cell(position)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		place_block(get_tile_position())
	
	if Input.is_action_just_pressed("right_mouse"):
		remove_block(get_tile_position())
		
	if Input.is_action_just_pressed("scroll_down"):
		camera.zoom -= Vector2(ZOOM_AMOUNT, ZOOM_AMOUNT)
		
	if Input.is_action_just_pressed("scroll_up"):
		camera.zoom += Vector2(ZOOM_AMOUNT, ZOOM_AMOUNT)
