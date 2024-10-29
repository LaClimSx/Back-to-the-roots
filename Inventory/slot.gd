extends Button

@onready var backgroundSprite: Sprite2D = $Background
@onready var container: CenterContainer = $CenterContainer

@onready var inventory = preload("res://Inventory/player_inventory.tres")

var itemStackGui: ItemStackGUI
var index: int

func insert(isg: ItemStackGUI):
	itemStackGui = isg
	backgroundSprite.frame = 1
	container.add_child(itemStackGui)
	
	if !itemStackGui.slot || inventory.slots[index] == itemStackGui.slot:
		return
		
	inventory.insertSlot(index, itemStackGui.slot)

func takeItem():
	var item = itemStackGui
	
	inventory.removeSlot(itemStackGui.slot)
	
	clear()
	
	return item
	
func isEmpty():
	return !itemStackGui

func clear() -> void:
	if itemStackGui:
		container.remove_child(itemStackGui)
		itemStackGui = null
		
	backgroundSprite.frame = 0
