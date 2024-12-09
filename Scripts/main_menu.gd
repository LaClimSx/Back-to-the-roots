extends Control

var variante1 = "Attention tout se détruit et s'émousse ! 
Les outils et bâtiments s'abîment, les taux d'échanges baissent et les coûts de réparation augmentent 
Vous jouerez 3 parties de 5 minutes : gérez vos ressources et essayez d'obtenir le plus de points possible !"
var variante2 = "Attention tout se détruit ! 
Les outils et bâtiments s'abîment et les coûts de réparation augmentent
Vous jouerez 3 parties de 5 minutes : gérez vos ressources et essayez d'obtenir le plus de points possible !"
var variante3 = "Attention tout se détruit ! 
Les outils et les bâtiments s'abîment
Vous jouerez 3 parties de 5 minutes : gérez vos ressources et essayez d'obtenir le plus de points possible !"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/Interactions.visible = false
	$Panel/Start.visible = false
	$Panel/ToEnd.visible = false
	match Global.game_number:
		0:
			$Panel/controls.visible = true
			$Panel/Button.text = "Continuer"
			match Global.game_variation :
				1 :
					$Panel/text.text = variante1
				2 :
					$Panel/text.text = variante2
				3 :
					$Panel/text.text = variante3
		1:
			$Panel/controls.visible = false
			$Panel/text.text = "Félicitations, vous avez fini votre première partie avec un score de " + str(Global.scores[Global.game_number - 1]) + ".\n Essayez d'améliorer votre score !"
			$Panel/Button.text = "Rejouer"
		2:
			$Panel/controls.visible = false
			$Panel/text.text = "Félicitations, vous avez fini votre deuxième partie avec un score de " + str(Global.scores[Global.game_number - 1]) + ".\n Si vous pensez pouvoir faire mieux, vous pouvez tenter une troisième partie. Sinon vous pouvez aller directement à la fin."
			$Panel/Button.text = "Rejouer"
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
