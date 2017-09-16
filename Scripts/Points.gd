
extends Node


var player_sanity = 100
var neganites = 4
var positites = 4

var metadata = {}

var game_end = false

#-------------------------------------------------------------------------------------------------------

func _ready():
	set_process(true)

func _process(delta):
	check_game_points(delta)
	check_game_end()
	pass

#-------------------------------------------------------------------------------------------------------
func set_player_sanity(val):
	player_sanity = val

func add_player_sanity(val):
	player_sanity += val

func remove_player_sanity(val):
	player_sanity -= val

func get_player_sanity():
	if !player_sanity == null:
		return player_sanity
	else:
		return 0

#-------------------------------------------------------------------------------------------------------
func set_positites(val):
	positites = val

func add_positites(val):
	positites += val

func remove_positites(val):
	positites -= val

func get_positites():
	if positites == null:
		return 0
	else:
		return positites

#-------------------------------------------------------------------------------------------------------
func set_neganites(val):
	neganites = val

func add_neganites(val):
	neganites += val

func remove_neganites(val):
	neganites -= val

func get_neganites():
	if neganites == null:
		return 0
	else:
		return neganites

#-------------------------------------------------------------------------------------------------------

func save_metadata():
	metadata["Sanity"] = player_sanity
	metadata["Neganites"] = neganites
	metadata["Positites"] = positites

	SaveSystem.add_meta("Points",metadata)

func load_metadata(meta):
	player_sanity = meta.Points.Sanity
	positites = meta.Points.Positites
	neganites = meta.Points.Neganites
	
#-------------------------------------------------------------------------------------------------------

func check_game_points(delta):
	if neganites <= 0 or positites <= 0:
		remove_player_sanity(10 * delta)
	pass
	
#-------------------------------------------------------------------------------------------------------

func check_points():
	if positites > 0 and neganites > 0:
		return true
	else:
		return false
		
#-------------------------------------------------------------------------------------------------------

func check_game_end():
	if game_end == false and player_sanity <= 0:
		Transition.fade_to("res://Scenes/YouFailed.tscn")
		game_end = true