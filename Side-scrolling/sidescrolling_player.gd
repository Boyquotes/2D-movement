extends CharacterBody2D


@onready var anim_player = $Graphics/AnimationPlayer

@export var move_speed = 250
@export var jump_force = -500

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = true


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	velocity.x = Input.get_axis("move_left", "move_right") * move_speed
	move_and_slide()
	
	if facing_right and velocity.x < 0:
		flip()
	elif not facing_right and velocity.x > 0:
		flip()
	
	if velocity == Vector2.ZERO:
		anim_player.play("idle")
	else:
		anim_player.play("walk")


func flip():
	$Graphics.scale.x *= -1
	facing_right = not facing_right
