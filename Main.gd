extends Node

export (int) var NUM_PLANETS = 30
const PLANET_SPREAD = 2000

var planets = []
var i = 0
var zoom = 1
var ZOOM_LIMIT = Vector2(1, 1)
var ZOOM_AMOUNT = 0.1

var last_clicked = -1

func _ready():
	for x in range(NUM_PLANETS):
		planets.push_back(spawn_planet())

func spawn_planet():
	var scene = load("res://Planet.tscn")
	var planet_instance = scene.instance()
	planet_instance.ID = i
	planet_instance.set_name("Planet" + str(i))
	planet_instance.position = Vector2(randf() * PLANET_SPREAD - PLANET_SPREAD/2, randf() * PLANET_SPREAD - PLANET_SPREAD/2)
	planet_instance.connect("clicked", self, "_planet_clicked", [i])
	add_child(planet_instance)	
	i += 1
	return planet_instance

func _planet_clicked(idx):
	if last_clicked >= 0:
		planets[last_clicked].add_gate(planets[idx])
	last_clicked = idx
	
func _unhandled_input(event):
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_WHEEL_UP: 
				zoom -= ZOOM_AMOUNT
				if zoom <= ZOOM_LIMIT.x || zoom >= ZOOM_LIMIT.y:
					zoom += ZOOM_AMOUNT
				$Camera.zoom = Vector2(zoom, zoom)
			BUTTON_WHEEL_DOWN:
				zoom += ZOOM_AMOUNT
				if zoom <= ZOOM_LIMIT.x || zoom >= ZOOM_LIMIT.y:
					zoom -= ZOOM_AMOUNT
				$Camera.zoom = Vector2(zoom, zoom)
			
	if event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_MASK_RIGHT):
			$Camera.translate(event.relative * -1 * zoom)

