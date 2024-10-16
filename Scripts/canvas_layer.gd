extends CanvasLayer

@onready var inventory = $Inventory


func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		#inventory.close() if inventory.isOpen else inventory.open()
		print(inventory.position)
		inventory.find_child("GridContainer", true).columns = 3
