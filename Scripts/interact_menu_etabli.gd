extends CanvasLayer

@onready var wood = preload("res://Inventory/Items/stick.tres")
@onready var stones = preload("res://Inventory/Items/stone.tres")

@onready var inventory_gui = Global.inventory_gui
signal damage_building

var nb_wood 
var nb_stone

var state : Building.STATE

var max = 0
var mid = 0.5
var low = 1
var multi = 0

var outil_cost_stone = 4
var outil_cost_wood = 2
var seau_stone = 0

var tools_repair_cost : Dictionary = {"hammer": {"wood": 0, "stone": 0}, "axe": {"wood": 0, "stone": 0}, "pickaxe": {"wood": 0, "stone": 0}, "hoe": {"wood": 0, "stone": 0}, "bucket": {"wood": 0, "stone": 0}}

var hammer : Tool
var axe : Tool
var pickaxe : Tool
var hoe : Tool
var bucket : Tool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Control/repair_axe.disabled = true
	$Control/repair_pickaxe.disabled = true
	$Control/repair_hoe.disabled = true
	$Control/repair_bucket.disabled = true
	$Control/repair_hammer.disabled = true
	$Control/etabli_title.text = "Répare tes outils" if Global.reparability else "Fabrique des outils"

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	nb_wood = inventory_gui.find_item(wood)
	nb_stone = inventory_gui.find_item(stones)
	
	if !Global.reparability:
		var tools : Dictionary = {"hammer": hammer, "axe": axe, "pickaxe": pickaxe, "hoe": hoe, "bucket": bucket} #TODO: feur
		return
	
	#TODO: This is a bad fix, change it with the refactoring
	if !hammer || !axe || !pickaxe || !hoe || !bucket: 
		return
		
	var tools : Array = [hammer, axe, pickaxe, hoe, bucket]

	for tool in tools:
		var name : String = tool.name
		var wood_label : RichTextLabel = $Control.get_node("wood_" + name)
		var stone_label : RichTextLabel = $Control.get_node("stone_" + name)
		var button : Button = $Control.get_node("repair_" + name)
		button.text = "Réparer" if Global.reparability else "Fabriquer"
		
		if state == Building.STATE.good || !Global.efficiency_decline:
			var mult: int = 2 - tool.state
			if name == "bucket":
				tools_repair_cost[name] = {"wood": 3 * mult, "stone": 0}
			else:
				tools_repair_cost[name] = {"wood": 1 * mult, "stone": 2 * mult}
			wood_label.text = "x" + str(tools_repair_cost[name]["wood"]) + " bois"
			stone_label.text = "x" + str(tools_repair_cost[name]["stone"]) + " pierres"
			if (mult == 0) || (nb_wood < tools_repair_cost[name]["wood"]) || (nb_stone < tools_repair_cost[name]["stone"]):
				button.disabled = true
			else:
				button.disabled = false
						
		elif state == Building.STATE.mid:
			var mult: int = 2 - tool.state
			if name == "bucket":
				tools_repair_cost[name] = {"wood": 6 * mult, "stone": 0}
			else:
				tools_repair_cost[name] = {"wood": 2 * mult, "stone": 4 * mult}
			wood_label.bbcode_enabled = true
			stone_label.bbcode_enabled = true
			wood_label.bbcode_text = "[s][color=gray]x" + str(tools_repair_cost[name]["wood"]/2) + "[/color][/s]" + " x" + str(tools_repair_cost[name]["wood"]) + " bois"
			stone_label.bbcode_text = "[s][color=gray]x" + str(tools_repair_cost[name]["stone"]/2) + "[/color][/s]" + " x" + str(tools_repair_cost[name]["stone"]) + " pierres"
			if (mult == 0) || (nb_wood < tools_repair_cost[name]["wood"]) || (nb_stone < tools_repair_cost[name]["stone"]):
				button.disabled = true
			else:
				button.disabled = false


func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_etabli_s_state(s: Building.STATE):
	state = s
	hammer = inventory_gui.get_tool("hammer")
	axe = inventory_gui.get_tool("axe")
	pickaxe = inventory_gui.get_tool("pickaxe")
	hoe = inventory_gui.get_tool("hoe")
	bucket = inventory_gui.get_tool("bucket")

func _on_repair_hammer_pressed() -> void:
	hammer.repair()
	inventory_gui.remove_item(wood, tools_repair_cost["hammer"]["wood"])
	inventory_gui.remove_item(stones, tools_repair_cost["hammer"]["stone"])
	damage_building.emit()


func _on_repair_axe_pressed() -> void:
	axe.repair()
	inventory_gui.remove_item(wood, tools_repair_cost["axe"]["wood"])
	inventory_gui.remove_item(stones, tools_repair_cost["axe"]["stone"])
	damage_building.emit()


func _on_repair_pickaxe_pressed() -> void:
	pickaxe.repair()
	inventory_gui.remove_item(wood, tools_repair_cost["pickaxe"]["wood"])
	inventory_gui.remove_item(stones, tools_repair_cost["pickaxe"]["stone"])
	damage_building.emit()


func _on_repair_hoe_pressed() -> void:
	hoe.repair()
	inventory_gui.remove_item(wood, tools_repair_cost["hoe"]["wood"])
	inventory_gui.remove_item(stones, tools_repair_cost["hoe"]["stone"])
	damage_building.emit()


func _on_repair_bucket_pressed() -> void:
		bucket.repair()
		inventory_gui.remove_item(wood, tools_repair_cost["bucket"]["wood"])
		inventory_gui.remove_item(stones, tools_repair_cost["bucket"]["stone"])
		damage_building.emit()
