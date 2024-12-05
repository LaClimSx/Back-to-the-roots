extends CanvasLayer

@onready var inventory = $Inventory

func _ready() -> void:
	$ScoreObjective.text = "Score des devs : " + str(Global.DEV_SCORE)

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory.close() if inventory.isOpen else inventory.open()

func _on_inventory_score_updated(): #TODO: Win condition
	#TODO : See if we display the indicator here or in the inventory
	$ScoreCounter.text = "Score : " + str(Global.score)
