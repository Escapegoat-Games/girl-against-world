extends Node2D

onready var obstacles_tileset = $ParallaxBackground/Obstacles/Tileset

const TOTAL_DISTANCE = 1000

func _ready():
	randomize()
	var counter = 12
	var no_box_counter = 0
	while counter < TOTAL_DISTANCE:
		var is_place_box = randi() % 10 == 0
		if no_box_counter > 3 and is_place_box:
			obstacles_tileset.set_cell(counter, 5, 0)
			no_box_counter = 0
		else:
			no_box_counter += 1
		counter += 1
