extends Node2D

# Takes node that the gate was added to, and the number of existing gates
var GateButtons = []

func _ready():
	get_parent().connect("loaded", self, "_loaded_Planet")
	get_parent().connect("added_gate", self, "_added_gate")

func _added_gate(node, numGates):
	GateButtons[numGates].SetDestinationPlanet(node)

func _loaded_Planet(numGates):
	print(get_parent().PLANET_NAME)
	$Name.text = get_parent().PLANET_NAME
	var portalButton = load("res://scene/PortalButton.tscn")
	for x in numGates:
		var portalButtonInst = portalButton.instance()
		portalButtonInst.position = Vector2(x * 10, 0)
		add_child(portalButtonInst)
		GateButtons.push_back(portalButtonInst)
