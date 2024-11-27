extends Building

@onready var stick = preload("res://Inventory/Items/stick.tres")
const BASE_DIVIDER = 12

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
	if state == STATE.broken:
		$Sprite2D.visible = false
		$CollisionPolygon2D.disabled = true
	else:
		$Sprite2D.visible = true
		$CollisionPolygon2D.disabled = false

func interact():
	if state == STATE.good:
		match selected_item.state:
			#If mid axe
			1: 
				inventory_gui.insert_item(stick, 2)
				damage_itself_N(2 * BASE_DIVIDER)
			#If good axe
			2: 
				inventory_gui.insert_item(stick, 4)
				damage_itself_N(4 * BASE_DIVIDER)
	elif state == STATE.mid:
		match selected_item.state:
			#If mid axe
			1: 
				inventory_gui.insert_item(stick, 1)
				damage_itself_N(1 * BASE_DIVIDER)
			#If good axe
			2: 
				inventory_gui.insert_item(stick, 3)
				damage_itself_N(3 * BASE_DIVIDER)

	inventory_gui.use_item()
	
func damage_itself_N(divider : int) -> void:
	durability = clamp(durability - max_durability/divider, 0, max_durability)
	checkState()
	animate()

func timer_timeout() -> void:
	if state == STATE.broken: return
	durability = clamp(durability + max_durability/100, 0, max_durability)
