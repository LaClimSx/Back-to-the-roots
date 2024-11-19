extends StaticBody2D

signal actual_exchange(p: int)
signal actual_health_moulin(h: int)
signal max_health_moulin(mh: int)


@export var max_health = 50
@export var loss_health_by_tic = 500
var health = max_health
var exchange
var player_inside_moulin
var inventory_gui
var item_moulin

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("max_health_moulin", max_health)
	health = max_health
	emit_signal("actual_health_moulin", max_health)
	exchange = 3
	emit_signal("actual_exchange", exchange)
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	$"Repair label".hide()
	$"Interract Label".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health > max_health/2):
		$AnimatedSprite2D.play("moulin_bon")
	elif(health==0):
		$AnimatedSprite2D.play("moulin_cassé")	
	else:
		$AnimatedSprite2D.play("moulin_abimé")
		exchange = 1
		emit_signal("actual_exchange", exchange)
		
	item_moulin = inventory_gui.get_selected_item()
	
	if (player_inside_moulin && item_moulin && item_moulin.name == "hammer" && item_moulin.state > 0 && health <= max_health/2): 
		$"Repair label".show()
		
	if player_inside_moulin && health>0 :
		$"Interract Label".show()
	
	if(item_moulin && (item_moulin.name != "hammer" || item_moulin.state == 0)): 
		$"Repair label".hide()
	
	if Input.is_action_pressed("Interact") && player_inside_moulin && health>0:
		get_tree().paused = true
		get_node("Interact Menu Moulin/Anim").play("TransIN")
		
		
	elif Input.is_action_pressed("Repair") && health <= max_health/2 && item_moulin && item_moulin.name == "hammer" && player_inside_moulin:
		get_tree().paused = true
		get_node("RepairMenuMoulin/Anim").play("TransIN")


func _on_timer_timeout() -> void:
	health -= loss_health_by_tic
	health = clamp(health, 0, max_health)
	emit_signal("actual_health_moulin", health)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "Player"):
		player_inside_moulin = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.name == "Player"):
		player_inside_moulin = false
		$"Interract Label".hide()
		$"Repair label".hide()
		
