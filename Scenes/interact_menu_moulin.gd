extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")
@onready var wheat = preload("res://Inventory/Items/wheat.tres")


var inventory_gui
var exchange
var max_health
var health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	$Control/numbre.text = str(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_pressed() -> void:
	get_node("Anim").play("TransOUT")
	get_tree().paused = false


func _on_moulin_actual_exchange(p: int) -> void:
	exchange = p


func _on_moulin_actual_health_moulin(h: int) -> void:
	health = h


func _on_moulin_max_health_moulin(mh: int) -> void:
	max_health = mh


func _on_moins_pressed() -> void:
	var new = int($Control/numbre.text) - 1
	$Control/numbre.text = str(new.clamp(new, 0,  max))
	


func _on_plus_pressed() -> void:
	var max = inventory_gui.find_item("wheat")
	if max == -1:
		$Control/numbre.text = str(0)
	else:
		var new = int($Control/numbre.text + 1)
		$Control/numbre.text = str(new.clamp(new, 0,  max))

func _on_sell_one_1_pressed() -> void:
	var nb = $Control/numbre 
	inventory_gui.insert_item(flour, nb* exchange)
	inventory_gui.remove_items(wheat, nb)
	pass # Replace with function body.
