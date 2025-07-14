extends Node2D

@export var lives = 3
@onready var player = $Player
@onready var hud: HUD = $UI/HUD

var score = 0

func _ready() -> void:
	player.connect("took_damage", _on_took_damage)
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_deathzone_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.die()

func _on_took_damage() -> void:
	lives -= 1
	hud.set_lives_label(lives)
	if lives == 0:
		player.die()

func _on_enemy_killed() -> void:
	score += 100
	hud.set_score_label(score)


func _on_enemy_spawner_enemy_spawned(enemy_instance: Enemy) -> void:
	add_child(enemy_instance)
	enemy_instance.connect("died", _on_enemy_killed)
