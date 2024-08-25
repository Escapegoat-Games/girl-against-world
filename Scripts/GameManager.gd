extends Node

enum GameState {
	STARTING
	PLAYING
	ENDING
}

const TOTAL_DISTANCE = 1000

var level_speed_scale = 3
var distance = 0
var time_left = 120
var game_state = GameState.STARTING
