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

func _process(_delta: float) -> void:
	pass

func drive(delta: float) -> void:
	position.x += direction * self.speed * delta
	var screen_width = get_viewport_rect().size.x
	if position.x < -30 or position.x > screen_width + 30:
		queue_free()

func vehicle_collision(body: Node2D):
	print(body)
