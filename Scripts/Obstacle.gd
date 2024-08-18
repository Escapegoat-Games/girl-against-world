extends Area2D

func _physics_process(delta):
	position += Vector2(-GameManager.level_speed, 0) * delta


func _on_DespawnTimer_timeout():
	queue_free()


func _on_Obstacle_area_entered(area):
	if area.is_in_group("player"):
		GameManager.player_health -= 1
