extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#TODO: recup le vrai score
	$"Panel/text fin".text = "Merci d'avoir joué !
	
	Note ces quelques informations pour le formulaire :
	Ton meilleur score : " + str(score) + " 
	Ton numéro : " + str(Global.gameVariation) + "
	
	Pour nous aider à mener notre projet à bien tu peux prendre 5 minutes pour remplir ce formulaire :
	"
