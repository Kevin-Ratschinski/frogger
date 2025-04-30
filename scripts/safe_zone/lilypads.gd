extends Node2D

signal reached

func _ready() -> void:
	for child in get_children():
		if child.has_signal("lilypad_reached"):
			child.connect("lilypad_reached", _on_lilypad_reached)

func _on_lilypad_reached():
	reached.emit()
	
