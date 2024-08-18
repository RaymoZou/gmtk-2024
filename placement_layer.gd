extends TileMapLayer

signal block_placed()

var TILESHEET_INDEX : int = 2 # this shouldn't change if we're just using 1 spritesheet
var curr_tile : Vector2 = Tile.STONE_TILE # Default to stone tile

# returns the mouse position in tile coordinates
func get_tile_position() -> Vector2:
	return local_to_map(get_global_mouse_position())
	
# TODO: add block placing by left click dragging
# place a block if there is no block at the cursor location
func place_block(position: Vector2):
	var atlas_cell = get_cell_atlas_coords(position)
	if atlas_cell != Vector2i(-1, -1):
		print("there is already a block there!")
	else:
		#print("placing block at " + str(position))
		set_cell(position, TILESHEET_INDEX, curr_tile)
	# Emit signal that the blocks have changed
	block_placed.emit()
	
	
# remove the block at the cursor position
func remove_block(position: Vector2):
	var atlas_cell = get_cell_atlas_coords(position) # (-1, -1) if there is no tile there
	if atlas_cell == Vector2i(-1, -1):
		print("there is no block to remove")
	else:
		#print("block removed!")
		erase_cell(position)
