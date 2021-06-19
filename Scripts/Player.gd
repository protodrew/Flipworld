extends KinematicBody2D

const gravity = 50
const gravthres = 1200
const hspeed = 300
const jumpspeed = -600

var facingright = true
var gravdir = 1
var velocity =  Vector2.ZERO
var vspeed = 0;
var jumps = 1

onready var animp = $AnimationPlayer
onready var sprite = $Sprite


func _physics_process(delta):
	
	# Horizontal input handling
	var movedir = 0
	sprite.scale = Vector2(1,gravdir)
	if Input.is_action_pressed("move_left"):
		movedir = -1
	if Input.is_action_pressed("move_right"):
		movedir = 1
	
	if movedir < 0 and facingright:
		flip()
	if movedir > 0 and !facingright:
		flip()
	
	velocity = move_and_slide(Vector2(movedir * hspeed, vspeed), Vector2(0, -1))
	
	# Vertical input handling
	vspeed += gravity * gravdir
	var gravcheck = is_on_floor() or is_on_ceiling()
	
	if gravcheck:
		jumps = 1
		vspeed = 5 * gravdir
		if movedir == 0:
			play_anim("Idle")
		else:
			play_anim("Run")
			
	
	if Input.is_action_just_pressed("switch"):
		vspeed = 0
		gravdir *= -1
	
	if Input.is_action_just_pressed("jump"):
		if gravcheck:
			vspeed = jumpspeed * gravdir
		elif jumps >= 1:
			vspeed = jumpspeed * gravdir
			jumps = 0
			
	if !gravcheck:
		match gravdir:
			1:
				if vspeed < 0:
					play_anim("Jump")
				else:
					play_anim("Fall")
			-1:
				if vspeed > 0:
					play_anim("Jump")
				else:
					play_anim("Fall")
	
	if vspeed > gravthres:
		vspeed = gravthres
	if vspeed < -gravthres:
		vspeed = -gravthres
	
func flip():
	facingright = !facingright
	sprite.flip_h = !sprite.flip_h

func play_anim(anim_name):
	if animp.is_playing() and animp.current_animation == anim_name:
		return
	animp.play(anim_name)
