extends Node

class_name ObjectiveManager
@onready var LevelManager : LevelManager = $"../LevelManager"

# just going to have 3 objectives for now - TODO: add a new objective when one is complete
var objectives : Array[Objective]
signal objectives_updated
signal objectives_finished

# 3 area and 2 dimension objectives
func get_new_objectives():
	objectives.clear()
	for i in 2:
		var objective = LevelManager.get_random_dimension_objective()
		objectives.push_front(objective)
	for i in 3:
		var objective = LevelManager.get_random_area_objective()
		objectives.push_front(objective)

	objectives_updated.emit()

func _ready():
	get_new_objectives()
	
# returns true if the current objectives are completed
func is_objectives_completed() -> bool:
	for objective : Objective in objectives:
		if objective.status == Objective.Status.INCOMPLETE:
			return false
	return true
	

# TODO: don't need to pass in rooms as a signal parameter (since we
# 		can access as a global variable)
func handle_room_updated(rooms : Array[Room]):
	for objective in objectives:
		objective.check(rooms) # this will update the status of each objective
		
	if is_objectives_completed():
		objectives_finished.emit()
		get_new_objectives()
		# have to update new objectives' status since
		# they could already be completed
		for objective in objectives:
			objective.check(rooms)

	objectives_updated.emit()
