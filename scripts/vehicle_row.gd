extends Node2D

@export var vehicle_scene: PackedScene
@export var max_vehicles: int = 6
@export var speed: int = 150
@export var direction: int = 1
@export var spawn_intervall: float = 2.0

var lane_width: float = 32.0

@onready var vehicles: Node2D = $Vehicles
@onready var spawn_timer: Timer = $SpawnTimer

func _ready() -> void:
	spawn_timer.wait_time = spawn_intervall
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	spawn_car()

func spawn_car() -> void:
	assert(vehicle_scene, "No vehicle scene added")
	
	if vehicles.get_child_count() >= max_vehicles:
		return
	
	var vehicle: Vehicle = vehicle_scene.instantiate()
	vehicles.add_child(vehicle)
	
	var screen_width = get_viewport_rect().size.x
	var start_x = -20 if direction == 1 else screen_width + 20
	
	vehicle.position = Vector2(start_x, lane_width / 2)
	vehicle.speed = speed
	vehicle.direction = direction
	if direction == -1:
		vehicle.scale = Vector2(-1, -1)
	
