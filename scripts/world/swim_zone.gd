class_name SwimZone extends Area2D


@onready var player: Player = %Player

var player_inside: bool = false
var has_reset: bool = false

func _process(_delta: float) -> void:
	if player_inside and not has_reset:
		if not player.is_player_safe():
			player.reset()
			has_reset = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside = true
		has_reset = false

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside = false
