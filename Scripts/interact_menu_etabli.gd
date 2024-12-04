extends CanvasLayer

@onready var wood = preload("res://Inventory/Items/stick.tres")
@onready var stones = preload("res://Inventory/Items/stone.tres")

@onready var inventory_gui = Global.inventory_gui
signal damage_building

var nb_wood 
var nb_stone

var state : Building.STATE

var tools_repair_cost : Dictionary = {"hammer": {"wood": 0, "stone": 0}, "axe": {"wood": 0, "stone": 0}, "pickaxe": {"wood": 0, "stone": 0}, "hoe": {"wood": 0, "stone": 0}, "bucket": {"wood": 0, "stone": 0}}

var hammer : Tool
var axe : Tool
var pickaxe : Tool
var hoe : Tool
var bucket : Tool

@onready var hammer_item : Tool = preload("res://Inventory/Items/hammer.tres")
@onready var axe_item : Tool = preload("res://Inventory/Items/axe.tres")
@onready var pickaxe_item : Tool = preload("res://Inventory/Items/pickaxe.tres")
@onready var hoe_item : Tool = preload("res://Inventory/Items/hoe.tres")
@onready var bucket_item : Tool = preload("res://Inventory/Items/bucket.tres")

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
		var tools : Dictionary = {"hammer": hammer, "axe": axe, "pickaxe": pickaxe, "hoe": hoe, "bucket": bucket}
		for key in tools.keys():
			var wood_label : RichTextLabel = $Control.get_node("wood_" + key)
			var stone_label : RichTextLabel = $Control.get_node("stone_" + key)
			var button : Button = $Control.get_node("repair_" + key)
			button.text = "Fabriquer"
			if tools[key]:
				button.disabled = true
				tools_repair_cost[key] = {"wood": 0, "stone": 0}
			else:
				button.disabled = false
				if key == "bucket":
					tools_repair_cost[key] = {"wood": 6, "stone": 0}
				else:
					tools_repair_cost[key] = {"wood": 2, "stone": 4}
			wood_label.text = "x" + str(tools_repair_cost[key]["wood"]) + " bois"
			stone_label.text = "x" + str(tools_repair_cost[key]["stone"]) + " pierres"
		return
		
	#If reparability
	var tools : Array = [hammer, axe, pickaxe, hoe, bucket]

	for tool in tools:
		var name : String = tool.name
		var wood_label : RichTextLabel = $Control.get_node("wood_" + name)
		var stone_label : RichTextLabel = $Control.get_node("stone_" + name)
		var button : Button = $Control.get_node("repair_" + name)
		button.text = "Réparer"
		
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
	if !Global.reparability:
		if !inventory_gui.insert_at(hammer_item, 2): inventory_gui.insert_item(hammer_item,1)
		hammer_item.repair()
		inventory_gui.update()
	else:
		hammer.repair()
		inventory_gui.remove_item(wood, tools_repair_cost["hammer"]["wood"])
		inventory_gui.remove_item(stones, tools_repair_cost["hammer"]["stone"])
	damage_building.emit()


func _on_repair_axe_pressed() -> void:
	if !Global.reparability:
		if !inventory_gui.insert_at(axe_item, 3): inventory_gui.insert_item(axe_item,1)
		axe_item.repair()
		inventory_gui.update()
	else:
		axe.repair()
		inventory_gui.remove_item(wood, tools_repair_cost["axe"]["wood"])
		inventory_gui.remove_item(stones, tools_repair_cost["axe"]["stone"])
	damage_building.emit()


func _on_repair_pickaxe_pressed() -> void:
	if !Global.reparability:
		if !inventory_gui.insert_at(pickaxe_item, 4): inventory_gui.insert_item(pickaxe_item,1)
		pickaxe_item.repair()
		inventory_gui.update()
	else:
		pickaxe.repair()
		inventory_gui.remove_item(wood, tools_repair_cost["pickaxe"]["wood"])
		inventory_gui.remove_item(stones, tools_repair_cost["pickaxe"]["stone"])
	damage_building.emit()


func _on_repair_hoe_pressed() -> void:
	if !Global.reparability:
		if !inventory_gui.insert_at(hoe_item, 0): inventory_gui.insert_item(hoe_item,1)
		hoe_item.repair()
		inventory_gui.update()
	else:
		hoe.repair()
		inventory_gui.remove_item(wood, tools_repair_cost["hoe"]["wood"])
		inventory_gui.remove_item(stones, tools_repair_cost["hoe"]["stone"])
	damage_building.emit()


func _on_repair_bucket_pressed() -> void:
	if !Global.reparability:
		if !inventory_gui.insert_at(bucket_item, 1): inventory_gui.insert_item(bucket_item,1)
		bucket_item.repair()
		inventory_gui.update()
	else:
		bucket.repair()
		inventory_gui.remove_item(wood, tools_repair_cost["bucket"]["wood"])
		inventory_gui.remove_item(stones, tools_repair_cost["bucket"]["stone"])
	damage_building.emit()
