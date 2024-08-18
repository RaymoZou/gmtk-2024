extends Node

const AREA = 5

# TODO: iterate through the current quests and rooms
func handle_room_updated(rooms : Array[Room]):
	for room in rooms:
		if room.area >= AREA and room.type == "stone":
			print("there is a stone room with an area of 5!")
		if room.area >= AREA and room.type == "grass":
			print("there is a grass room with an area of 5!")
