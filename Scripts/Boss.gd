
extends KinematicBody2D

export(float) var amplitude = 10
export(float) var frequency = 12
var t = 0

export var speed = 200

var playerdir = Vector2()
var detected

onready var player = get_node("../Player")
onready var Pos1 = get_node("Pos1")
onready var Pos2 = get_node("Pos2")

func _ready():
	set_process(true)
	pass

func _process(delta):
	var motion = playerdir*speed* delta
	if detected:
		if is_colliding():
			var n = get_collision_normal()
			motion = n.slide(motion)
			playerdir = n.slide(playerdir)
			move(motion)
	
		move(motion)
	else:
		set_pos(Vector2(hover(),get_pos().y))

func _on_Detection_body_enter( body ):
	if body.get_name() == "Player":
		playerdir = -(player.get_pos() - self.get_pos()).normalized()
		detected = true
	pass

func _on_Detection_body_exit( body ):
	detected = false
	pass

func hover():
	t += deg2rad(frequency)
	print(get_pos())
	return get_pos().x + (amplitude * sin(t))
	
func orbit(angle):
	var rotX
	var rotY
	var angle
	var center = self.get_pos()
	var rotator = Pos1.get_pos()
	
	angle = deg2rad(angle)
	
	rotX = cos(angle) * (rotator.x - center.x) - sin(angle) * (rotator.y - center.y) + center.x
	rotY = sin(angle) * (rotator.y - center.y) - cos(angle) * (rotator.x - center.x) + center.y
	
	return Vector2(rotX, rotY)
	
	