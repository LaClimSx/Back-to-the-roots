extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/controls.text = tr("TUTO")
	$Panel/Start.text = tr("START")
	$Panel/ToEnd.text = tr("TO_END")
	$Panel/Interactions.visible = false
	$Panel/Start.visible = false
	$Panel/ToEnd.visible = false
	match Global.game_number:
		0:
			$Panel/controls.visible = true
			$Panel/Button.text = tr("NEXT")
			match Global.game_variation :
				1 :
					$Panel/text.text = tr("MENU1")
				2 :
					$Panel/text.text = tr("MENU2")
				3 :
					$Panel/text.text = tr("MENU3")
		1:
			$Panel/controls.visible = false 
			$Panel/text.text = tr("END_GAME_1").format({"score": Global.scores[Global.game_number - 1]})
			$Panel/Button.text = tr("PLAY_AGAIN")
		2:
			$Panel/controls.visible = false
			$Panel/text.text = tr("END_GAME_2").format({"score": Global.scores[Global.game_number - 1]})
			$Panel/Button.text = tr("PLAY_AGAIN")
			$Panel/ToEnd.visible = true
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	if Global.game_number == 0:
		$Panel/Interactions.visible = true
		$Panel/Start.visible = true
	else:
		_on_start_pressed()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	Global.timer.start()


func _on_to_end_pressed():
	get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")
