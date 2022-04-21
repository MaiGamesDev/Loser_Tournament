extends KinematicBody

signal player_died

onready var animState = $PlayerAnimTree.get("parameters/playback")

var gravity =  6 * Vector3.DOWN
var speed = 30
var jump_force = 100
var velocity = Vector3.ZERO


func _physics_process(delta):
	get_input(delta)
	velocity += gravity * delta
	move_and_slide(velocity)
	
func get_input(delta):
	# 좌우 움직임
	var vx = 0
	if Input.is_action_pressed("move_right"):
		vx = 1
	if Input.is_action_pressed("move_left"):
		vx = -1
	velocity.x = vx * speed * delta
	if animState.get_current_node() != "walk" and vx != 0:
		animState.travel("walk")
	if animState.get_current_node() == "walk" and vx == 0:
		animState.travel("idle")
	
	# 점프 커맨드
	if Input.is_action_just_pressed("jump"):
		velocity.y = jump_force * delta
	
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
	$Sprite.animation = "idle"
