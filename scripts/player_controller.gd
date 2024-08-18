extends Node

@onready var tilemap_layer : TileMapLayer = $"../PlacementLayer"
@onready var camera : Camera2D = $"../PlayerCamera"
const ZOOM_AMOUNT : float = 0.3 # camera zoom speed
const PAN_SPEED : float = 150 # camera pan speed

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_down"):
		camera.position.y += PAN_SPEED * delta
		
	if Input.is_action_pressed("ui_up"):
		camera.position.y -= PAN_SPEED * delta
		
	if Input.is_action_pressed("ui_left"):
		camera.position.x -= PAN_SPEED * delta
		
	if Input.is_action_pressed("ui_right"):
		camera.position.x += PAN_SPEED * delta
		
	if Input.is_action_pressed("ui_select"):
		camera.position = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		var tile_coords : Vector2 = tilemap_layer.get_tile_position()
		tilemap_layer.place_block(tile_coords)
	
	if event.is_action_pressed("right_mouse"):
		var tile_coords : Vector2 = tilemap_layer.get_tile_position()
		tilemap_layer.remove_block(tile_coords)
		
	# camera zoom
	if event.is_action_pressed("scroll_down"):
		camera.zoom -= Vector2(ZOOM_AMOUNT, ZOOM_AMOUNT)
		
	if event.is_action_pressed("scroll_up"):
		camera.zoom += Vector2(ZOOM_AMOUNT, ZOOM_AMOUNT)
