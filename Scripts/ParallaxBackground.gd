extends ParallaxBackground

func _process(delta):
	scroll_offset.x -= 100 * GameManager.level_speed_scale * delta
	GameManager.distance = -scroll_offset.x / 16
