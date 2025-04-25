extends Node2D

@onready var ui: UI = $UI
@onready var lilypad_1: Lilypad = $Lilypad1
@onready var lilypad_2: Lilypad = $Lilypad2
@onready var lilypad_3: Lilypad = $Lilypad3
@onready var lilypad_4: Lilypad = $Lilypad4
@onready var lilypad_5: Lilypad = $Lilypad5
@onready var game_over_container: CenterContainer = $UI/GameOverContainer
@onready var scored_points_label: Label = $UI/GameOverContainer/VBoxContainer/ScoredPointsLabel

func _ready() -> void:
	set_random_lilypad_positions()
	game_over_container.visible = false

func set_random_lilypad_positions() -> void:
	var lilypad_positions = get_lilypad_positions(20, Vector2(16, 16), 32)
	
	for lilypad: Lilypad in [lilypad_1, lilypad_2, lilypad_3, lilypad_4, lilypad_5]:
		var random_index := randi() % lilypad_positions.size()
		var random_rotation := randf_range(0, 360)
		lilypad.position = lilypad_positions[random_index]
		lilypad.lilypad_sprite.rotation_degrees = random_rotation
		lilypad_positions.remove_at(random_index)

func get_lilypad_positions(count: int, start: Vector2, step: int) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	for i in count:
		positions.append(start + Vector2(step * i, 0))
	return positions

func _on_player_new_max_row_reached() -> void:
	Global.score += 10


func _on_death_zone_left_body_entered(body: Node2D) -> void:
	if body is Player:
		var player := body
		player.reset()


func _on_death_zone_right_body_entered(body: Node2D) -> void:
	if body is Player:
		var player := body
		player.reset()


func _on_player_game_over() -> void:
	var scored_points_text:= "You have scored: %s points" % Global.score
	scored_points_label.text = scored_points_text
	game_over_container.visible = true
