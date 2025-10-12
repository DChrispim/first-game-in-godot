class_name HealthComponent extends Node2D

@export var MAX_HEALTH: int = 10
@export var player_HUD: CanvasLayer

var health: int

func _ready() -> void:
	health = MAX_HEALTH
	player_HUD.get_node("LifeCounter").text = "You have " + str(MAX_HEALTH) + " lives"
	
func damage(attack: Attack) -> void:
	health -= attack.attack_damage
	player_HUD.get_node("LifeCounter").text = "You have " + str(health) + " lives"
	if health <= 0:
		get_parent().queue_free()
