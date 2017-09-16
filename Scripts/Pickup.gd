
extends Area2D

onready var sprite = get_node("Sprite")
onready var world = get_node("../HUD")
onready var panel = get_node("../HUD/Panel")

export(float) var frequency
export(float) var amplitude

var negasprite
var posisprite
export(String, "Positite", "Neganite") var Pickup

var t = 0

func _ready():
	negasprite = preload("res://Images/Neganite.png")
	posisprite = preload("res://Images/Positite.png")

	if Pickup == "Positite":
		sprite.set_texture(negasprite)
	elif Pickup == "Neganite":
		sprite.set_texture(posisprite)

	set_process(true)
	pass

func _process(delta):
	set_pos(Vector2(get_pos().x, hover()))
	check_mode()
	pass

func hover():
	t += deg2rad(frequency)
	return get_pos().y + (amplitude * sin(t))
	pass

func check_mode():
	if world.world_mode == "Chaos":
		sprite.set_texture(negasprite)
	elif world.world_mode == "Peace":
		sprite.set_texture(posisprite)




func _on_Pickup_body_enter( body ):
	if body.get_name() == "Player":
		world.crystal_panel(true)
		self.queue_free()
	pass # replace with function body
