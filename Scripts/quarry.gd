extends Building

@onready var stone : Item = preload("res://Inventory/Items/stone.tres")
const BASE_DIVIDER = 20

@onready var good_texture : Texture2D = preload("res://Assets/Bâtiments/carrière/stone_quarry.png")
@onready var mid_texture : Texture2D = preload("res://Assets/Bâtiments/carrière/quarry_mid.png")


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
	match state:
		STATE.good:
			$Sprite2D.texture = good_texture
		STATE.mid:
			$Sprite2D.texture = mid_texture
		STATE.broken:
			$Sprite2D.visible = false
			$CollisionPolygon2D.disabled = true
		

func interact():
	GlobalScene.get_node("mine").play()
	if !Global.efficiency_decline:
		inventory_gui.insert_item(stone, 4)
		damage_itself_N(BASE_DIVIDER)
		Global.display_indicator(4, Global.player_looking_position, Color.GREEN)
		inventory_gui.use_item()
		return
	
	match selected_item.state:
		#If mid pickaxe	
		1: 
			inventory_gui.insert_item(stone, 2)
			damage_itself_N(BASE_DIVIDER * 2) #TODO: verifier que les calculs sont bons
			Global.display_indicator(2, Global.player_looking_position, Color.GRAY)
		#If good pickaxe
		2: 
			inventory_gui.insert_item(stone, 4)
			damage_itself_N(BASE_DIVIDER)
			Global.display_indicator(4, Global.player_looking_position, Color.GREEN)
	inventory_gui.use_item()
	
	
func damage_itself_N(divider : int) -> void:
	var old_state = state
	durability = clamp(durability - (max_durability/divider), 0, max_durability)
	checkState()
	animate()
	if old_state != state:
		#TODO: JOUER UN SON
		pass
	
func timer_timeout() -> void:
	pass
