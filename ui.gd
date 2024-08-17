extends Control

@onready var stone_button : Button = $Stone
@onready var grass2_button : Button = $Grass2
@onready var tile_label : RichTextLabel = $RichTextLabel
@onready var tile_manager : TileMapLayer = $"../../Stone"

# TODO: move these consts to the Tile_Manager
const stone_atlas_coords : Vector2 = Vector2(6, 5)
const grass_atlas_coords : Vector2 = Vector2(1, 2)

func handle_stone():
	print("changing to stone type")
	tile_label.text = "tile: stone"
	tile_manager.curr_tile = stone_atlas_coords
	
func handle_grass():
	print("grass type")
	tile_label.text = "tile: grass"
	tile_manager.curr_tile = grass_atlas_coords
