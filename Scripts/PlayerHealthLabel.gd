extends Label

func _process(delta):
	text = "Distance: %s\nTime Left: %s" % [GameManager.distance, GameManager.time_left]
