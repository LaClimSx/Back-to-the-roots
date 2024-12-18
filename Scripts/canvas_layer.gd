extends CanvasLayer

@onready var inventory = $Inventory

func _ready() -> void:
	$ScoreObjective.text = tr("DEV_SCORE").format({"dev_score": Global.dev_score})

#func _input(event):
#	if event.is_action_pressed("toggle_inventory"):
#		inventory.close() if inventory.isOpen else inventory.open()

func _on_inventory_score_updated(): 
	$ScoreCounter.text = tr("SCORE").format({"score": Global.score})
	
func _process(delta):
	var time_left = Global.timer.time_left
	var min: String = str(int(time_left) / 60)
	var sec_nbr = int(time_left) % 60
	var sec : String = str(sec_nbr) if sec_nbr >= 10 else "0" + str(sec_nbr)
	$TimeLeft.text = tr("TIME_LEFT").format({"min": min, "sec": sec})
