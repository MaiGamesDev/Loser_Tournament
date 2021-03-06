extends Node

var keybinds_filepath = "res://Data/keybinds.ini"
var configfile

var keybinds = {}

func _ready():
	configfile = ConfigFile.new()
	if configfile.load(keybinds_filepath) == OK:
		for key in configfile.get_section_keys("keybinds"):
			var key_value = configfile.get_value("keybinds",key)
			print(key, " : ", OS.get_scancode_string(key_value))
			
			keybinds[key] = key_value
	
	else:
		print("CONFIG FILE NOT FOUND")
		get_tree().quit()
		
	set_game_binds()

#바인드 정하기
func set_game_binds():
	for key in keybinds.keys():
		var value = keybinds[key]
		
		var actionlist = InputMap.get_action_list(key)
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])
		
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)
