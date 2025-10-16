class_name HealthComponent extends Node2D

@export var player_HUD: CanvasLayer
@onready var stats: Stats = get_parent().stats

func _ready() -> void:
	player_HUD.get_node("LifeCounter").text = "You have " + str(stats.health) + " lives"

func damage(attack: Attack) -> void:
	stats._on_health_set(stats.health - attack.attack_damage)
	player_HUD.get_node("LifeCounter").text = "You have " + str(stats.health) + " lives"
