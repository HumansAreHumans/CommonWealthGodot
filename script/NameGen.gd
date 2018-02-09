extends Node


static func GenerateName():
	var first = ["Dumb", "Super", "Amaze", "Distant", "Sexy"]
	var last = ["Planet", "World", "Sphere", "", "Bob"]
	return first[randi() % first.size()] + " " + last[randi() % last.size()]