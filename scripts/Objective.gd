"""
An Objective is specific to a room type and has a specific type that indicates what type of Objective it is (eg. AreaObjective)

All Objectives should implement _init and check methods
"""

class_name Objective

var description : String
var room_type : Tile.TILE_TYPE
var type: ObjectiveType
var status : Status

enum ObjectiveType { AREA }
enum Status {INCOMPLETE, COMPLETE}

class AreaObjective extends Objective:
	var area: int

	func _init(_description, _room_type, _area) -> void:
		description = _description
		room_type = _room_type
		type = ObjectiveType.AREA
		status = Status.INCOMPLETE
		area = _area

	func check(rooms: Array[Room]) -> void:
		var room_found = false
		for room in rooms:
			if room.area >= area and room.type == room_type:
				room_found = true
				break
		status = Status.COMPLETE if room_found else Status.INCOMPLETE
