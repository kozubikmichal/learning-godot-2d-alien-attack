extends Node2D

@onready var timer = $Timer

var enemy_scene = preload("res://scenes/enemy.tscn")

@onready var spawn_positions = $SpawnPositions

func _ready() -> void:
	timer.connect("timeout", _on_timer)

func spanw_enemy() -> void:
	var enemy: Area2D = enemy_scene.instantiate()
	enemy.global_position = spawn_positions\
		.get_children()\
		.pick_random()\
		.global_position
		
	add_child(enemy)

func _on_timer() -> void:
	spanw_enemy()
