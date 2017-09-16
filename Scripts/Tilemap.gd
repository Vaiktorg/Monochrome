
extends TileMap
onready var player = get_node("../Player")
var damagetile = get_tileset().tile_get_name(8)

func _ready():
	set_process(true)
	pass


