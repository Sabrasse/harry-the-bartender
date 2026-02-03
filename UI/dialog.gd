extends Control

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var button: Button = $Button

var dialog : Array = ["Text 1",  "Text 2", "Text 3"]
var dialog_index := 0

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	dialog_index += 1
	if dialog_index < dialog.size():
		rich_text_label.text = dialog[dialog_index]
