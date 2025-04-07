class_name Vehicle extends Node2D

var speed: int = 0
var direction: int = 1:
	get:
		return direction
	set(value):
		var check_value = value == 1 or value == -1
		assert(check_value, "Direction must be 1 or -1")
		direction = value

func _ready() -> void:
	var area_2d: Area2D = get_node_or_null("Area2D")
	if area_2d:
		area_2d.connect("body_entered", vehicle_collision)

func drive(delta: float) -> void:
	position.x += direction * self.speed * delta
	var screen_width = get_viewport_rect().size.x
	if position.x < -30 or position.x > screen_width + 30:
		queue_free()

func vehicle_collision(body: Node2D) -> void:
	if body is Player:
		play_death_particles(body.global_position)
		reset_player(body)

func play_death_particles(player_pos: Vector2) -> void:
	var death_particles = preload("res://death_particles.tscn").instantiate()
	death_particles.global_position = player_pos
	get_tree().current_scene.add_child(death_particles)
	death_particles.one_shot = true
	death_particles.emitting = true
	
	var lifetime = death_particles.lifetime
	await get_tree().create_timer(lifetime + 0.5).timeout
	death_particles.queue_free()

func reset_player(player: Player) -> void:
	player.set_process(false)
	await get_tree().create_timer(0.2).timeout
	Global.lives -= 1
	if Global.lives > 0:
		player.reset_player()
		player.set_process(true)
	else:
		player.queue_free()
