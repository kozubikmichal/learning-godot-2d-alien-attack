extends CharacterBody2D

class_name Player

signal took_damage

@export var speed: float = 300.0

@onready var rocket_container: Node = $RocketContainer
@onready var rocket_shot_sound = $RocketShotSound

var screen_size: Vector2
var rocket_scene: PackedScene = preload("res://scenes/rocket.tscn")

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func clamp_position() -> void:
	global_position = global_position.clamp(Vector2(0, 0), screen_size)

func shoot() -> void:
	var rocket: Area2D = rocket_scene.instantiate()
	rocket.global_position.x = global_position.x + 75
	rocket.global_position.y = global_position.y
	
	rocket_container.add_child(rocket)
	rocket_shot_sound.play()

func _physics_process(delta: float) -> void:
	velocity = speed * Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	move_and_slide()
	clamp_position()

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("shoot")):
		shoot()

func take_damage() -> void:
	emit_signal("took_damage")
	
func die() -> void:
	queue_free()
