extends StaticBody2D

var health
var max_health
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
			

func _on_player_detected_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if(health >= max_health/2):
			$porte.play("opening_bon")
			await $porte.animation_finished
			$porte.play("ouvert_bon")
		elif health!= 0:
			$porte.play("opening_abimé")
			await $porte.animation_finished
			$porte.play("ouvert_abimé")


func _on_player_detected_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		if(health > max_health/2):
			$porte.play("closing_bon")
			await $porte.animation_finished
			$porte.play("fermé_bon")
		elif health!= 0:
			$porte.play("closing_abimé")
			await $porte.animation_finished
			$porte.play("fermé_abimé")


func _on_house_actual_health(h: int) -> void:
	health = h
	if(health == max_health):
		$porte.play("fermé_bon")
	elif health== max_health/2:
		$porte.play("fermé_abimé")
	elif health == 0:
		$porte.play("fermé_cassé")
	
func _on_house_s_max_health(mh: int) -> void:
	max_health = mh
