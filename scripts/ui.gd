extends CanvasLayer

@onready var stone_button : Button = $ButtonContainerUI/Stone
@onready var grass2_button : Button = $ButtonContainerUI/Grass2
@onready var tile_label : RichTextLabel = $ButtonContainerUI/RichTextLabel
@onready var tile_manager : TileMapLayer = $"../PlacementLayer"
@onready var objective_manager = $"../ObjectiveManager"
@onready var objective_label : RichTextLabel = $ObjectivesUI/RichTextLabel

func handle_objectives_updated():
	for objective in objective_manager.objectives:
		if objective.status == Objective.Status.INCOMPLETE:
			objective_label.text = objective.description
		else:
			objective_label.text = objective.description + " (completed)"

func handle_stone():
	print("changing to stone type")
	tile_label.text = "tile: stone"
	tile_manager.curr_tile = Tile.STONE_TILE
	
func handle_grass():
	print("grass type")
	tile_label.text = "tile: grass"
	tile_manager.curr_tile = Tile.GRASS_TILE
