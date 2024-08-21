extends KinematicBody2D

enum State {
	RUNNING
	JUMPING
	SLIDING
}

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D
var gravity = Vector2(0, 4000)
var velocity = Vector2(0, 1)
var jump_time = 0
var is_preparing_jump = false
var state = State.RUNNING

func _process(delta):
	if state == State.RUNNING:
		sprite.play("run")
	elif state == State.JUMPING:
		sprite.play("jump")
	elif state == State.SLIDING:
		sprite.play("slide")

func _physics_process(delta):
	velocity += gravity * delta
	move_and_slide_with_snap(velocity, Vector2.ZERO, Vector2.UP)
	
	if is_on_floor():
		if Input.is_action_pressed("slide"):
			state = State.SLIDING
			collision_shape.shape.radius = 26
			collision_shape.shape.height = 40
			sprite.position.y = -18
		else:
			state = State.RUNNING
			collision_shape.shape.radius = 26
			collision_shape.shape.height = 76
			sprite.position.y = 0
			
		if Input.is_action_pressed("jump") or Input.is_action_just_pressed("jump"):
			if not is_preparing_jump:
				is_preparing_jump = true
				jump_time = 0
		if is_preparing_jump:
			jump_time += delta
			if Input.is_action_just_released("jump") or jump_time > 0.1:
				state = State.JUMPING
				velocity = Vector2(0, -10000*jump_time)
				print(jump_time)
				is_preparing_jump = false
