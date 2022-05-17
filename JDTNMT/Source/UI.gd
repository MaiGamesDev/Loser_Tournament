extends Control


var keybinds_filepath = "res://Data/keybinds.ini"

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			var action_name = ""
			action_name = get_actionname_from_scancode(event.scancode)
			if action_name != "":
				if action_name!= $InputState.text:
					$InputState/InputState2.text = $InputState.text.to_lower()
					$InputState.text = action_name.to_upper()
				

func get_actionname_from_scancode(scancode):
	var configfile = ConfigFile.new()
	if configfile.load(keybinds_filepath) == OK:
		for key in configfile.get_section_keys("keybinds"):
			var key_value = configfile.get_value("keybinds",key)
			if scancode == key_value:
				return key
	return ""
				
func _on_player_died():
	$TopUI/Scoreboard/Score/EnemyScore.text = str(int($TopUI/Scoreboard/Score/EnemyScore.text) + 1)


func _on_Enemy_died():
	$TopUI/Scoreboard/Score/PlayerScore.text = str(int($TopUI/Scoreboard/Score/PlayerScore.text) + 1)
