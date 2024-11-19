extends StaticBody2D

@export var max_health = 5000
@export var loss_health_by_tic = 100
var health = max_health
var player_inside : bool = false

enum STATE {broken, mid, good}
var state: STATE = STATE.good

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health > max_health/2):
		$AnimatedSprite2D.play("puit_bon")
	elif(health==0):
		$AnimatedSprite2D.play("puit_cassé")
		state = STATE.broken
	else:
		$AnimatedSprite2D.play("puit_abimé")
		state = STATE.mid
		
	if player_inside && Input.is_action_just_released("Interact"):
		var selected_item : Item = Global.inventory_gui.get_selected_item()
		if selected_item && selected_item.name == "bucket" && selected_item.state > 0 :
			if state == STATE.good:
				selected_item.fillBucket(4)
			elif state == STATE.mid:
				selected_item.fillBucket(2)
			Global.inventory_gui.update()
			

func _on_world_timer_timeout() -> void:
	health -= loss_health_by_tic
	health = clamp(health, 0, max_health)


func _on_area_2d_body_entered(body):
	if body.name == "Player" && health>0: 
		#$"Repair label".show()
		player_inside = true
	


func _on_area_2d_body_exited(body):
	#$"Repair label".hide()
	player_inside = false
