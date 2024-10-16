extends Control

var isOpen: bool = true

func _ready():
	pass

func open():
	visible = true
	isOpen = true
	
func close():
	visible = false
	isOpen = false
