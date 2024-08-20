extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/StartButton.grab_focus() # So that the player can use keyboard navigation
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_button_up() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()
