extends Node2D

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("blink_enter")

func _input(event):
	if Input.is_action_pressed("start_game"):
		GameManager.game_state = GameManager.GameState.STARTING_GAME
		get_tree().change_scene("res://Scenes/Game.tscn")
