
extends Control

export(String) var standaloneText
export(bool) var timed
export(String, "WorldState", "Standalone", "BodyExit", "BodyEnter") var mode
export(String, "FadeIn", "FadeOut") var animType
export(float) var waitTime = 0

export(String) var PeaceText
export(String) var ChaosText

onready var label = get_node("Label")
onready var panel = get_node("Label/Panel")
onready var timer = get_node("Timer")
onready var anim = get_node("AnimationPlayer")
onready var world = get_node("../HUD")

func _ready():
	if mode == "Standalone" or mode == "BodyEnter" or mode == "BodyExit":
		label.set_text(standaloneText)
		panel.set_size(label.get_size())
		
	elif mode == "WorldState":
		if world.world_mode == "Chaos":
			label.set_text(ChaosText)
			panel.set_size(label.get_size())
		else:
			label.set_text(PeaceText)
			panel.set_size(label.get_size())
			

	set_fixed_process(true)
	pass

func _process(delta):
	pass

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		if mode == "BodyEnter" and animType == "FadeIn" and waitTime == 0:
			anim.play("FadeIn")
		elif mode == "BodyEnter" and animType == "FadeOut" and waitTime == 0:
			anim.play("FadeOut")
			
		elif mode == "BodyEnter" and waitTime > 0:
			timer.set_wait_time(waitTime)
			timer.start()

func _on_Area2D_body_exit( body ):
	if body.get_name() == "Player" and animType == "FadeIn":
		anim.play("FadeOut")
	pass # replace with function body


func _on_Timer_timeout():
	if mode == "BodyEnter" and animType == "FadeIn":
		anim.play("FadeIn")
	elif mode == "BodyExit" and animType == "FadeOut":
		anim.play("FadeOut")
		
func destroy():
	self.queue_free()
