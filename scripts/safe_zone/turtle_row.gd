extends Node2D

@export var turtle_scene: PackedScene
@export var max_turtles: int = 10
@export var speed: int = 70
@export_enum("Left: -1", "Right: 1") var direction: int = 1
@export_range(0.5, 3.0) var min_spawn_interval: float = 1.2
@export_range(0.5, 5.0) var max_spawn_interval: float = 5.0

var lane_width: float = 32.0

@onready var turtles: Node2D = $Turtles
@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	spawn_turtle()
	spawn_timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	spawn_turtle()
	spawn_timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)

func spawn_turtle() -> void:
	assert(turtle_scene, "No turtle scene added")
	
	if turtles.get_child_count() >= max_turtles:
		return
	
	var turtle: Turtle = turtle_scene.instantiate()
	turtles.add_child(turtle)
	
	var screen_width = get_viewport_rect().size.x
	var start_x = -20.0 if direction == 1 else screen_width + 20
	
	turtle.position = Vector2(start_x, lane_width / 2)
	turtle.speed = speed
	turtle.direction = direction
	if direction == -1:
		turtle.scale = Vector2(-1, -1)
