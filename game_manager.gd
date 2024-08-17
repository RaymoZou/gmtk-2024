class_name GameManager

extends Node

const _1x1_PATTERN = Vector2i(0, 0) # 1 stone tile placed at the origin
#const _2x2_PATTERN = [Vector2i(0, 0), Vector2i(0, 1), Vector2i(1, 0), Vector2i(1, 1)] # 2x2 stones

@onready var stone_tilemap : TileMapLayer = $"../Stone"

# called everytime a block/tile is placed
# 2x2 solid
func check_room():
	var cells = stone_tilemap.get_used_cells()
	for cell in cells:
		if stone_tilemap.get_neighbor_cell(cell, TileSet.CELL_NEIGHBOR_RIGHT_SIDE):
			print("there's someone to the right one")

# create a TileMapPattern square with hollow dimensions
# is_hollow_rect(Vector2(2, 2)) will return a 2x2 solid pattern
#func is_hollow_rect(rect: Vector2) -> TileMapPattern:
	#var hollow_rect: Array[Vector2i]
	#for cell in rect:
		#print(cell.x)
	#return null
