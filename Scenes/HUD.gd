extends Control

onready var distance_progress_bar = $DistanceProgressBar
onready var seconds_left_label = $SecondsLeftLabel
onready var anim_player = $AnimationPlayer
var is_blinking_time = false

func _process(delta):
	var seconds_left = int(GameManager.time_left)
	
	distance_progress_bar.value = 100 * float(GameManager.distance) / GameManager.TOTAL_DISTANCE
	seconds_left_label.text = "%s" % [seconds_left]
	
	if seconds_left < 10 and not is_blinking_time:
		anim_player.play("blink_time")
