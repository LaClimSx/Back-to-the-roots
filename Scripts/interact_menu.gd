extends CanvasLayer

var inventory_gui
var price


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_pressed() -> void:
	get_node("Anim").play("TransOUT")
	get_tree().paused = false


func _on_sell_one_1_pressed() -> void:
	#faire des bails avec les ressources
	inventory_gui.sell_item("wheat", false, price)


func _on_sell_all_1_pressed() -> void:
	#faire des bails avec les ressources
	inventory_gui.sell_item("wheat", true, price)
	get_node("Anim").play("TransOUT")
	get_tree().paused = false


func _on_house_actual_price(p: int) -> void:
	price = p
