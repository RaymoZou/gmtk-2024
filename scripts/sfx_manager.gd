extends AudioStreamPlayer

# add all the SFX that need to be played
@export var block_place : Resource

func _ready() -> void:
	print("this is sfx manager")
	
func handle_block_placed():
	play_sfx(block_place)
	
func play_sfx(sfx : Resource):
	stream = sfx
	play()
