extends Node2D

const SPEED = 60

var direction: int = 1

@onready var ray_cast_right := $RayCastRight
@onready var ray_cast_left := $RayCastLeft
@onready var animated_sprite := $AnimatedSprite2D

@onready var hurt_area: Area2D = $HurtBox
@export var enemy_color: Color = Color(1, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta

func _ready() -> void:
	animated_sprite.modulate = enemy_color


func _on_hurt_box_body_entered(body: CharacterBody2D) -> void:
	if body.has_method("damage"):
		var attack := Attack.new()
		attack.attack_damage = 1
		body.damage(attack)
		
		print("Enemy hit")
