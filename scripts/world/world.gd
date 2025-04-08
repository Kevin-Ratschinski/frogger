extends Node2D

@onready var ui: UI = $UI

func _on_player_new_max_row_reached() -> void:
	Global.score += 10


func _on_death_zone_left_body_entered(body: Node2D) -> void:
	if body is Player:
		var player := body
		player.reset()


func _on_death_zone_right_body_entered(body: Node2D) -> void:
	if body is Player:
		var player := body
		player.reset()
