extends VBoxContainer

@onready var quest1 : RichTextLabel = $RichTextLabel
#@onready var quest2 : RichTextLabel = $RichTextLabel
#@onready var quest3 : RichTextLabel = $RichTextLabel

func _ready() -> void:
	quest1.text = "Create a stone area of 4"
