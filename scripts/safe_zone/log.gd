class_name Log extends Node2D

var speed: int = 0
var direction: int = 1:
	get:
		return direction
	set(value):
		var check_value = value == 1 or value == -1
		assert(check_value, "Direction must be 1 or -1")
		direction = value

var player_on_log: Player = null

func _process(delta: float) -> void:
	swim(delta)

func swim(delta: float) -> void:
	var movement = direction * speed * delta
	position.x += movement
	
	# Move player if on log
	if player_on_log != null:
		player_on_log.position.x += movement
	
	var screen_width = get_viewport_rect().size.x
	if position.x < -30 or position.x > screen_width + 30:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		call_deferred("_handle_body_entered", body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		var player := body
		player_on_log = null
		player.update_safety_status(false)

func _handle_body_entered(body: Node2D) -> void:
	var player := body as Player
	player_on_log = player
	player.update_safety_status(true)
