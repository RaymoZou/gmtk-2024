class_name Quest

var description : String
var area : int
var tile_type : Vector2 # get this from Tile.gd

func _init(description, area, tile_type):
	description = description
	area = area
	tile_type = tile_type
