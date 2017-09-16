extends KinematicBody2D

export var sanity = 100
export var max_speed = 300
var speed = 0
export var GRAVITY = 980
export var jump_force = 700
export(float) var acceleration = 20

var xaxis
var velocity = Vector2()

var on_ground
var playerState = {previous = "", current = "", next = "ground"}

var metadata = {}

onready var world = get_node("../HUD")
onready var raycast = get_node("RayCast2D")
onready var raycast1 = get_node("RayCast2D1")
onready var raycast2 = get_node("RayCast2D2")

onready var sprite = get_node("AnimatedSprite")
#----------------------------------------------------------
func _ready():
	raycast.add_exception(self)
	set_process_input(true)
	set_process(true)
#----------------------------------------------------------
func _input(event):
	if event.is_action_pressed("SwitchMode"):
		if GamePoints.check_points():
			if world.world_mode == "Peace": #PeaceTiles True
				self.set_collision_mask_bit(1,true) #ChaosTile True
				self.set_collision_mask_bit(0,false) #PeaceTile False
				GamePoints.remove_neganites(1)
				world.world_mode = "Chaos"
			elif world.world_mode == "Chaos": #Chaos Tiles True
				self.set_collision_mask_bit(0,true) #PeaceTile True
				self.set_collision_mask_bit(1,false) #ChaosTile False
				GamePoints.remove_positites(1)
				world.world_mode = "Peace"
	pass

	if is_on_ground():
		if event.is_action_pressed("Jump"):
				velocity.y = -jump_force
				playerState.next = "air"
		else:
			playerState.next = "air"
#----------------------------------------------------------
func _process(delta):
	playerState.previous = playerState.current
	playerState.current = playerState.next

	xaxis = Input.is_action_pressed("Right") - Input.is_action_pressed("Left")
	velocity.y += delta * GRAVITY * 2

	if speed >= max_speed:
		speed = max_speed
	if velocity.x <= -max_speed:
		velocity.x = -max_speed

	if playerState.current == "ground":
		ground_state(delta)
	elif playerState.current == "air":
		air_state(delta)

	check_animation()
#----------------------------------------------------------
func is_on_ground():
	if raycast.is_colliding() or raycast1.is_colliding() or raycast2.is_colliding():
		return true
	else:
		return false
#----------------------------------------------------------
func ground_state(delta):
	if xaxis == 1:
		speed += acceleration
		velocity.x = speed
	elif xaxis == -1:
		speed += acceleration
		velocity.x = -speed
	else:
		if velocity.x < 0: velocity.x += acceleration
		elif velocity.x > 0: velocity.x -= acceleration
		elif velocity.x == 0:
			velocity.x = 0

	var motion = velocity * delta
	motion = move(motion)

	if is_colliding():
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
#----------------------------------------------------------
func air_state(delta):
	if xaxis == 1:
		speed += acceleration
		velocity.x = speed
	elif xaxis == -1:
		speed += acceleration
		velocity.x = -speed
	else:
		if velocity.x < 0: velocity.x += acceleration
		elif velocity.x > 0: velocity.x -= acceleration
		elif velocity.x == 0:
			velocity.x = 0

	var motion = velocity * delta
	motion = move(motion)

	if is_on_ground():
		playerState.next = "ground"
#----------------------------------------------------------
func check_animation():
	var current_dir
	var last_dir

	if xaxis == 1:
		current_dir = "Right"
	elif xaxis == -1:
		current_dir = "Left"
	else:
		current_dir = last_dir

	last_dir = current_dir

	if current_dir == "Right":
		sprite.play("Walking")
		sprite.set_flip_h(false)
	elif current_dir == "Left":
		sprite.play("Walking")
		sprite.set_flip_h(true)
	else:
		sprite.play("Idle")
#----------------------------------------------------------
