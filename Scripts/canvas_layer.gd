extends CanvasLayer

@onready var inventory = $Inventory
#var old_money : int = 0

func _ready() -> void:
	$MoneyObjective.text = "Objectif : " + str(Global.MONEY_TO_WIN) + "$"

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory.close() if inventory.isOpen else inventory.open()

func _on_inventory_money_updated(): #TODO: Win condition
	#TODO : See if we display the indicator here or in the inventory
	$MoneyCounter.text = "Argent : " + str(Global.money) + "$"
	#old_money = Global.money
