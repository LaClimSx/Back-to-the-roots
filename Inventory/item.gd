extends Resource
class_name Item

@export var name: String = ""
@export var texture: Texture2D
@export var maxAmount: int = 999

func use(player: Player) -> void:
	pass
