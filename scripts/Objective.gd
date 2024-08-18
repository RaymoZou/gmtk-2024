"""
An Objective is specific to a room type. Each Objective can have one or more Requirements, each of which is specific to a constraint (eg. area).
"""

class_name Objective

var description : String
var room_type : Tile.TILE_TYPE
var requirements : Array[Requirement]
var status : Status
enum Status {INCOMPLETE, COMPLETE}

func _init(_description, _room_type, _requirements, _status,):
	description = _description
	room_type = _room_type
	requirements = _requirements
	status = _status
