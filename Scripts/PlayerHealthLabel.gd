extends Label

func _process(delta):
	text = "Distance: %s" % [GameManager.distance]
