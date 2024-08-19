extends KinematicBody2D

onready var sprite = $Sprite
var gravity = Vector2(0, 4000)
var velocity = Vector2(0, 1)
var jump_time = 0
var is_preparing_jump = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if is_on_floor():
		sprite.play("run")
	else:
		sprite.play("jump")


func _physics_process(delta):
	velocity += gravity * delta
	move_and_slide_with_snap(velocity, Vector2.ZERO, Vector2.UP)
	
	if is_on_floor():
		if Input.is_action_pressed("jump") or Input.is_action_just_pressed("jump"):
			if not is_preparing_jump:
				is_preparing_jump = true
				jump_time = 0
		if is_preparing_jump:
			jump_time += delta
			if Input.is_action_just_released("jump") or jump_time > 0.1:
				velocity = Vector2(0, -10000*jump_time)
				print(jump_time)
				is_preparing_jump = false
