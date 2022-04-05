extends KinematicBody

signal player_died

onready var animState = $PlayerAnimTree.get("parameters/playback")

var gravity =  1 * Vector3.DOWN
var speed = 30
var velocity = Vector3.ZERO


func _physics_process(delta):
	get_input(delta)
	velocity += gravity * delta
	move_and_slide(velocity)
	
func get_input(delta):
	# X 좌표 움직임
	var vx = 0
	if Input.is_action_pressed("move_right"):
		vx = 1
	if Input.is_action_pressed("move_left"):
		vx = -1
	velocity.x = vx * speed * delta
	
	# 공격 커맨드
	if Input.is_action_just_pressed("light_punch"):
		left_jab()
	
func left_jab():
	animState.travel("left_jab")
	
func die():
	emit_signal("player_died")
	
func enable_PlayerAttackHit():
	$PlayerAttackHit.show()
	$PlayerAttackHit.monitorable = true
	

func disable_PlayerAttackHit():
	$PlayerAttackHit.hide()
	$PlayerAttackHit.monitorable = false

func go_idle():
	disable_PlayerAttackHit()
