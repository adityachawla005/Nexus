extends CharacterBody2D

@export var speed := 100
var direction := Vector2.ZERO
var current_facing := "south"

func _ready():
	$AnimatedSprite2D.play("idle south")
	$Camera2D.make_current()

func _physics_process(_delta):
	direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		current_facing = "east"
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		current_facing = "west"

	if Input.is_action_pressed("ui_down"):
		direction.y += 1
		current_facing = "south"
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		current_facing = "north"

	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()

	_play_animation()

	print("Player position: ", global_position)  # ✅ added line

func _play_animation():
	var anim = "idle " + current_facing
	if velocity.length() > 0:
		anim = "walk " + current_facing

	if $AnimatedSprite2D.animation != anim:
		$AnimatedSprite2D.play(anim)
