extends Area2D
export (String, "small", "medium", "large") var PLANET_TYPE = "medium"

signal added_gate
signal clicked

const PLANET_TYPES = ["small", "medium", "large"]

var GATES = []
export (int) var ID = 0
export (int) var GATE_LIMIT = 3
export (int, "RESOURCE_ONE", "RESOURCE_TWO", "RESOURCE_THREE") var PRODUCES = 0
export (int, "UNIT_ONE", "UNIT_TWO", "UNIT_THREE") var CONSUMES = 0

var clicked = false
var units = {
	"r1": 0,
	"r2": 0,
	"r3": 0,
	"u1": 0,
	"u2": 0,
	"u3": 0
}

	
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
	emit_signal("added_gate", node)
	
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
		
func _ready():
	set_process_input(true)
	PLANET_TYPE = PLANET_TYPES[randi() % 3]
	$Type.animation = PLANET_TYPE

func _process(delta):
	for i in range(GATES.size()):
		get_node("Gate" + str(i)).set_point_position(1, GATES[i].position - position)
		
