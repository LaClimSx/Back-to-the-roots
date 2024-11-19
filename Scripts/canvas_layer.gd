extends CanvasLayer

@onready var inventory = $Inventory
@onready var money_label = $MoneyCounter

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory.close() if inventory.isOpen else inventory.open()

func _on_inventory_money_updated():
	money_label.text = "Argent : " + str(Global.money) + "$"
