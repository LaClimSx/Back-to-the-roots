extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")


@onready var inventory_gui = Global.inventory_gui
var price
signal damage_building

const DEFAULT_PRICE : int = 5
const CHEAP_PRICE : int = 3

var is_open: bool = false

func _ready():
	$Control/Sell.text = tr("MENU_HOUSE")
	$"Control/sellAll".text = tr("SELL_ALL")
	$"Control/sellOne".text = tr("SELL1")

func _process(delta: float) -> void:
	if(inventory_gui.find_item(flour)==-1):
		$"Control/sellAll".disabled = true
		$"Control/sellOne".disabled = true
	else:
		$"Control/sellAll".disabled = false
		$"Control/sellOne".disabled = false
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
		price = DEFAULT_PRICE
		$Control/price.bbcode_text = tr("PRICE").format({"price": price})
		return
	match s:
		Building.STATE.good: 
			price = DEFAULT_PRICE
			$Control/price.bbcode_text = tr("PRICE").format({"price": price})

		Building.STATE.mid: 
			price = CHEAP_PRICE
			$Control/price.bbcode_text = tr("PRICE_CROSSED").format({"default_price": DEFAULT_PRICE, "price": price})
			
		_: price = 0
