extends StaticBody2D

signal actual_health(h: int)
signal s_max_health(mh: int)
signal actual_price(p: int)

@export var max_health = 50
@export var loss_health_by_tic = 10
var health = max_health
var player_inside : bool = false
var price : int = 0
var inventory_gui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	emit_signal("s_max_health", max_health)
	health = max_health
	emit_signal("actual_health", health)
	price = 5
	emit_signal("actual_price", price)
	$"Interract Label".hide()
	$"Repair label".hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health > max_health/2):
		$AnimatedSprite2D.play("maison_bon")
	elif(health==0):
		$AnimatedSprite2D.play("maison_cassé")
		$"Interract Label".hide()	
	else:
		$AnimatedSprite2D.play("maison_abimé")
		price = 3
		emit_signal("actual_price", price)
		
	var item = inventory_gui.get_selected_item()
	
	if player_inside && item && item.name == "pickaxe" && health <= max_health/2: #TODO marteau a durabilité
		$"Repair label".show()
		
	if player_inside && health>0 :
		$"Interract Label".show()
	
	if(item && item.name != "pickaxe"): #TODO ou marteau a plus de durabilité
		$"Repair label".hide()
	
	if Input.is_action_pressed("Interact") && player_inside:
		get_tree().paused = true
		get_node("Interact Menu/Anim").play("TransIN")
		
		
	elif Input.is_action_pressed("Repair") && health <= max_health/2 && item && item.name == "pickaxe" && player_inside:
		get_tree().paused = true
		get_node("RepairMenu/Anim").play("TransIN")
		

func _on_world_timer_timeout() -> void:
	health -= loss_health_by_tic
	health = clamp(health, 0, max_health)
	emit_signal("actual_health", health)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	$"Interract Label".hide()
	$"Repair label".hide()
	player_inside = false
