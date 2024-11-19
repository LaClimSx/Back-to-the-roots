extends Building

@onready var stone : Item = preload("res://Inventory/Items/stone.tres")


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
			1: inventory_gui.insert_item(stone, 2)
			#If good pickaxe
			2: inventory_gui.insert_item(stone, 4)
	elif state == STATE.mid:
		match selected_item.state:
			#If mid pickaxe
			1: inventory_gui.insert_item(stone, 1)
			#If good pickaxe
			2: inventory_gui.insert_item(stone, 3)
	durability = clamp(durability - 10, 0, max_durability)
	inventory_gui.use_item()
	
func timer_timeout() -> void:
	pass
