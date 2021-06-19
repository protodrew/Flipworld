extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var detector = $RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if detector.is_colliding():
		get_tree().reload_current_scene()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
