extends Label

func _process(delta):
	text = "Health: %s" % GameManager.player_health
