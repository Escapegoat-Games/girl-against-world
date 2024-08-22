extends Node2D

export(PackedScene) var  obstacle_scene
onready var obstacle_spawner_timer = $ObstacleSpawnerTimer

func _ready():
	randomize()

func _on_ObstacleSpawnerTimer_timeout():
	var obstacle = obstacle_scene.instance()
	obstacle.position = Vector2(192, 108 - 24)
	add_child(obstacle)
	
	obstacle_spawner_timer.wait_time = 2 * randf() + 1
