extends Resource

class_name Inventory

signal updated

@export var items:Array[Item]

func insert(item : Item):
	for i in range(items.size()):
		if !items[i]:
			items[i] = item
			break
	updated.emit()
