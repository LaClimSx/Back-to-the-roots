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


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
