
extends Position2D

var player
var instance

func _ready():
	player = load("res://MiniScenes/Player.tscn")
	pass
	
func spawn():
	instance = player.instance()
	get_parent().add_child(instance)
	instance.set_pos(self.get_pos())


