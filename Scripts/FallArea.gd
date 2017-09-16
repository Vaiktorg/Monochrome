
extends Area2D

onready var player = get_node("../Player")
onready var hud = get_node("../HUD")

func _ready():
	pass



func _on_FallArea_body_enter( body ):
	if body.get_name() == "Player":
		get_tree().reload_current_scene()
		
		
	pass # replace with function body
