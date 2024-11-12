extends Panel

class_name ItemStackGUI

@onready var itemSprite: Sprite2D = $Item
@onready var amountLabel: Label = $Label

const TARGET_SIZE = Vector2(16,16)

var slot

func update():
	if !slot || !slot.item: return
	itemSprite.visible = true
	itemSprite.texture = slot.item.texture
	var current_size = itemSprite.texture.get_size()
	itemSprite.scale = TARGET_SIZE / current_size
	amountLabel.visible = true if slot.amount > 1 else false
	amountLabel.text = str(slot.amount)
