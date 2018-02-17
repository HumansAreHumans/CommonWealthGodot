extends Sprite

func _ready():
	_hide_change_resource()
	$ChangeResourceHUD.connect("resource_selected", self, "_set_resource_sent")
	pass

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		_show_change_resource()

func _set_resource_sent(resource):
	$ResourceSent.play(resource)
	_hide_change_resource()
	
func _show_change_resource():
	$ResourceSent.hide()
	$ChangeResourceHUD.show()

func _hide_change_resource():
	$ResourceSent.show()
	$ChangeResourceHUD.hide()
