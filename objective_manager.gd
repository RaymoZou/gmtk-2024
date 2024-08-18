class_name ObjectiveManager

extends Node

# just going to have 3 objectives for now - TODO: add a new objective when one is complete
var objectives : Array[Objective]
signal objectives_updated

# only called once
func initialize_objectives():
	var stone_objective = Objective.new("Create a Stone room with an area of 5", 5, "stone", Objective.Status.INCOMPLETE)
	objectives.push_front(stone_objective)
	var grass_objective = Objective.new("Create a Grass room with an area of 3", 3, "grass", Objective.Status.INCOMPLETE)
	objectives.push_front(grass_objective)
	objectives_updated.emit()

func _ready():
	initialize_objectives()

# TODO: iterate through the current quests and rooms
func handle_room_updated(rooms : Array[Room]):
	for room in rooms:
		for objective in objectives:
			if room.area >= objective.area and room.type == objective.type:
				print("objective complete!")
				objective.status = Objective.Status.COMPLETE
				objectives_updated.emit()
