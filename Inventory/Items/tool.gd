class_name Tool extends Item

@export var maxDurability: int = 100
@export var durability: int = 100
@export var good_texture: Texture2D
@export var mid_texture: Texture2D
@export var broken_texture: Texture2D
	

func use(player: Player) -> void:
	if durability > 0:
		durability -= 1
	
		if durability <= maxDurability/3:
			texture = mid_texture
		if durability == 0:
			texture = broken_texture
	print(durability)
