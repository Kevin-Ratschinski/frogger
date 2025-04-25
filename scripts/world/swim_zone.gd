class_name SwimZone extends Area2D


@onready var player: Player = %Player

var player_inside: bool = false
var has_reset: bool = false

func _process(_delta: float) -> void:
	if player_inside and not has_reset:
		if not player.is_player_safe():
			play_splash_particles(player.global_position)
			player.reset()
			has_reset = true

func play_splash_particles(player_pos: Vector2) -> void:
	var splash_particles = preload("res://scenes/effects/splash_particles.tscn").instantiate()
	splash_particles.global_position = player_pos
	get_tree().current_scene.add_child(splash_particles)
	splash_particles.one_shot = true
	splash_particles.emitting = true
	
	var lifetime = splash_particles.lifetime
	await get_tree().create_timer(lifetime + 0.5).timeout
	splash_particles.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_inside = true
		has_reset = false

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_inside = false
