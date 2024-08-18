extends TileMapLayer

signal cell_layout_changed()

const TILESHEET_INDEX : int = 2 # this shouldn't change if we're just using 1 spritesheet
var curr_tile : Vector2 = Tile.STONE_TILE # Default to stone tile

var highlighted_cell : Vector2 = Vector2.ZERO # cell the mouse is currently over
const HIGHLIGHTER_TILE : Vector2 = Vector2(9, 8) # atlas of the highlight sprite
@onready var ui_layer : TileMapLayer = $UILayer

# returns the mouse position in tile coordinates
func get_tile_position() -> Vector2:
	return local_to_map(get_global_mouse_position())
	
func is_empty(coords: Vector2) -> bool:
	return get_cell_atlas_coords(coords) == Vector2i(-1, -1) 

# helper function that determines whether or not a given
# cell coords is valid
# 1) cell must be empty
# 2) adjacent cells must not be empty
func has_neighbors(coords: Vector2) -> bool:
	var has_neighbors : bool = false
	for cell in get_surrounding_cells(coords):
		if not is_empty(cell):
			has_neighbors = true
	return has_neighbors

# TODO: add block placing by left click dragging
# takes in a cell coordinates and places the curr_tile there
func place_block(coords: Vector2):
	if has_neighbors(coords) and is_empty(coords):
		set_cell(coords, TILESHEET_INDEX, curr_tile)	
		cell_layout_changed.emit() # Emit signal that cell layout has changed
	else:
		print("cannot place tile!")
		
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var coords : Vector2 = local_to_map(get_global_mouse_position())
		if has_neighbors(coords) and is_empty(coords):
			highlighted_cell = coords
			ui_layer.clear()
			ui_layer.set_cell(highlighted_cell, TILESHEET_INDEX, HIGHLIGHTER_TILE)
			
	
# remove the tile at the cursor position
func remove_block(coords: Vector2):
	var atlas_cell = get_cell_atlas_coords(coords) # (-1, -1) if there is no tile there
	if atlas_cell == Vector2i(-1, -1):
		print("there is no block to remove")
	else:
		erase_cell(coords)
		cell_layout_changed.emit() # Emit signal that cell layout has changed
