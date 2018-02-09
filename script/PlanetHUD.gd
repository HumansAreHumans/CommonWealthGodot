extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_parent().connect("loaded", self, "_loaded_Planet")
	
func _loaded_Planet():
	print(get_parent().PLANET_NAME)
	$Name.text = get_parent().PLANET_NAME