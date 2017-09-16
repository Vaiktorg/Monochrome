
extends Node2D

export(String, FILE, "*.tscn") var Level

func _ready():
	if SaveSystem.can_load():
		SaveSystem.load_file()
		GamePoints.load_metadata(SaveSystem.metadata)
	pass




func _on_Play_pressed():
	if SaveSystem.can_load():
		Transition.fade_to(SaveSystem.metadata.Scene)
	else:
		print(Level)
		Transition.fade_to(Level)
	pass # replace with function body


func _on_Exit_pressed():
	get_tree().quit()
	pass # replace with function body
