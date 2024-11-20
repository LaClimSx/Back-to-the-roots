extends CanvasLayer

@onready var inventory = $Inventory

func _ready() -> void:
	$MoneyObjective.text = "Objectif : " + str(Global.MONEY_TO_WIN) + "$"

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory.close() if inventory.isOpen else inventory.open()

func _on_inventory_money_updated(): #TODO: Win condition
	$MoneyCounter.text = "Argent : " + str(Global.money) + "$"
