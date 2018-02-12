extends Node2D

signal portal_link

func _ready():
	get_parent().connect("loaded", self, "_loaded_Planet")

func _loaded_Planet():
	$Name.text = get_parent().PLANET_NAME
	var produces = get_parent().PRODUCES 
	var consumes = get_parent().CONSUMES
	consumes[0] = "u"
	$r1/Resource.play(produces)
	$r2/Resource.play(consumes)
	
func _on_Portal_wanted_link():
	emit_signal("portal_link")
