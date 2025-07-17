extends Node2D

signal enemy_spawned(enemy_instance: Enemy)
signal path_enemy_spawned(path_enemy_instance)

@onready var timer = $Timer

var enemy_scene = preload("res://scenes/enemy.tscn")
var path_enemy_scene = preload("res://scenes/path_enemy.tscn")

@onready var spawn_positions = $SpawnPositions

func _ready() -> void:
	timer.connect("timeout", _on_timer)

func spanw_enemy() -> void:
	var enemy: Area2D = enemy_scene.instantiate()
	enemy.global_position = spawn_positions\
		.get_children()\
		.pick_random()\
		.global_position
		
	emit_signal("enemy_spawned", enemy)

func spawn_path_enemy() -> void:
	var enemy: PathEnemy = path_enemy_scene.instantiate()
	emit_signal("enemy_spawned", enemy)

func _on_timer() -> void:
	spanw_enemy()


func _on_path_enemy_timer_timeout() -> void:
	spawn_path_enemy()
