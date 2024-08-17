extends Control

@onready var stone_button : Button = $Stone
@onready var grass2_button : Button = $Grass2
@onready var tile_label : RichTextLabel = $RichTextLabel
@onready var tile_manager : TileMapLayer = $"../../Stone"

func handle_stone():
	print("changing to stone type")
	tile_label.text = "tile: stone"
	tile_manager.curr_tile = tile_manager.STONE_TILE
	
func handle_grass():
	print("grass type")
	tile_label.text = "tile: grass"
	tile_manager.curr_tile = tile_manager.GRASS_TILE
