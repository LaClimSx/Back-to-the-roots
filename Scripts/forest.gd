extends Building

@onready var stick = preload("res://Inventory/Items/stick.tres")

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
			1: inventory_gui.insert_item(stick, 2)
			#If good axe
			2: inventory_gui.insert_item(stick, 4)
	elif state == STATE.mid:
		match selected_item.state:
			#If mid axe
			1: inventory_gui.insert_item(stick, 1)
			#If good axe
			2: inventory_gui.insert_item(stick, 3)
	durability = clamp(durability - 10, 0, max_durability)
	inventory_gui.use_item()

func timer_timeout() -> void:
	if state == STATE.broken: return
	durability -= loss_dura_by_tic #Here the loss is negative so durability increases
	durability = clamp(durability, 0, max_durability)
	s_state.emit(durability)
