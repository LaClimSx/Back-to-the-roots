extends CanvasLayer

@onready var inventory = $Inventory

func _ready() -> void:
	$ScoreObjective.text = "Score des devs : " + str(Global.dev_score)

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		inventory.close() if inventory.isOpen else inventory.open()

func _on_inventory_score_updated(): #TODO: Win condition
	#TODO : See if we display the indicator here or in the inventory
	$ScoreCounter.text = "Score : " + str(Global.score)
	
func _process(delta):
	var time_left = Global.timer.time_left
	var min: String = str(int(time_left) / 60)
	var sec_nbr = int(time_left) % 60
	var sec : String = str(sec_nbr) if sec_nbr >= 10 else "0" + str(sec_nbr)
	$TimeLeft.text = "Temps restant : " + str(min) + " min " + str(sec)
