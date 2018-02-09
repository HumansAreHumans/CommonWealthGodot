extends Area2D
export (String, "small", "medium", "large") var PLANET_TYPE = "medium"

signal added_gate
signal clicked

const PLANET_TYPES = ["small", "medium", "large"]

var GATES = []
export (int) var GATE_LIMIT = 3
export (int, "RESOURCE_ONE", "RESOURCE_TWO", "RESOURCE_THREE") var PRODUCES = 0
export (int, "UNIT_ONE", "UNIT_TWO", "UNIT_THREE") var CONSUMES = 0

var units = {
	"r1": 0,
	"r2": 0,
	"r3": 0,
	"u1": 0,
	"u2": 0,
	"u3": 0
}

func add_gate(node):
	var active = GATES.size()
	if active >= GATE_LIMIT:
		return
	
	GATES.push_back(node)
	get_node("Gate" + active).add_point(node.translation)
	emit_signal("added_gate", node)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		emit_signal("clicked", event.is_pressed())
		
func _ready():
	PLANET_TYPE = PLANET_TYPES[randi() % 3]
	$Type.animation = PLANET_TYPE

func _process(delta):
	for i in range(GATES.size()):
		get_node("Gate" + i).set_point_position(i, GATES[i].translation)
		
