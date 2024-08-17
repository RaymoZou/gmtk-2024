extends TileMapLayer

@onready var camera : Camera2D = $"../Camera2D"
var TILESHEET_INDEX : int = 0 # this shouldn't change if we're just using 1 spritesheet
var tile_index : Vector2 = Vector2.ZERO
const ZOOM_AMOUNT : float = 0.1

# converts the mouse position to tile coordinates
func get_tile_position() -> Vector2:
	return local_to_map(get_global_mouse_position())
	
# TODO: update whether conditions are met or not
func place_block(position: Vector2):
	print("placing block at " + str(position))
	set_cell(position, TILESHEET_INDEX, Vector2.ZERO)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		place_block(get_tile_position())
	
	if Input.is_action_just_pressed("right_mouse"):
		print("removing block at " + str(get_tile_position()))
		erase_cell(get_tile_position())
		
	if Input.is_action_just_pressed("scroll_down"):
		camera.zoom -= Vector2(ZOOM_AMOUNT, ZOOM_AMOUNT)
		
	if Input.is_action_just_pressed("scroll_up"):
		camera.zoom += Vector2(ZOOM_AMOUNT, ZOOM_AMOUNT)
