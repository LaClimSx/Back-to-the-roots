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
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		
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
	if slot.isEmpty():
		if !itemInHand: return
		
		insertItemInSlot(slot)
		return
	if !itemInHand:
		takeItemFromSlot(slot)
		return
	
	if slot.itemStackGui.slot.item.name == itemInHand.slot.item.name:
		stackItems(slot)
		return
	swapItems(slot)
	
func takeItemFromSlot(slot):
	itemInHand = slot.takeItem()
	add_child(itemInHand)
	updateItemInHand()
	
func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)
	
func swapItems(slot):
	var tempItem = slot.takeItem()
	
	insertItemInSlot(slot)
	
	itemInHand = tempItem
	add_child(itemInHand)
	updateItemInHand()
	
func stackItems(slot):
	var slotItem: ItemStackGUI = slot.itemStackGui
	var maxAmount = slotItem.slot.item.maxAmount
	var totalAmount = slotItem.slot.amount + itemInHand.slot.amount
	
	if slotItem.slot.amount == maxAmount:
		swapItems(slot)
		return
	if totalAmount <= maxAmount:
		slotItem.slot.amount = totalAmount
		remove_child(itemInHand)
		itemInHand = null
	else:
		print("there are" , totalAmount)
		slotItem.slot.amount = maxAmount
		itemInHand.slot.amount = totalAmount - maxAmount
		print(itemInHand.slot.amount)
		
	slotItem.update()
	if itemInHand: updateItemInHand()
	
func updateItemInHand():
	if !itemInHand : return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size/2
	itemInHand.update()
	
func _input(event):
	updateItemInHand()
