extends AnimatedSprite

var active = false
signal select_gate

var target_node = null
func SetDestinationPlanet(node):
	play("active")
	target_node = node

func _on_Area2D_mouse_entered():
#	play("active")
	pass

func _on_Area2D_mouse_exited():
#	play("used" if active else "unused")
	pass

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		#play("active")
		emit_signal("select_gate", target_node)
	
