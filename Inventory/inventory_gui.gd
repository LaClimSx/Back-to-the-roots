extends Control

var isOpen: bool = true
@onready var inventory : Inventory = preload("res://Inventory/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://Inventory/item_stack_gui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var itemInHand: ItemStackGUI
var oldIndex: int = -1
var locked: bool = false

var isHotBar: bool = true

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
	if locked: return
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
	
	oldIndex = slot.index
	
func insertItemInSlot(slot):
	var item = itemInHand
	
	remove_child(itemInHand)
	itemInHand = null
	
	slot.insert(item)
	
	oldIndex = -1
	
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
		oldIndex = -1
	else:
		slotItem.slot.amount = maxAmount
		itemInHand.slot.amount = totalAmount - maxAmount
		
	slotItem.update()
	if itemInHand: updateItemInHand()
	
func updateItemInHand():
	if !itemInHand : return
	itemInHand.global_position = get_global_mouse_position() - itemInHand.size/2
	itemInHand.update()
	
func putItemBack():
	locked = true
	if oldIndex < 0:
		var emptySlots = slots.filter(func(slot): return slot.isEmpty())
		if emptySlots.is_empty(): return
		
		oldIndex = emptySlots[0].index
		
	var targetSlot = slots[oldIndex]
	
	var tween = create_tween()
	var targetPosition = targetSlot.global_position + targetSlot.size/2
	tween.tween_property(itemInHand,"global_position", targetPosition, 0.1)
	
	await tween.finished
	insertItemInSlot(targetSlot)
	locked = false
	
func _input(event):
	if itemInHand && !locked && (Input.is_action_pressed("Right_click") || Input.is_action_pressed("Interact" ) || Input.is_action_pressed("toggle_inventory")):
		putItemBack()
		
	updateItemInHand()
