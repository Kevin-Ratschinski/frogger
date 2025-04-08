extends Node2D

@export var log_scene: PackedScene
@export var max_logs: int = 10
@export var speed: int = 50
@export_enum("Left: -1", "Right: 1") var direction: int = 1
@export_range(0.5, 3.0) var min_spawn_interval: float = 1.2
@export_range(0.5, 5.0) var max_spawn_interval: float = 5.0

var lane_width: float = 32.0

@onready var logs: Node2D = $Logs
@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	spawn_log()
	spawn_timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	spawn_log()
	spawn_timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)

func spawn_log() -> void:
	assert(log_scene, "No log scene added")
	
	if logs.get_child_count() >= max_logs:
		return
	
	var log_: Log = log_scene.instantiate()
	logs.add_child(log_)
	
	var screen_width = get_viewport_rect().size.x
	var start_x = -20.0 if direction == 1 else screen_width + 20
	
	log_.position = Vector2(start_x, lane_width / 2)
	log_.speed = speed
	log_.direction = direction
	if direction == -1:
		log_.scale = Vector2(-1, -1)
