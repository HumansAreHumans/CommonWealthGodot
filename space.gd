extends Sprite

var time = 0

func _process(delta):
	time += delta
	opacity = sin(time)
