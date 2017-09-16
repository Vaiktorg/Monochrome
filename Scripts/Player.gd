
extends RigidBody2D

export(float) var health = 100

var playerState = {previous = "", current = "", next= "ground"}

export var jumpForce = 2
export var playerMinSpeed = 200
export var playerMaxSpeed = 500
var playerSpeed = playerMinSpeed
export var playerAcceleration = 5
export var playerAirAcceleration = 5
export var extra_gravity = 900

onready var world = get_node("..")
onready var collision = get_node("CollisionShape2D")
onready var raycast = get_node("RayCast2D")
onready var sprite = get_node("AnimatedSprite")

var direction = Vector2()
var xaxis
var currenty
var input_state = preload("res://Scripts/input_states.gd")

var currentSpeed = Vector2(0,0)
var input = {btnRight = input_state.new("Right"),
btnLeft = input_state.new("Left"),
btnJump = input_state.new("Jump"),
btnSprint = input_state.new("Sprint")}
#----------------------------------------------------------
func _ready():
	set_applied_force(Vector2(0,-extra_gravity))
	raycast.add_exception_rid(self)
	set_fixed_process(true)# Initialization here
	set_process_input(true)
	pass
#----------------------------------------------------------
func _input(event):
	if event.is_action_pressed("SwitchMode"):
		if self.get_collision_mask_bit(0): #PeaceTiles True
			self.set_collision_mask_bit(1,true) #ChaosTile True
			self.set_collision_mask_bit(0,false) #PeaceTile False
			world.world_mode = "Chaos"
		elif self.get_collision_mask_bit(1): #Chaos Tiles True
			self.set_collision_mask_bit(0,true) #PeaceTile True
			self.set_collision_mask_bit(1,false) #ChaosTile False
			world.world_mode = "Peace"
		printt(self.get_collision_mask(), get_collision_mask_bit(0), "Peace" )
		printt(self.get_collision_mask(), get_collision_mask_bit(1), "Chaos" )
	pass
#----------------------------------------------------------
func _fixed_process(delta):
	playerState.previous = playerState.current
	playerState.current = playerState.next
	
	xaxis = (input.btnRight.is_pressed() - input.btnLeft.is_pressed())
	direction = Vector2(xaxis,0)

	if playerState.current == "ground":
		ground_state(delta)
	elif playerState.current == "air":
		air_state(delta)
#----------------------------------------------------------
func ground_state(delta):
	if input.btnRight.check() == 2:
		move(playerSpeed,playerAcceleration,delta)
	elif input.btnLeft.check() == 2:
		move(-playerSpeed,playerAcceleration,delta)
	else:
		move(0,playerAcceleration,delta)

	if is_on_ground():
		if input.btnJump.check() == 1:
			set_axis_velocity(Vector2(0, -jumpForce))
	else:
		 playerState.next = "air"

#----------------------------------------------------------
func air_state(delta):
	if input.btnRight.check() == 2:
		move(playerSpeed,playerAirAcceleration,delta)
	elif input.btnLeft.check() == 2:
		move(-playerSpeed,playerAirAcceleration,delta)
	else:
		move(0,playerAcceleration,delta)

	if is_on_ground():
		playerState.next = "ground"
#----------------------------------------------------------

func is_on_ground():
	if raycast.is_colliding():
		return true
	else:
		return false
	pass
#----------------------------------------------------------
func move(speed, acceleration, delta):
	currentSpeed.x = lerp(currentSpeed.x, speed, acceleration * delta)
	set_linear_velocity(Vector2(currentSpeed.x, get_linear_velocity().y))
	pass
#----------------------------------------------------------
func set_damage(damage):
	printt("damage", health)
	if health > 0:
		health -= damage
	elif (health - damage) <= 0:
		health = 0
#----------------------------------------------------------