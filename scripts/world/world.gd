extends Node2D

@export var lilypads: Array[Lilypad]

@onready var ui: UI = $UI
@onready var game_over_container: CenterContainer = $UI/GameOverContainer
@onready var scored_points_label: Label = $UI/GameOverContainer/VBoxContainer/ScoredPointsLabel

var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	set_random_lilypad_positions()
	game_over_container.visible = false

func set_random_lilypad_positions() -> void:
	var lilypad_positions = get_lilypad_positions(10, Vector2(16, 20), 64)
	
	if lilypad_positions.size() < lilypads.size():
		push_error("Not enough positions for all Lilypads!")
		return
	
	for lilypad in lilypads:
		var random_index := rng.randi_range(0, lilypad_positions.size() - 1)
		var random_rotation := rng.randf_range(0, 360)
		lilypad.position = lilypad_positions[random_index]
		lilypad.lilypad_sprite.rotation_degrees = random_rotation
		lilypad_positions.remove_at(random_index)

func get_lilypad_positions(count: int, start: Vector2, step: int) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	for i in range(count):
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
