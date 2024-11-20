extends Resource

class_name Inventory

signal updated
signal use_item

@export var slots: Array[InventorySlot]

#Insert one item into the inventory
#Returns true if the item was inserted, false if not
func insert(item : Item) -> bool :
	#Find all slots that have the item and have space
	var item_slots = slots.filter(func(slot): return slot.item == item && slot.amount < slot.item.maxAmount)
	if !item_slots.is_empty():
		item_slots[0].amount+=1
		updated.emit()
		return true
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
			updated.emit()
			return true
	return false

#Insert n items into the inventory
#Returns the number of items that were inserted
func insertN(item: Item, n: int) -> int : #TODO: If this doesn't work just call insert n times until we get false
	var left = n
	#Find all slots that have the item and have space
	var item_slots = slots.filter(func(slot): return slot.item == item && slot.amount < slot.item.maxAmount)
	for slot in item_slots:
		var space = slot.item.maxAmount - slot.amount
		if space >= left:
			slot.amount += left
			updated.emit()
			return n
		else:
			slot.amount = slot.item.maxAmount
			left -= space
	if left > 0:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		for slot in empty_slots:
			if left > 0:
				slot.item = item
				slot.amount = left if left <= item.maxAmount else item.maxAmount
				left -= slot.amount
	updated.emit()
	return n - left

#Remove n items from the inventory
#Returns the number of items that were removed
func removeN(item: Item, n: int) -> int:
	var left = n
	var item_slots = slots.filter(func(slot): return slot.item == item)
	for slot in item_slots:
		if left > 0:
			if slot.amount > left:
				slot.amount -= left
				updated.emit()
				return n
			else:
				left -= slot.amount
				removeSlot(slot) #TODO: Might not work because we are iterating over the array
	if left > 0:
		updated.emit()
	return n - left

	
			
func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0 : return
	
	remove_at_index(index)
	
func remove_at_index(index: int) -> void:
	slots[index] = InventorySlot.new()
	updated.emit()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	
func use_item_at_index(index: int) -> void:
	if index < 0 || index >= slots.size() || !slots[index].item: return
	
	var slot = slots[index]
	use_item.emit(slot.item)
	updated.emit()
	
	if not slot.item is Tool:
		if slot.amount > 1:
			slot.amount -= 1
			updated.emit()
		else:
			remove_at_index(index)
			
#Returns the amount of said item in the inventory, -1 if none
func find_item(item: Item) -> int:
	var total : int = 0
	for slot in slots:
		if slot.item && slot.item.name == item.name:
			total += slot.amount
	return total if total > 0 else -1

#Sells one or all of the required item and adds the money to the player's wallet. Returns the amount of items sold
func sellN(item: Item, all: bool, unit_price: int) -> int :
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if item_slots.is_empty(): return 0
	var total = 0
	for slot in item_slots:
		if all:
			total += slot.amount
			removeSlot(slot)
		else:
			total += 1
			slot.amount -= 1
			if slot.amount == 0:
				removeSlot(slot)
			break
	Global.money += unit_price * total
	updated.emit()
	return total

#Returns the tool with the given name if it is in the inventory, null otherwise
func get_tool(name: String) -> Tool:
	for slot in slots:
		if slot.item && slot.item.name == name:
			return slot.item as Tool
	return null
	
