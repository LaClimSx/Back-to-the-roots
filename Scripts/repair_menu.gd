class_name RepairMenu extends CanvasLayer

var wood_cost: int
var stone_cost: int
var state: Building.STATE
var default_cost: Vector2i
signal repair

@onready var stick: Item = preload("res://Inventory/Items/stick.tres")
@onready var stone: Item = preload("res://Inventory/Items/stone.tres")
@onready var inventory_gui = Global.inventory_gui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent_name: String = get_parent().name
	match parent_name:
		"House": 
			default_cost = Vector2i(2, 1) #(stick, stone)
			$Control/repairLabel.text = "Répare ta maison"
		"Moulin": 
			default_cost = Vector2i(1, 2)
			$Control/repairLabel.text = "Répare ton moulin"
		"Etabli": 
			default_cost = Vector2i(2, 1)
			$Control/repairLabel.text = "Répare ton établi"
		"Puits": 
			default_cost = Vector2i(0, 3)
			$Control/repairLabel.text = "Répare ton puits"
		_: #This should not happen
			default_cost = Vector2i(-1, -1) 
			$Control/repairLabel.text = "Rien à réparer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/stone.text = "x" + str(stone_cost) + " pierre(s)"
	$Control/wood.text = "x" + str(wood_cost) + " bois"
	
	if (inventory_gui.find_item(stick) >= wood_cost && inventory_gui.find_item(stone) >= stone_cost):
		$Control/repair.disabled = false
	else: #TODO: What to do when not enough ? For now nothing
		$Control/repair.disabled = true


func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_repair_pressed() -> void:
	#var inv_gui = Global.inventory_gui
	#if (inv_gui.find_item(stick) >= wood_cost && inv_gui.find_item(stone) >= stone_cost):
	#	print("Enough to repair")
	inventory_gui.remove_item(stick, wood_cost)
	inventory_gui.remove_item(stone, stone_cost)
	emit_signal("repair")
	inventory_gui.use_item()
	$Anim.play("TransOUT")
	get_tree().paused = false
	#else: #TODO: What to do when not enough ? For now nothing
	#	print("Fonds insuffisants")

func _on_s_state(s: Building.STATE) -> void:
	if s == Building.STATE.good:
		wood_cost = 0
		stone_cost = 0
	elif s == Building.STATE.mid:
		wood_cost = default_cost[0]
		stone_cost = default_cost[1]
	elif s == Building.STATE.broken:
		wood_cost = 2 * default_cost[0]
		stone_cost = 2 * default_cost[1]
