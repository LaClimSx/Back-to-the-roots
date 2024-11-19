extends CanvasLayer

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
	
#TODO enlever durabilité du batiment
func _on_sell_one_1_pressed() -> void:
	var nb = $Control/numbre 
	#inventory_gui.insert_item(flour, nb* exchange)
	#inventory_gui.remove_items(wheat, nb)
	pass # Replace with function body.
