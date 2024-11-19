extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")

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
	$Anim.play("TransOUT")
	get_tree().paused = false

#TODO enlever durabilité du batiment
func _on_sell_one_1_pressed() -> void:
	#faire des bails avec les ressources
	inventory_gui.sell_item(flour, false, price)


func _on_sell_all_1_pressed() -> void:
	#faire des bails avec les ressources
	inventory_gui.sell_item(flour, true, price)
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_house_actual_price(p: int) -> void:
	price = p
	print("price per flour: ", price)
