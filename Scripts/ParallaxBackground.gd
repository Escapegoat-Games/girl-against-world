extends ParallaxBackground

func _process(delta):
	scroll_offset.x -= GameManager.level_speed * delta
