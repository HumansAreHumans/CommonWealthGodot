extends Sprite

signal resource_selected
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func _on_Area2D_input_event( viewport, event, shape_idx, resource ):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		emit_signal("resource_selected", resource)
