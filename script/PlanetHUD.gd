extends Node2D

signal portal_link

# Takes node that the gate was added to, and the number of existing gates
var GateButtons = []

func _ready():
	get_parent().connect("loaded", self, "_loaded_Planet")
	get_parent().connect("added_gate", self, "_added_gate")

func _added_gate(node, numGates):
	GateButtons[numGates].SetDestinationPlanet(node)

func _loaded_Planet(numGates):
	$Name.text = get_parent().PLANET_NAME
	var produces = get_parent().PRODUCES 
	var consumes = get_parent().CONSUMES
	consumes[0] = "u"
	$r1/Resource.play(produces)
	$r2/Resource.play(consumes)
	var portalButton = load("res://scene/PortalButton.tscn")
	for x in numGates:
		var portalButtonInst = portalButton.instance()
		portalButtonInst.position = Vector2(x * 10, 0)
		add_child(portalButtonInst)
		GateButtons.push_back(portalButtonInst)
		portalButtonInst.connect("select_gate", self, "_selected_gate")

	
func _on_Portal_wanted_link():
	emit_signal("portal_link")

func _selected_gate(destination):
	if destination == null:
		$GatewayInfoHUD.hide()
		return
	
	#var gate = get_parent().GetGateTo(destination)
	#if gate == null:
	#	return
	
	#$GatewayInfoHUD.SetGatewayInf(gate)
	$GatewayInfoHUD.show()
