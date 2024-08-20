extends CanvasLayer

@onready var tile_manager : TileMapLayer = $"../PlacementLayer"
@onready var objective_manager = $"../ObjectiveManager"
@onready var objective_label : RichTextLabel = $ObjectivesUI/RichTextLabel

# returns a formatted objective list item
func get_objective_text(objective : Objective) -> String:
	var result : String
	if objective.status == objective.Status.COMPLETE:
		result = "[color=green]" + objective.description + "[/color]"
	else:
		result = objective.description
	result += "\n" # new line
	return result
	
func handle_objectives_updated():
	var objective_text : String = ""
	for objective : Objective in objective_manager.objectives:
		objective_text += get_objective_text(objective)
	objective_label.text = objective_text

func handle_stone():
	#print("changing to stone type")
	tile_manager.curr_tile = Tile.STONE_TILE
	
func handle_grass():
	#print("grass type")
	tile_manager.curr_tile = Tile.GRASS_TILE

func handle_water():
	#print("water type")
	tile_manager.curr_tile = Tile.WATER_TILE
	
func handle_snow():
	tile_manager.curr_tile = Tile.SNOW_TILE
	
func handle_dirt():
	tile_manager.curr_tile = Tile.DIRT_TILE
