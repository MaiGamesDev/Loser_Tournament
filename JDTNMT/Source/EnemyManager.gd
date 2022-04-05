extends KinematicBody

signal enemy_died

var gravity =  1 * Vector3.DOWN
var speed = 30
var velocity = Vector3.ZERO

var move_state = "stop"

func _physics_process(delta):
	get_velocity_vx(delta)
	velocity += gravity * delta
	move_and_slide(velocity)
	

func get_velocity_vx(delta):
	var vx = 0
	if move_state == "right":
		vx = 1
	if move_state == "left":
		vx = -1
	velocity.x = vx * speed * delta

func die():
	emit_signal("enemy_died")
	queue_free()

func _on_Detectbox_body_entered(body):
	if body.name == "Player":
		move_state = "right"

func _on_Detectbox_body_exited(body):
	if body.name == "Player":
		move_state = "stop"

func _on_HurtHit_area_entered(area):
	if area.name == "PlayerAttackHit":
		die()
