extends StaticBody2D

signal actual_health(h: int)
signal s_max_health(mh: int)

@export var max_health = 5000
@export var loss_health_by_tic = 10
var health = max_health
var player_inside : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("s_max_health", max_health)
	health = max_health
	emit_signal("actual_health", health)
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
	
	if Input.is_action_pressed("Interact") && player_inside:
		get_tree().paused = true
		get_node("Interact Menu/Anim").play("TransIN")
		print("interractionnnn")
		#show right pop up
	elif Input.is_action_pressed("Repair"):
		get_tree().paused = true
		get_node("RepairMenu/Anim").play("TransIN")
		print("repairrrr")
		

func _on_world_timer_timeout() -> void:
	health -= loss_health_by_tic
	health = clamp(health, 0, max_health)
	emit_signal("actual_health", health)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" && health>0: #& tiens pas le marteau
		$"Interract Label".show()
		$"Repair label".show()
		player_inside = true
	#elif body.name == "Player": #& tiens marteau
	#	$"Repair label".show()	
		


func _on_area_2d_body_exited(body: Node2D) -> void:
	$"Interract Label".hide()
	$"Repair label".hide()
	player_inside = false