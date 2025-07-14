extends Control

class_name HUD

@onready var score = $Score
@onready var livesLeft = $LivesLeft

func set_score_label(new_score: int) -> void:
	score.text = "Score: " + str(new_score)

func set_lives_label(new_lives: int) -> void:
	livesLeft.text = str(new_lives)
