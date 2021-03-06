extends Area2D

var NameGen = preload("res://script/NameGen.gd")

signal loaded
signal added_gate
signal clicked
signal produced
signal consumed
signal portal_link

const PLANET_TYPES = ["small", "medium", "large"]

var GATES = []
export (String, "small", "medium", "large") var PLANET_TYPE = "medium"
export (int) var ID = 0
export (int) var GATE_LIMIT_MAX = 4
export (int) var GATE_LIMIT_MIN = 1
export (int) var GATE_LIMIT = 3
export (String) var PLANET_NAME = ""
export var PRODUCES = "r1"
export var CONSUMES = "r1"

var clicked = false
var gate_transfers = {
	0: null,
	1: null,
	2: null,
	3: null,
	4: null,
	5: null	
}
var units = {
	"r1": 0,
	"r2": 0,
	"r3": 0,
	"u1": 0,
	"u2": 0,
	"u3": 0
}

func get_gate_info(destination):
	if destination == null:
		return
		
	var idx = GATES.find(destination)
	if idx == -1:
		return
		
	return {
		"dst": destination,
		"rsc": gate_transfers[idx] 
	}

func take(unitType, amount):
	units[unitType] += amount

func add_gate(node, propogate = true):
	var active = GATES.size()
	if active >= GATE_LIMIT:
		return
	
	if node == self:
		return
		
	if node in GATES:
		return
	
	GATES.push_back(node)
	get_node("Gate" + str(active)).add_point(node.position - position)
	emit_signal("added_gate", node, GATES.size() - 1)
	print("added gate from " + PLANET_NAME + " to " + node.PLANET_NAME)
	
	if propogate:
		node.add_gate(self, false)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		clicked = event.is_pressed()
		if event.is_pressed():
			emit_signal("clicked")

func _unhandled_input(event):
	if event is InputEventMouseMotion and clicked:
		var Camera = get_node("/root/Main/Camera")
		translate(event.relative)
	
	if event is InputEventMouseButton \
		and event.button_index == BUTTON_LEFT \
		and clicked \
		and !event.is_pressed():
		clicked = false
		
# TODO figure out how to make library functions
func randi_range(minval, maxval):
	var delta = maxval - minval
	return (randi() % (delta + 1)) + minval

func _ready():
	PLANET_NAME = NameGen.GenerateName()
	set_process_input(true)
	PLANET_TYPE = PLANET_TYPES[randi() % 3]
	CONSUMES = "r%d" % (randi() % 3 + 1)
	PRODUCES = "r%d" % (randi() % 3 + 1)
	while PRODUCES == CONSUMES:
		PRODUCES = "r%d" % (randi() % 3 + 1)

	$Type.animation = PLANET_TYPE
	GATE_LIMIT = randi_range(GATE_LIMIT_MIN, GATE_LIMIT_MAX)
	emit_signal("loaded", GATE_LIMIT)

func _process(delta):
	for i in range(GATES.size()):
		get_node("Gate%d" % i).set_point_position(1, GATES[i].position - position)

func _on_ProduceConsume_timeout():
	units[PRODUCES] += 1
	if units[CONSUMES] > 0:
		units[CONSUMES] -= 1
		var toProduce = 'u' + CONSUMES[1]
		units[toProduce] += 1

func _on_GateTransfer_timeout():
	for i in range(GATES.size()):
		var item = gate_transfers[i]
		if item && units[item] > 0:
			units[item] -= 1
			GATES[i].take(item, 1)

func _on_PlanetHUD_portal_link():
	emit_signal("portal_link")

func _on_PlanetHUD_resource_selected(resource, current_planet_info):
	var gateidx = GATES.find(current_planet_info["dst"])
	if gateidx == -1:
		return
	
	gate_transfers[gateidx] = resource
	print("now transfering " + resource + " from " + current_planet_info["dst"].PLANET_NAME)
