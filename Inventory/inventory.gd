extends Resource

class_name Inventory

signal updated

@export var slots: Array[InventorySlot]

func insert(item : Item):
	var item_slots = slots.filter(func(slot): return slot.item == item && slot.amount < slot.item.maxAmount)
	if !item_slots.is_empty():
		item_slots[0].amount+=1
	else:
		var empty_slots = slots.filter(func(slot): return slot.item == null)
		if !empty_slots.is_empty():
			empty_slots[0].item = item
			empty_slots[0].amount = 1
	updated.emit()
			
func removeSlot(inventorySlot: InventorySlot):
	var index = slots.find(inventorySlot)
	if index < 0 : return
	
	slots[index] = InventorySlot.new()
	
func insertSlot(index: int, inventorySlot: InventorySlot):
	slots[index] = inventorySlot
	
	
