
extends AnimatedSprite

export(float) var speed

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	set_pos(Vector2(get_pos().x + speed * delta,560))


