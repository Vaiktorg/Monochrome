
extends Panel

var menuscene = "res://Scenes/Menu.tscn"
var levelone = "res://Scenes/Level1.tscn"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass




func _on_Timer_timeout():
	Transition.fade_to(menuscene)
	GamePoints.game_end = false
	GamePoints.set_player_sanity(100)
	GamePoints.set_neganites(6)
	GamePoints.set_positites(6)
	GamePoints.save_metadata()
	SaveSystem.add_meta("Scene",levelone)
	SaveSystem.save_file()
	pass # replace with function body
