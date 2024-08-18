extends Node

class_name ObjectiveManager

# just going to have 3 objectives for now - TODO: add a new objective when one is complete
var objectives : Array[Objective]
signal objectives_updated

# only called once
func initialize_objectives():
	# Initialize objectives for level 1
	# Stone
	var stone_objective = Objective.AreaObjective.new(
		"Create a Stone room with an area of 5",
		Tile.TILE_TYPE.STONE,
		5,
		)
	objectives.push_front(stone_objective)
	# Grass
	var grass_objective = Objective.AreaObjective.new(
		"Create a Grass room with an area of 3",
		Tile.TILE_TYPE.GRASS,
		3,
		)
	objectives.push_front(grass_objective)
	# Water
	var water_objective = Objective.AreaObjective.new(
		"Create a Water room with an area of 8",
		Tile.TILE_TYPE.WATER,
		8,
		)
	objectives.push_front(water_objective)
	objectives_updated.emit()

func _ready():
	initialize_objectives()

# TODO: don't need to pass in rooms as a signal parameter (since we
# 		can access as a global variable)
func handle_room_updated(rooms : Array[Room]):
	for objective in objectives:
		objective.check(rooms)

	objectives_updated.emit()
