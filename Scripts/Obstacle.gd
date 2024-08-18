extends Area2D

const SPEED = 3

func _physics_process(delta):
	position += Vector2(-SPEED, 0)


func _on_DespawnTimer_timeout():
	queue_free()
