class_name Truck extends Vehicle

@onready var sprite_2d: Sprite2D = $Sprite2D

enum TruckType {
	NORMAL,
	TRAILER,
}

var truck_sprites = [
	preload("res://assets/truck.png"),
	preload("res://assets/truck_trailer.png"),
]

func _ready() -> void:
	super._ready()
	randomize_car_texture()
	
func _process(delta: float) -> void:
	super.drive(delta)


func randomize_car_texture() -> void:
	var random_truck_type = TruckType.values()[randi() % TruckType.size()]
	var random_texture = truck_sprites[random_truck_type]
	sprite_2d.texture = random_texture
