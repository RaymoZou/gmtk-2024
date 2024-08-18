class_name Room

var type: Tile.TILE_TYPE
var cells: Array[Vector2i] # array of interconnected cells that make up the room
	
func _init(_type, _cells):
	type = _type
	cells = _cells
