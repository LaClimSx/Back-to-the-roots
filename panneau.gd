extends Area2D

var player_inside : bool = false
var is_open: bool = false

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
	$InteractLabel.hide()
	match Global.game_variation :
		1 :
			$"panneau interraction/regles".text = variante1
		2 :
			$"panneau interraction/regles".text = variante2
		3 :
			$"panneau interraction/regles".text = variante3

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Esc") && is_open:
		_on_close_pressed()
		
	if Input.is_action_pressed("Interact") :
		is_open = true
		$"panneau interraction".get_parent().get_tree().paused = true
		$"panneau interraction/Anim".play("TransIN")

func _on_close_pressed() -> void:
		$"panneau interraction/Anim".play("TransOUT")
		is_open = false
		$"panneau interraction".get_parent().get_tree().paused = false


func _on_interractionzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		$InteractLabel.show()


func _on_interractionzone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
		is_open = false
		$InteractLabel.hide()
