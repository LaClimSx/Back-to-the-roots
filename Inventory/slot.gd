extends Button

@onready var backgroundSprite: Sprite2D = $Background
@onready var container: CenterContainer = $CenterContainer

@onready var inventory = preload("res://Inventory/player_inventory.tres")

var itemStackGui: ItemStackGUI
var index: int

func _process(delta):
	if itemStackGui:
		#Warning: I believe the following is a crime against programming, I'm only doing it because I lack time
		var item: Item = Global.inventory_gui.get_item_at(index) if Global.inventory_gui else null
		if item && item is Tool:
			backgroundSprite.frame = clamp(10 - item.durability, 1, 10)

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
