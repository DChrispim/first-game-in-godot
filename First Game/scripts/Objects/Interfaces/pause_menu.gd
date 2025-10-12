extends CanvasLayer

func _ready() -> void:
	hide()

func _on_start_button_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
