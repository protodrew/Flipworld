extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var colliding = false
onready var label = $CanvasLayer/Label
var time = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Wincond_body_entered(body):
	if body.name == "Player":
		label.text = str("You Win!")
	
func _process(delta):
	if time < 1:
		label.add_color_override("font_color", Color(randf(),randf(),randf(), 1))
		time = 20
	time -= 1
	
