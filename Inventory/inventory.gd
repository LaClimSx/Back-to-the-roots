extends Resource

class_name Inventory

signal updated
signal use_item

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
	
