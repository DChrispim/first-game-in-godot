extends Node

var score := 0
@onready var score_label := $ScoreLabel
@onready var game_camera := $"../Player/GameCamera2D"
@onready var HUD := $"../Player/GameCamera2D/Hud"

func add_point() -> void:
	score += 1
	HUD.get_node("ScoreText").text = "Total coins: " + str(score)


func _ready() -> void:
	game_camera.make_current()
