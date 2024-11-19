extends StaticBody2D

signal s_health(h: int)
signal s_max_health(mh: int)

@export var max_health = 5000
@export var loss_health_by_tic = 500
var health = max_health
var player_inside_etabli
var inventory_gui
var item_in_hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("s_max_health" ,max_health)
	health = max_health
	emit_signal("s_health", health)
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	$"Repair label".hide()
	$"Interract Label".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health > max_health/2):
		$AnimatedSprite2D.play("établi_bon")
	elif(health==0):
		$AnimatedSprite2D.play("établi_cassé")	
	else:
		$AnimatedSprite2D.play("établi_abimé")
	
	item_in_hand = inventory_gui.get_selected_item()
	
	if (player_inside_etabli && item_in_hand && item_in_hand.name == "hammer" && item_in_hand.state > 0 && health <= max_health/2):
		$"Repair label".show()
		
	if player_inside_etabli && health>0 :
		$"Interract Label".show()
	
	if(item_in_hand && (item_in_hand.name != "hammer" || item_in_hand.state == 0)): 
		$"Repair label".hide()
	
	if Input.is_action_pressed("Interact") && player_inside_etabli:
		get_tree().paused = true
		get_node("Interact Menu Etabli/Anim").play("TransIN")
		
		
	elif Input.is_action_pressed("Repair") && health <= max_health/2 && item_in_hand && item_in_hand.name == "hammer" && player_inside_etabli:
		get_tree().paused = true
		get_node("RepairMenuEtabli/Anim").play("TransIN")


func _on_world_timer_timeout() -> void:
	health -= loss_health_by_tic
	health = clamp(health, 0, max_health)
	emit_signal("s_health", health)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player_inside_etabli = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		player_inside_etabli = false
		$"Interract Label".hide()
		$"Repair label".hide()
