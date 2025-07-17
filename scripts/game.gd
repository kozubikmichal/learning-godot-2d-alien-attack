extends Node2D

@export var lives = 3
@onready var player = $Player
@onready var hud: HUD = $UI/HUD

@onready var enemy_hit_sound = $EnemyHitSound
@onready var explode_sound = $ExplodeSound

var game_over_screen = preload("res://scenes/game_over_screen.tscn")

var score = 0

func _ready() -> void:
	player.connect("took_damage", _on_took_damage)
	hud.set_score_label(score)
	hud.set_lives_label(lives)

func _on_deathzone_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.queue_free()

func _on_took_damage() -> void:
	lives -= 1
	hud.set_lives_label(lives)
	if lives == 0:
		on_game_over()

func _on_enemy_killed() -> void:
	score += 100
	hud.set_score_label(score)
	enemy_hit_sound.play()

func _on_enemy_spawner_enemy_spawned(enemy_instance) -> void:
	add_child(enemy_instance)
	enemy_instance.connect("died", _on_enemy_killed)

func on_game_over() -> void:
	player.die()
	explode_sound.play()
	
	await get_tree().create_timer(1).timeout
	var game_over = game_over_screen.instantiate() as GameOverScreen
	game_over.set_score(score)
	$UI.add_child(game_over)
