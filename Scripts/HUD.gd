
extends CanvasLayer

export(float) var shake_amount

var world_mode = "Peace" setget set_audio

export(String, FILE, "*.tscn") var new_scene

var metadata = {}

onready var sanitylevel = get_node("Sanity")
onready var posititelevel = get_node("Positite/Label")
onready var neganitelevel = get_node("Neganite/Label")
onready var crystalpanel = get_node("Panel")

onready var chaostiles = get_node("../ChaosTiles")
onready var peacetiles = get_node("../PeaceTiles")
onready var negative = get_node("NEGATIVE")
onready var bg = get_node("../ParallaxBackground/FullBG/Sprite")
onready var camera = get_node("../Player/Camera2D")

onready var chaosMusic = get_node("../ChaosMusic")
onready var peaceMusic = get_node("../PeaceMusic")

onready var player = get_node("../Player")

func _ready():
	set_process(true)

	pass
#------------------------Process----------------------------------
func _process(delta):
	if world_mode == "Chaos":
		camera.set_offset(Vector2(rand_range(-1,1) * shake_amount, rand_range(-1,1) * shake_amount))
		GamePoints.remove_player_sanity(3 * delta)
		pass
	elif world_mode == "Peace":
		camera.set_offset(Vector2(0,0))
		pass
		
	GamePoints.check_game_points(delta)
	
	posititelevel.set_text(str(GamePoints.get_positites()))
	neganitelevel.set_text(str(GamePoints.get_neganites()))
	sanitylevel.set_value(GamePoints.get_player_sanity())
#----------------------------------------------------------
func crystal_panel(Bool):
	if Bool == true:
		get_tree().set_pause(true)
		crystalpanel.show()
	else:
		get_tree().set_pause(false)
		crystalpanel.hide()

#----------------------------------------------------------
func _on_PosiBtn_pressed():
	GamePoints.positites += 2
	get_tree().set_pause(false)
	crystalpanel.hide()

	GamePoints.save_metadata()
	SaveSystem.add_meta("Scene",new_scene)
	SaveSystem.save_file()

	Transition.fade_to(new_scene)
	pass
#----------------------------------------------------------
func _on_NegBtn_pressed():
	GamePoints.neganites += 2
	get_tree().set_pause(false)
	crystalpanel.hide()

	GamePoints.save_metadata()
	SaveSystem.add_meta("Scene",new_scene)
	SaveSystem.save_file()

	Transition.fade_to(new_scene)
	pass
#----------------------------------------------------------
func set_audio(val):
	if val == "Chaos":
		peaceMusic.stop()
		chaosMusic.play(0)

		peacetiles.hide()
		chaostiles.show()

		negative.show()
		bg.set_animation("Chaos")
		world_mode = val

	elif val == "Peace":
		chaosMusic.stop()
		peaceMusic.play(0)

		peacetiles.show()
		chaostiles.hide()

		negative.hide()
		bg.set_animation("Peace")
		world_mode = val
#----------------------------------------------------------

