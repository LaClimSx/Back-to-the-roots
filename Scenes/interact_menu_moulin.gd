extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")
@onready var wheat = preload("res://Inventory/Items/wheat.tres")


var inventory_gui
var exchange
var state: Building.STATE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	$Control/numbre.text = str(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_moulin_actual_exchange(p: int) -> void:
	exchange = p

func _on_moulin_s_state(d: int) -> void:
	state = d

func _on_moins_pressed() -> void:
	var max = inventory_gui.find_item("wheat")
	if max == -1:
		$Control/numbre.text = str(0)
	else:
		var new = clamp(int($Control/numbre.text) - 1, 0, max)
		$Control/numbre.text = str(new)
	
func _on_plus_pressed() -> void:
	var max = inventory_gui.find_item("wheat")
	if max == -1:
		$Control/numbre.text = str(0)
	else:
		var new = clamp(int($Control/numbre.text) + 1, 0, max)
		$Control/numbre.text = str(new)

#TODO enlever durabilité du batiment
func _on_sell_one_1_pressed() -> void:
	var nb : int = int($Control/numbre.text)
	inventory_gui.insert_item(flour, (nb * exchange))
	inventory_gui.remove_item(wheat, nb)
	pass # Replace with function body.
