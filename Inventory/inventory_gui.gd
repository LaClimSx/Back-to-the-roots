extends Control

var isOpen: bool = true
@onready var inventory : Inventory = preload("res://Inventory/player_inventory.tres")
@onready var ItemStackGuiClass = preload("res://Inventory/item_stack_gui.tscn")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var selector: Sprite2D = $Selector


var currently_selected: int = 0

var itemInHand: ItemStackGUI
var oldIndex: int = -1
var locked: bool = false

signal moneyUpdated

func _ready():
	connectSlots()
	inventory.updated.connect(update)
	update()
	Global.inventory_gui = self
	
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
		if !inventorySlot.item: 
			slots[i].clear()
			continue
		
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
	
func move_selector(direction: int):
	currently_selected = (currently_selected + direction) % slots.size()
	selector.global_position = slots[currently_selected].global_position

func select_slot(index: int):
	currently_selected = index
	selector.global_position = slots[currently_selected].global_position

func check_selection():
	if Input.is_action_just_pressed("select_1"):
		select_slot(0)
		return
	if Input.is_action_just_pressed("select_2"):
		select_slot(1)
		return
	if Input.is_action_just_pressed("select_3"):
		select_slot(2)
		return
	if Input.is_action_just_pressed("select_4"):
		select_slot(3)
		return
	if Input.is_action_just_pressed("select_5"):
		select_slot(4)
		return
	if Input.is_action_just_pressed("select_6"):
		select_slot(5)
		return
	if Input.is_action_just_pressed("select_7"):
		select_slot(6)
		return
	if Input.is_action_just_pressed("select_8"):
		select_slot(7)
		return
	if Input.is_action_just_pressed("select_9"):
		select_slot(8)
		return

func use_item() -> void :
	inventory.use_item_at_index(currently_selected)
	
func get_selected_item() -> Item:
	return inventory.slots[currently_selected].item
	


func _input(event):
	if itemInHand && !locked && (Input.is_action_pressed("Right_click") || Input.is_action_pressed("Interact" ) || Input.is_action_pressed("toggle_inventory")):
		putItemBack()
	check_selection()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			move_selector(1)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			move_selector(-1)
	#elif Input.is_action_just_pressed("Interact"):
	#	inventory.use_item_at_index(currently_selected) #TODO : change this later
		
	updateItemInHand()
	
#Returns the amount of said item in the inventory, -1 if none
func find_item(itemName: String) -> int:
	return inventory.find_item(itemName)
	
func insert_item(item: Item, amount: int) -> int:
	return inventory.insertN(item, amount)
	
func remove_item(item: Item, amount: int) -> int:
	return inventory.removeN(item, amount)

func sell_item(item: Item, all: bool, unit_price: int) -> int:
	moneyUpdated.emit()
	return inventory.sellN(item, all, unit_price)
