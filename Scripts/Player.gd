extends KinematicBody2D

enum State {
	RUNNING
	JUMPING
	SLIDING
}

onready var player_sprite = $PlayerSprite
onready var smoke_sprite = $SmokeSprite
onready var collision_shape = $CollisionShape2D
onready var player_hit_animation_player = $PlayerHitAnimationPlayer
onready var player_hit_timer = $PlayerHitTimer
var gravity = Vector2(0, 1200)
var velocity = Vector2(0, 1)
var jump_time = 0
var is_preparing_jump = false
var state = State.RUNNING
var is_flashing = false

func _process(delta):
	if state == State.RUNNING:
		player_sprite.play("run")
		player_sprite.position.y = 0
		smoke_sprite.visible = false
		player_sprite.position = Vector2(0, 0)
		smoke_sprite.position = Vector2(0, 16)
	elif state == State.JUMPING:
		player_sprite.play("jump")
		smoke_sprite.visible = false
	elif state == State.SLIDING:
		player_sprite.play("slide")
		player_sprite.position = Vector2(-8, -4)
		smoke_sprite.visible = true
		smoke_sprite.position = Vector2(-24, 12)

func _physics_process(delta):
	velocity += gravity * delta
	move_and_slide_with_snap(velocity, Vector2.ZERO, Vector2.UP)
	
	if is_on_floor():
		if Input.is_action_pressed("slide"):
			state = State.SLIDING
			collision_shape.shape.radius = 8
			collision_shape.shape.height = 8
		else:
			state = State.RUNNING
			collision_shape.shape.radius = 8
			collision_shape.shape.height = 16
			
		if Input.is_action_pressed("jump") or Input.is_action_just_pressed("jump"):
			if not is_preparing_jump:
				is_preparing_jump = true
				jump_time = 0
		if is_preparing_jump:
			jump_time += delta
			if Input.is_action_just_released("jump") or jump_time > 0.1:
				state = State.JUMPING
				velocity = Vector2(0, -3000*jump_time)
				print(jump_time)
				is_preparing_jump = false


func _on_Area2D_body_entered(body):
	if not is_flashing:
		GameManager.player_health -= 1
		player_hit_animation_player.play("player_hit")
		is_flashing = true
		player_hit_timer.start()


func _on_PlayerHitTimer_timeout():
	player_hit_animation_player.stop()
	player_sprite.material.set_shader_param("active", false)
	is_flashing = false
