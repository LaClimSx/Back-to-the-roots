extends Building

@onready var stone : Item = preload("res://Inventory/Items/stone.tres")
const BASE_DIVIDER = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	reparable = false
	interactable = true
	corresponding_item_name = "pickaxe"
	repair_label = null
	interact_label = null
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func animate():
	if state == STATE.broken:
		$Sprite2D.visible = false
		$CollisionPolygon2D.disabled = true
	else:
		$Sprite2D.visible = true
		$CollisionPolygon2D.disabled = false

func interact():
	if state == STATE.good:
		match selected_item.state:
			#If mid pickaxe
			1: 
				inventory_gui.insert_item(stone, 2)
				damage_itself_N(2 * BASE_DIVIDER)
				Global.display_indicator(2, Global.player_looking_position, Color.GRAY)
			#If good pickaxe
			2: 
				inventory_gui.insert_item(stone, 4)
				damage_itself_N(4 * BASE_DIVIDER)
				Global.display_indicator(4, Global.player_looking_position, Color.GREEN)
	elif state == STATE.mid:
		match selected_item.state:
			#If mid pickaxe
			1: 
				inventory_gui.insert_item(stone, 1)
				damage_itself_N(1 * BASE_DIVIDER)
				Global.display_indicator(1, Global.player_looking_position, Color.GRAY)
			#If good pickaxe
			2: 
				inventory_gui.insert_item(stone, 3)
				damage_itself_N(3 * BASE_DIVIDER)
				Global.display_indicator(3, Global.player_looking_position, Color.GREEN)
	inventory_gui.use_item()
	
	
func damage_itself_N(divider : int) -> void:
	durability = clamp(durability - max_durability/divider, 0, max_durability)
	checkState()
	animate()
	
func timer_timeout() -> void:
	pass
