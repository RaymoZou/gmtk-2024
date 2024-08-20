extends Node

class_name ObjectiveManager
@onready var LevelManager : LevelManager = $"../LevelManager"

# just going to have 3 objectives for now - TODO: add a new objective when one is complete
var objectives : Array[Objective]
signal objectives_updated

# 3 area and 2 dimension objectives
func initialize_objectives():
	objectives.clear()
	for i in 2:
		var objective = LevelManager.get_random_dimension_objective()
		objectives.push_front(objective)
	for i in 3:
		var objective = LevelManager.get_random_area_objective()
		objectives.push_front(objective)
		
	objectives_updated.emit()

func _ready():
	initialize_objectives()
	
# returns true if the current objectives are completed
func is_objectives_completed() -> bool:
	for objective : Objective in objectives:
		if objective.status == Objective.Status.INCOMPLETE:
			return false
	initialize_objectives()
	# emit a signal to the LevelManager to load the next level
	return true
	

# TODO: don't need to pass in rooms as a signal parameter (since we
# 		can access as a global variable)
func handle_room_updated(rooms : Array[Room]):
	for objective in objectives:
		objective.check(rooms) # this will update the status of each objective
		
	is_objectives_completed()
	# check if all objectives are completed
	

	objectives_updated.emit()
