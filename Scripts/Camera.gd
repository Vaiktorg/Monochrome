
extends Camera2D


export(float) var shake_amount


func _ready():
	set_process(true)
	pass

func _process(delta):
	print(get_mode())
	if world.get_mode() == "Chaos":
		print("stuffer")
		self.set_offset(Vector2(rand_range(-1.0, 1.0) * shake_amount, rand_range(-1.0, 1.0) * shake_amount))
	elif world.get_mode() == "Peace":
		print("stuff")
		self.set_offset(Vector2(0,0))