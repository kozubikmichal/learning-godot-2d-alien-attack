extends Path2D

class_name PathEnemy

@onready var pathfollow: PathFollow2D = $PathFollow2D
@onready var enemy = $PathFollow2D/Enemy

signal died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pathfollow.set_progress_ratio(1)
	enemy.connect("died", on_enemy_died)

func on_enemy_died() -> void:
	emit_signal("died")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pathfollow.progress_ratio -= 0.25 * delta
	
	if (pathfollow.progress_ratio <= 0 && enemy):
		enemy.queue_free()
