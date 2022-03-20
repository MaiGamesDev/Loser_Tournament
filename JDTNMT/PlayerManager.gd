extends KinematicBody

var gravity =  1 * Vector3.DOWN
var speed = 30
var velocity = Vector3.ZERO


func _physics_process(delta):
	get_input(delta)
	velocity += gravity * delta
	move_and_slide(velocity)
	

func get_input(delta):
	var vx = 0
	
	if Input.is_action_pressed("move_right"):
		vx = 1
	if Input.is_action_pressed("move_left"):
		vx = -1
	velocity.x = vx * speed * delta


