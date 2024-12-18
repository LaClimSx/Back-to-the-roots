class_name RepairMenu extends CanvasLayer

const BUILDING_REPAIR_COSTS : Dictionary = {"House": {"wood": 2, "stone": 1}, "Moulin": {"wood": 1, "stone": 2}, "Etabli": {"wood": 2, "stone": 1}, "Puits": {"wood": 0, "stone": 3}}


var wood_cost: int
var stone_cost: int
var state: Building.STATE
var default_cost: Dictionary
signal repair

var is_open: bool = false

@onready var stick: Item = preload("res://Inventory/Items/stick.tres")
@onready var stone: Item = preload("res://Inventory/Items/stone.tres")
@onready var inventory_gui = Global.inventory_gui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/repair.text = tr("REPAIR")
	$Control/cost.text = tr("COST")
	var parent_name: String = get_parent().name
	default_cost = BUILDING_REPAIR_COSTS[parent_name]
	match parent_name:
		"House": 
			$Control/repairLabel.text = tr("REPAIR_HOUSE")
		"Moulin": 
			$Control/repairLabel.text = tr("REPAIR_WINDMILL")
		"Etabli": 
			$Control/repairLabel.text = tr("REPAIR_BENCH")
		"Puits": 
			$Control/repairLabel.text = tr("REPAIR_WELL")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Esc") && is_open:
		_on_close_pressed()
	
	if (state != Building.STATE.broken || !Global.reparability):
		$Control/stone.text = tr_n("STONE_COST", "STONE_COST_N", stone_cost).format({"stone_cost": stone_cost})
		$Control/wood.text = tr("WOOD_COST").format({"wood_cost": wood_cost})
	else :
		$Control/stone.bbcode_enabled = true
		$Control/wood.bbcode_enabled = true
		$Control/stone.bbcode_text = tr("STONE_COST_CROSSED").format({"default_cost": default_cost["stone"], "cost": stone_cost})
		$Control/wood.bbcode_text = tr("WOOD_COST_CROSSED").format({"default_cost": default_cost["wood"], "cost": wood_cost})
	
	if (inventory_gui.find_item(stick) >= wood_cost && inventory_gui.find_item(stone) >= stone_cost):
		$Control/repair.disabled = false
	else:
		$Control/repair.disabled = true

func _on_close_pressed() -> void:
	is_open = false
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_repair_pressed() -> void:
	inventory_gui.remove_item(stick, wood_cost)
	inventory_gui.remove_item(stone, stone_cost)
	emit_signal("repair")
	inventory_gui.use_item()
	is_open = false
	$Anim.play("TransOUT")
	GlobalScene.get_node("repair").play()
	get_tree().paused = false

func _on_s_state(s: Building.STATE) -> void:
	state = s
	if s == Building.STATE.good:
		wood_cost = 0
		stone_cost = 0
	elif s == Building.STATE.mid:
		wood_cost = default_cost["wood"]
		stone_cost = default_cost["stone"]
	elif s == Building.STATE.broken:
		wood_cost = 2 * default_cost["wood"]
		stone_cost = 2 * default_cost["stone"]
