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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.gameVariation :
		1 :
			$Panel/text.text = variante1
		2 :
			$Panel/text.text = variante2
		3 :
			$Panel/text.text = variante3


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
	Global.timer.start()
