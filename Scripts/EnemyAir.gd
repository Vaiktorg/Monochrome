
extends KinematicBody2D

onready var wings = get_node("Wings")
onready var player = get_node("../Player")

var playerpos
var t = 0
var detected
var degrees = 0
var velocity = Vector2()
var motion

export var rotspeed = 10
export var amplitude = 10
export var frequency = 12
export var speed = 10
export var damage = 20

#onready var target = get_node("Player").get_position_in_parent()

func _ready():
	set_process(true)
	pass

func _process(delta):
	rotate()
	velocity = Vector2(player.get_pos()-get_pos()).normalized()
	motion = Vector2(velocity) * speed * delta
	if detected:
		move(motion)
		printt(motion.x, motion.y)
	else:
		set_pos(Vector2(get_pos().x, hover()))
	pass

func _on_Area2D_body_enter( body):
	if body.get_name() == "Player":
		print(detected)
		detected = true

func _on_Area2D_body_exit( body ):
	if body.get_name() == "Player":
		detected = false
		print(detected)

func rotate():
	if degrees >= 360:
		degrees = 0
	wings.set_rotd(degrees)
	degrees += rotspeed

func hover():
	t += deg2rad(frequency)
	return get_pos().y + (amplitude * sin(t))

func _on_Damage_body_enter( body ):
	if body.get_name() == "Player":
		GamePoints.remove_player_sanity(10)
		self.queue_free()
	pass # replace with function body
