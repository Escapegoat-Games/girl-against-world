extends Node2D

onready var obstacles_tileset = $ParallaxBackground/Obstacles/Tileset
onready var parallax_background = $ParallaxBackground
onready var level_anim_player = $LevelAnimationPlayer

func _ready():
	randomize()
	var counter = 12
	var no_box_counter = 0
	while counter < GameManager.TOTAL_DISTANCE:
		var is_place_box = randi() % 10 == 0
		if no_box_counter > 5 and is_place_box:
			obstacles_tileset.set_cell(counter, 5, 0)
			no_box_counter = 0
		else:
			no_box_counter += 1
		counter += 1
	
	level_anim_player.play("start_level")

func _process(delta):
	if GameManager.game_state == GameManager.GameState.PLAYING_GAME:
		GameManager.time_left = clamp(GameManager.time_left - delta, 0, 200)
		
		parallax_background.scroll_offset.x -= 100 * GameManager.level_speed_scale * delta
		GameManager.distance = -parallax_background.scroll_offset.x / 16
		
		if GameManager.distance >= GameManager.TOTAL_DISTANCE:
			GameManager.game_state = GameManager.GameState.ENDING_GAME
			var anim = level_anim_player.get_animation("end_level")
			anim.track_set_key_value(1, 0, parallax_background.scroll_offset)
			anim.track_set_key_value(1, 1, parallax_background.scroll_offset - Vector2(32, 0))
			level_anim_player.play("end_level")


func _on_StartLevelAnimationPlayer_animation_finished(anim_name):
	if anim_name == "start_level":
		GameManager.game_state = GameManager.GameState.PLAYING_GAME
	elif anim_name == "end_level":
		if GameManager.time_left > 0:
			GameManager.game_state = GameManager.GameState.PLAYING_GOOD_END
		else:
			GameManager.game_state = GameManager.GameState.PLAYING_BAD_END
		get_tree().change_scene("res://Scenes/Ending.tscn")
