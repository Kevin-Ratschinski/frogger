class_name UI extends CanvasLayer

@onready var game_over_label: Label = $GameOverContainer/VBoxContainer/GameOverLabel
@onready var life_label: Label = $MarginContainer/HBoxContainer/LifeLabel
@onready var score_label: Label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var restart_button: Button = $GameOverContainer/VBoxContainer/MarginContainer/RestartButton

func _ready() -> void:
	update_ui()
	Global.score_changed.connect(_on_score_changed)
	Global.lives_changed.connect(_on_lives_changed)

func update_ui() -> void:
	life_label.text = "Lives: %d" % Global.lives
	score_label.text = "Score: %04d" % Global.score

func _on_score_changed(new_score) -> void:
	score_label.text = "Score: %04d" % new_score

func _on_lives_changed(new_lives) -> void:
	life_label.text = "Lives: %d" % new_lives

func _on_restart_button_pressed() -> void:
	# Restart Game
	Global.score = 0
	Global.lives = 5
	get_tree().reload_current_scene()
