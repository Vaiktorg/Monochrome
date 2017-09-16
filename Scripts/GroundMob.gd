
extends KinematicBody2D

var detected
var t = 0
var velocity = Vector2(0,10)
var motion

export var amplitude = 10
export var frequency = 12
export var speed = 600

onready var body = get_node("Body")
onready var player = get_node("../Player")

func _ready():
	set_process(true)
	pass

func _process(delta):
	if Input.is_action_pressed("Jump"):
		velocity = Vector2(0,20)
	
	motion = velocity * delta * speed
	move(motion)
	if detected:
		pass
		move(Vector2(player.get_pos().x - get_pos().x,0).normalized()*delta*speed)
	else:
		body.set_pos(Vector2(0, hover()))
	pass

func hover():
	t += deg2rad(frequency)
	return (amplitude * sin(t))


func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		detected = true
	else:
		detected = false
	pass # replace with function body


func _on_Damage_body_enter( body ):
	if body.get_name() == "Player":
		GamePoints.remove_player_sanity(20)
		self.queue_free()
	pass # replace with function body
