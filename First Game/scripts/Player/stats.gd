extends Resource
class_name Stats

# Signals
signal died

# Exports
@export_group("Player Stats")
@export var max_health: int = 10

@export_group("Movement Stats")
@export var speed: float = 130.0
@export var jump_velocity: float = -300.0

# Local variables
var health: int = 0: set = _on_health_set

func _init() -> void:
    _on_health_set(max_health)

    print("Stats initialized with health: ", health)


func _on_health_set(value: int) -> void:
    health = clamp(value, 0, max_health)
    if health <= 0:
        died.emit()