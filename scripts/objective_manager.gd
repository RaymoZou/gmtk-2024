extends Node

class_name ObjectiveManager

# just going to have 3 objectives for now - TODO: add a new objective when one is complete
var objectives : Array[Objective]
signal objectives_updated

# only called once
func initialize_objectives():
	# Initialize requirements for level 1
	# Stone
	var stone_requirements: Array[Requirement] = [
		Requirement.AreaRequirement.new(5),
	]
	var stone_objective = Objective.new(
		"Create a Stone room with an area of 5",
		Tile.TILE_TYPE.STONE,
		stone_requirements,
		Objective.Status.INCOMPLETE
		)
	objectives.push_front(stone_objective)
	# Grass
	var grass_requirements: Array[Requirement] = [
		Requirement.AreaRequirement.new(3),
	]
	var grass_objective = Objective.new(
		"Create a Grass room with an area of 3",
		Tile.TILE_TYPE.GRASS,
		grass_requirements,
		Objective.Status.INCOMPLETE
		)
	objectives.push_front(grass_objective)
	# Water
	var water_requirements: Array[Requirement] = [
		Requirement.AreaRequirement.new(8),
	]
	var water_objective = Objective.new(
		"Create a Water room with an area of 8",
		Tile.TILE_TYPE.WATER,
		water_requirements,
		Objective.Status.INCOMPLETE
		)
	objectives.push_front(water_objective)
	objectives_updated.emit()

func _ready():
	initialize_objectives()

# TODO: don't need to pass in rooms as a signal parameter (since we
# 		can access as a global variable)
func handle_room_updated(rooms : Array[Room]):
	for objective in objectives:
		# Filter by rooms for this objective
		var matching_rooms = rooms.filter(func(room: Room): return room.type == objective.room_type)

		for requirement in objective.requirements:
			match requirement.type:
				Requirement.ReqType.AREA:
					check_area(matching_rooms, requirement)
				_: # Default
					pass
	
		# Check if all requirements have been fulfilled
		# Then update objective status as appropriate
		if objective.requirements.all(func(requirement: Requirement): return requirement.complete):
			objective.status = Objective.Status.COMPLETE
		else:
			objective.status = Objective.Status.INCOMPLETE

	objectives_updated.emit()


func check_area(rooms: Array[Room], requirement: Requirement.AreaRequirement):
	var room_found = false
	for room in rooms:
		if room.area >= requirement.area:
			room_found = true
			break
	requirement.complete = room_found
