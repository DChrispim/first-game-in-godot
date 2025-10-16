extends CharacterBody2D

@onready var coyote_timer := $CoyoteTimer
@onready var pause_menu := $GameCamera2D/PauseMenu
@onready var health_component := $HealthComponent

@export var stats: Stats


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite := $AnimatedSprite2D

func _ready() -> void:
	if stats:
		# use Callable in Godot 4
		stats.connect("died", Callable(self, "_on_stats_died"))
	else:
		push_error("Stats resource not assigned to player")

func _on_stats_died() -> void:
	print("Player has died")
	animated_sprite.play("death")
	$CollisionShape2D.disabled = true
	set_physics_process(false)
	get_tree().reload_current_scene()


func damage(attack: Attack) -> void:
	health_component.damage(attack)

func _physics_process(delta: float) -> void:
	var grounded: bool = is_on_floor()
	# Add the gravity.
	if not grounded:
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (grounded or not coyote_timer.is_stopped()):
		velocity.y = stats.jump_velocity

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
		velocity.x = direction * stats.speed
	else:
		velocity.x = move_toward(velocity.x, 0, stats.speed)

	move_and_slide()
	
	#print(coyote_timer.time_left)
	
	if grounded:
		coyote_timer.start()
		
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.show()
		get_tree().paused = true
