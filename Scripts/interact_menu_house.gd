extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")


@onready var inventory_gui = Global.inventory_gui
var price
signal damage_building

func _process(delta: float) -> void:
	if(inventory_gui.find_item(flour)==-1):
		$"Control/sell all1".disabled = true
		$"Control/sell one1".disabled = true
	else:
		$"Control/sell all1".disabled = false
		$"Control/sell one1".disabled = false

func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false

func _on_sell_one_1_pressed() -> void:
	#faire des bails avec les ressources
	inventory_gui.sell_item(flour, false, price)
	damage_building.emit() #TODO: check if makes sense to damage at each sale
	if price == 0 : 
		$Anim.play("TransOUT")
		get_tree().paused = false


func _on_sell_all_1_pressed() -> void:
	#faire des bails avec les ressources
	inventory_gui.sell_item(flour, true, price)
	$Anim.play("TransOUT")
	damage_building.emit()
	get_tree().paused = false



func _on_house_s_state(s):
	match s:
		Building.STATE.good: price = 5
		Building.STATE.mid: price = 3
		_: price = 0
	$Control/price.text = "Prix : " + str(price) + "$"
