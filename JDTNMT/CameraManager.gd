extends Camera

var camera_rotate_yv = 0

	
func _process(delta):
	if camera_rotate_yv != 0:
		var max_y = 6
		var value = clamp(rotation_degrees.y + camera_rotate_yv, -max_y, max_y)
		$Tween.interpolate_property(self, "rotation_degrees:y", rotation_degrees.y, value, 0.8,$Tween.TRANS_QUINT, $Tween.EASE_OUT)
		$Tween.start()


func _on_Player_LeftNotifler_screen_exited():
	camera_rotate_yv = 1


func _on_Player_RightNOtifler_screen_exited():
	camera_rotate_yv = -1

func _on_Player_LeftNotifler_screen_entered():
	camera_rotate_yv = 0
	
func _on_Player_RightNOtifler_screen_entered():
	camera_rotate_yv = 0


