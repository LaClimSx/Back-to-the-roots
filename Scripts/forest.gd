extends Building

@onready var stick = preload("res://Inventory/Items/stick.tres")
const BASE_DIVIDER = 12

@onready var good_texture : Texture2D = preload("res://Assets/Bâtiments/forêt/tree.png")
@onready var mid_texture : Texture2D = preload("res://Assets/Bâtiments/forêt/tree_mid.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	reparable = false
	interactable = true
	corresponding_item_name = "axe"
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
	if !Global.efficiency_decline:
		inventory_gui.insert_item(stick, 4)
		damage_itself_N(BASE_DIVIDER)
		Global.display_indicator(4, Global.player_looking_position, Color.GREEN)
		inventory_gui.use_item()
		return
		
	match selected_item.state:
		#If mid axe
		1: 
			inventory_gui.insert_item(stick, 2)
			damage_itself_N(BASE_DIVIDER * 2)
			Global.display_indicator(2, Global.player_looking_position, Color.GRAY)
		#If good axe
		2: 
			inventory_gui.insert_item(stick, 4)
			damage_itself_N(BASE_DIVIDER)
			Global.display_indicator(4, Global.player_looking_position, Color.GREEN)
	inventory_gui.use_item()
	
func damage_itself_N(divider : int) -> void:
	durability = clamp(durability - (max_durability/divider), 0, max_durability)
	checkState()
	animate()

func timer_timeout() -> void:
	if state == STATE.broken: return
	durability = clamp(durability + max_durability/100, 0, max_durability)
