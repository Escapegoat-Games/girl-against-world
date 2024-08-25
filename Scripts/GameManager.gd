extends Node

enum GameState {
	TITLE
	STARTING_GAME
	PLAYING_GAME
	ENDING_GAME
	PLAYING_GOOD_END
	PLAYING_BAD_END
}

const TOTAL_DISTANCE = 1000

var level_speed_scale = 3
var distance = 0
var time_left = 120
var game_state = GameState.TITLE


func reset():
	level_speed_scale = 3
	distance = 0
	time_left = 120
	game_state = GameState.TITLE
