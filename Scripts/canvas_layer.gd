extends CanvasLayer

@onready var inventory = $Inventory
@onready var ninePatch = $Inventory/NinePatchRect
@onready var gridContainer = $Inventory/NinePatchRect/GridContainer


func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory.close() if inventory.isOpen else inventory.open()
		'''
		print(inventory.position)
		var ninePatch = inventory.get_child(0)
		if inventory.isHotBar : 
			setInventory()
			
		else : 
			setHotBar()
		'''
			
		


func setHotBar():
	inventory.position = Vector2(292,555)
	ninePatch.size = Vector2(227,36)
	gridContainer.columns = 9
	inventory.isHotBar = true
	gridContainer.size = Vector2(212,20)
	gridContainer.set_anchors_preset(8)
	
func setInventory():
	ninePatch.size = Vector2(85,85)
	gridContainer.columns = 3
	gridContainer.size = Vector2(68,68)
	gridContainer.set_anchors_preset(7)
	inventory.isHotBar = false
	
