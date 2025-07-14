extends Area2D

class_name Enemy

signal died

@export var speed = 200

func _physics_process(delta: float) -> void:
	global_position.x -= delta * speed

func die() -> void:
	emit_signal("died")
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage()
		die()
