extends Area2D

var player_inside : bool = false
var is_open: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InteractLabel.text = tr("TUTO_SPACE")
	$InteractLabel.hide()
	$InteractPanel/commande.text = tr("TUTO")
	match Global.game_variation :
		1 :
			$"InteractPanel/regles".text = tr("MENU1")
		2 :
			$"InteractPanel/regles".text = tr("MENU2")
		3 :
			$"InteractPanel/regles".text = tr("MENU3")

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Esc") && is_open:
		_on_close_pressed()
		
	if Input.is_action_pressed("Interact") && player_inside:
		is_open = true
		$"InteractPanel".get_parent().get_tree().paused = true
		$"InteractPanel/Anim".play("TransIN")

func _on_close_pressed() -> void:
		$"InteractPanel/Anim".play("TransOUT")
		is_open = false
		$"InteractPanel".get_parent().get_tree().paused = false


func _on_interractionzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		$InteractLabel.show()


func _on_interractionzone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
		is_open = false
		$InteractLabel.hide()
