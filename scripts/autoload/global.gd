extends Node

signal score_changed
signal lives_changed

var score: int = 0:
	set(value):
		if score != value:
			score = value
			score_changed.emit(score)

var lives: int = 5:
	set(value):
		if lives != value:
			lives = value
			lives_changed.emit(lives)
