extends Control

var isOpen: bool = true
@onready var inventory : Inventory = preload("res://Inventory/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://Inventory/item_stack_gui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var itemInHand: ItemStackGUI

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	
func connectSlots():
	for slot in slots:
		var callable = Callable(onSlotClicked)
		callable = callable.bind(slot)
		slot.pressed.connect(callable)

func update():
	for i in range(min(inventory.slots.size(),slots.size())):
		var inventorySlot : InventorySlot = inventory.slots[i]
		if !inventorySlot.item: continue
		
		var itemStackGui: ItemStackGUI = slots[i].itemStackGui
		if !itemStackGui:
			itemStackGui = ItemStackGuiClass.instantiate()
			slots[i].insert(itemStackGui)
			
		itemStackGui.slot = inventorySlot
		itemStackGui.update()

func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false
	
func onSlotClicked(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)

func updateItemInHand():
	if !itemInHand : return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size/2
