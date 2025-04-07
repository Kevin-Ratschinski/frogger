class_name Car extends Vehicle

@onready var sprite_2d: Sprite2D = $Sprite2D

enum CarType {
	RED,
	GREEN,
	BLUE
}

var car_sprites = [
	preload("res://assets/sprites/car_red.png"),
	preload("res://assets/sprites/car_green.png"),
	preload("res://assets/sprites/car_blue.png"),
]

func _ready() -> void:
	super._ready()
	randomize_car_texture()
	
func _process(delta: float) -> void:
	super.drive(delta)


func randomize_car_texture() -> void:
	var random_car_type = CarType.values()[randi() % CarType.size()]
	var random_texture = car_sprites[random_car_type]
	sprite_2d.texture = random_texture
