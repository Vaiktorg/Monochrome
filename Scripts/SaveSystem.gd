
extends Node

var metadata = {}
var savePath = "res://Saves/SavedGame.txt"

func load_file():
	var file = File.new()
	if !file.file_exists(savePath):
		save_file()
	else:
		file.open(savePath, file.READ)
		metadata.parse_json(file.get_as_text())
		file.close()

func save_file():
	var file = File.new()
	file.open(savePath, file.WRITE)
	file.store_string(metadata.to_json())
	file.close()

func add_meta(from,val):
	metadata[str(from)] = val


func can_load():
	var file = File.new()
	if file.file_exists(savePath):
		return true
	else:
		return false

