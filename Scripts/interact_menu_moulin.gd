extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")
@onready var wheat = preload("res://Inventory/Items/wheat.tres")
@onready var inventory_gui = Global.inventory_gui

var exchange
var state: Building.STATE
var quantity: int = 0
var max: int

signal damage_building

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	updateLabel()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(inventory_gui.find_item(wheat)==-1):
		$Control/sell.disabled = true
	else:
		$Control/sell.disabled = false

func update() -> void:
	max = inventory_gui.find_item(wheat)
	quantity = 0
	updateLabel()
	
func updateLabel() -> void:
	$Control/number.text = str(quantity)

func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false

func _on_moulin_s_state(s: Building.STATE) -> void:
	match s: 
		Building.STATE.good: exchange = 3
		Building.STATE.mid: exchange = 1
		_: exchange = 0
	$Control/exchangeRate.text = "Taux d'échange 1:" + str(exchange)
		

func _on_moins_pressed() -> void:
	quantity = clamp(quantity - 1, 0, max) if max != -1 else 0
	updateLabel()
	
func _on_plus_pressed() -> void:
	quantity = clamp(quantity + 1, 0, max) if max != -1 else 0
	updateLabel()

func _on_sell_pressed() -> void:
	inventory_gui.remove_item(wheat, quantity)
	inventory_gui.insert_item(flour, (quantity * exchange))
	damage_building.emit()
	update()
