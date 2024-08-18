class_name Objective

var description : String
var area : int
var type : String # get this from Tile.gd
var status : Status
enum Status {INCOMPLETE, COMPLETE}

func _init(_description, _area, _type, _status):
	description = _description
	area = _area
	type = _type
	status = _status
