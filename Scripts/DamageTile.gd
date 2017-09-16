
extends Area2D

func _on_Area2D_body_enter( body ):
	if body.get_name() == "Player":
		body.set_damage(10)
		body.velocity.y = -body.jumpForce
	pass # replace with function body
