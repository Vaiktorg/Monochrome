
extends Area2D

onready var collision = get_node("CollisionShape2D")
var player
export(float) var damage_per_second

func _ready():
	set_process(true)
	pass

func _process(delta):
	if player != null:
		player.set_damage(damage_per_second * delta)
	pass

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		player = body
	pass # replace with function body
