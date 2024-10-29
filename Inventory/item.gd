extends Resource
class_name Item

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmount: int = 99

func use(player: Player) -> void:
	pass
