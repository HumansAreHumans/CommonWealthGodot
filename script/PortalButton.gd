extends AnimatedSprite

signal wanted_link

var active = false

func _on_Area2D_mouse_entered():
	play("active")

func _on_Area2D_mouse_exited():
	play("used" if active else "unused")

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		play("active")
		emit_signal("wanted_link")

