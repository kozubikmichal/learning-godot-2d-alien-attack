extends CharacterBody2D

@export var speed: float = 300.0

var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func clamp_position() -> void:
	global_position = global_position.clamp(Vector2(0, 0), screen_size)
	
func _physics_process(delta: float) -> void:
	velocity = speed * Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	move_and_slide()
	clamp_position()
