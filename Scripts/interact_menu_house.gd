extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")


@onready var inventory_gui = Global.inventory_gui
var price
signal damage_building

var is_open: bool = false

func _process(delta: float) -> void:
	if(inventory_gui.find_item(flour)==-1):
		$"Control/sell all1".disabled = true
		$"Control/sell one1".disabled = true
	else:
		$"Control/sell all1".disabled = false
		$"Control/sell one1".disabled = false
	if Input.is_action_pressed("Esc") && is_open:
		_on_close_pressed()

func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	is_open = false
	get_tree().paused = false

func _on_sell_one_1_pressed() -> void:
	#faire des bails avec les ressources
	inventory_gui.sell_item(flour, false, price)
	damage_building.emit() #TODO: check if makes sense to damage at each sale
	$sell.play()
	if price == 0 : 
		$Anim.play("TransOUT")
		get_tree().paused = false


func _on_sell_all_1_pressed() -> void:
	#faire des bails avec les ressources
	$sell.play()
	inventory_gui.sell_item(flour, true, price)
	$Anim.play("TransOUT")
	damage_building.emit()
	is_open = false
	get_tree().paused = false



func _on_house_s_state(s):
	$Control/price.bbcode_enabled = true
	if !Global.efficiency_decline:
		price = 5
		$Control/price.bbcode_text = "Prix : " + str(price) + "$"
		return
	match s:
		Building.STATE.good: 
			price = 5
			$Control/price.bbcode_text = "Prix : " + str(price) + "$"

		Building.STATE.mid: 
			price = 3
			$Control/price.bbcode_text = "Prix : [s][color=gray]" + "5$" + "[/color][/s] " + str(price) + "$"
			
		_: price = 0
