extends Node2D

@export var vehicle_scene: PackedScene
@export var max_vehicles: int = 6
@export var speed: int = 150
@export_enum("Left: -1", "Right: 1") var direction: int = 1
@export_range(0.5, 3.0) var min_spawn_interval: float = 1.0
@export_range(0.5, 5.0) var max_spawn_interval: float = 3.0

var lane_width: float = 32.0

@onready var vehicles: Node2D = $Vehicles
@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	spawn_car()
	spawn_timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	spawn_car()
	spawn_timer.wait_time = randf_range(min_spawn_interval, max_spawn_interval)

func spawn_car() -> void:
	assert(vehicle_scene, "No vehicle scene added")
	
	if vehicles.get_child_count() >= max_vehicles:
		return
	
	var vehicle: Vehicle = vehicle_scene.instantiate()
	vehicles.add_child(vehicle)
	
	var screen_width = get_viewport_rect().size.x
	var start_x = -20 if direction == 1 else screen_width + 20
	
	var y_offset = randf_range(-2, 2)
	vehicle.position = Vector2(start_x, lane_width / 2 + y_offset)
	vehicle.speed = speed
	vehicle.direction = direction
	if direction == -1:
		vehicle.scale = Vector2(-1, -1)
	
