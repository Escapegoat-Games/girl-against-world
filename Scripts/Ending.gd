extends Node2D

onready var ending_label = $CanvasLayer/HUD/Label
onready var anim_player = $AnimationPlayer

func _ready():
	ending_label.text = ""
	if GameManager.game_state == GameManager.GameState.PLAYING_GOOD_END:
		anim_player.play("good_end")
	if GameManager.game_state == GameManager.GameState.PLAYING_BAD_END:
		anim_player.play("bad_end") 

func _on_AnimationPlayer_animation_finished(anim_name):
	GameManager.reset()
	get_tree().change_scene("res://Scenes/Title.tscn")
