extends Panel

class_name ItemStackGUI

@onready var itemSprite: Sprite2D = $Item
@onready var amountLabel: Label = $Label

var slot

func update():
	if !slot || !slot.item: return
	itemSprite.visible = true
	itemSprite.texture = slot.item.texture
	amountLabel.visible = true if slot.amount > 1 else false
	amountLabel.text = str(slot.amount)
