extends Button

@onready var backgroundSprite: Sprite2D = $Background
@onready var container: CenterContainer = $CenterContainer

var itemStackGui : ItemStackGUI

func insert(isg: ItemStackGUI):
	itemStackGui = isg
	backgroundSprite.frame = 1
	container.add_child(itemStackGui)

func takeItem():
	var item = itemStackGui
	
	container.remove_child(itemStackGui)
	itemStackGui = null
	backgroundSprite.frame = 0
	
	return item
