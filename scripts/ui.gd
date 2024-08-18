extends CanvasLayer

@onready var stone_button : Button = $ButtonContainerUI/Stone
@onready var grass2_button : Button = $ButtonContainerUI/Grass2
@onready var tile_label : RichTextLabel = $ButtonContainerUI/RichTextLabel
@onready var tile_manager : TileMapLayer = $"../PlacementLayer"
@onready var objective_manager = $"../ObjectiveManager"
@onready var objective_label : RichTextLabel = $ObjectivesUI/RichTextLabel

# returns a formatted objective list item
func get_objective_text(objective : Objective) -> String:
	var result : String = objective.description
	if objective.status == objective.Status.COMPLETE:
		result += " (completed)"
	result += "\n" # new line
	return result
	
func handle_objectives_updated():
	var objective_text : String = ""
	for objective : Objective in objective_manager.objectives:
		objective_text += get_objective_text(objective)
	objective_label.text = objective_text

func handle_stone():
	print("changing to stone type")
	tile_label.text = "tile: stone"
	tile_manager.curr_tile = Tile.STONE_TILE
	
func handle_grass():
	print("grass type")
	tile_label.text = "tile: grass"
	tile_manager.curr_tile = Tile.GRASS_TILE
