extends Sprite

signal resource_selected

var current_planet_info = null

func set_gateway_info(info):
	if info == null:
		return
	
	current_planet_info = info
	# Gate must have a destination
	$DestinationName.set_text(info["dst"].PLANET_NAME)
	
	# Gate optionally has a resource
	if info["rsc"]:
		$ResourceSent.play(info["rsc"])

func _ready():
	_hide_change_resource()
	$ChangeResourceHUD.connect("resource_selected", self, "_set_resource_sent")
	pass

func _on_Area2D_input_event( viewport, event, shape_idx ):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		_show_change_resource()

func _set_resource_sent(resource):
	$ResourceSent.play(resource)
	emit_signal("resource_selected", resource, current_planet_info)
	_hide_change_resource()
	
func _show_change_resource():
	$ResourceSent.hide()
	$ChangeResourceHUD.show()

func _hide_change_resource():
	$ResourceSent.show()
	$ChangeResourceHUD.hide()
