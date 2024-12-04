class_name Tool extends Item

@export var maxDurability: int = 100
@export var durability: int = 100
@export var good_texture: Texture2D
@export var mid_texture: Texture2D
@export var broken_texture: Texture2D

enum STATE {broken, mid, good}
var state: STATE = STATE.good

func use(player: Player) -> void:	
	if durability > 0:
		durability -= 1
		if durability <= maxDurability/3:
			texture = mid_texture
			state = STATE.mid
		if durability == 0:
			GlobalScene.get_node("breaks").play()
			texture = broken_texture
			state = STATE.broken
	print(durability)
	
func repair() -> void:
	durability = maxDurability
	texture = good_texture
	state = STATE.good
