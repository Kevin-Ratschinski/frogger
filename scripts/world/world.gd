extends Node2D

@onready var ui: UI = $UI

func _on_player_new_max_row_reached() -> void:
	Global.score += 10
