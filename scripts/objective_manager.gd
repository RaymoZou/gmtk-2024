extends Node

class_name ObjectiveManager

# just going to have 3 objectives for now - TODO: add a new objective when one is complete
var objectives : Array[Objective]
signal objectives_updated

# only called once
func initialize_objectives():
	var stone_objective = Objective.new("Create a Stone room with an area of 5", 5, "stone", Objective.Status.INCOMPLETE)
	objectives.push_front(stone_objective)
	var grass_objective = Objective.new("Create a Grass room with an area of 3", 3, "grass", Objective.Status.INCOMPLETE)
	objectives.push_front(grass_objective)
	var water_objective = Objective.new("Create a Water room with an area of 8", 8, "water", Objective.Status.INCOMPLETE)
	objectives.push_front(water_objective)
	objectives_updated.emit()

func _ready():
	initialize_objectives()

# TODO: iterate through the current objectives and rooms
# TODO: don't need to pass in rooms as a signal parameter (since we
# 		can access as a global variable)
func handle_room_updated(rooms : Array[Room]):
	for objective in objectives:
		for room in rooms:
			if room.area >= objective.area and room.type == objective.type:
				objective.status = Objective.Status.COMPLETE
				break # stop here - don't compare to anymore rooms
			else:
				objective.status = Objective.Status.INCOMPLETE
		objectives_updated.emit()
