extends CharacterBody2D


@onready var coyote_timer := $CoyoteTimer
@onready var pause_menu := $GameCamera2D/PauseMenu
@onready var health_component := $HealthComponent

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite := $AnimatedSprite2D

func damage(attack: Attack) -> void:
	health_component.damage(attack)

func _physics_process(delta: float) -> void:
	var grounded: bool = is_on_floor()
	# Add the gravity.
	if not grounded:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (grounded or not coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#print(coyote_timer.time_left)
	
	if grounded:
		coyote_timer.start()
		
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.show()
		get_tree().paused = true
