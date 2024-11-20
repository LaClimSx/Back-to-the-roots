extends StaticBody2D

var state: Building.STATE
var player_inside : bool = false


func _on_player_detected_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = true
		if(state == Building.STATE.good):
			$porte.play("opening_bon")
			await $porte.animation_finished
			$porte.play("ouvert_bon")
		elif Building.STATE.mid:
			$porte.play("opening_abimé")
			await $porte.animation_finished
			$porte.play("ouvert_abimé")


func _on_player_detected_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_inside = false
		if state == Building.STATE.good:
			$porte.play("closing_bon")
			await $porte.animation_finished
			$porte.play("fermé_bon")
		elif state == Building.STATE.mid:
			$porte.play("closing_abimé")
			await $porte.animation_finished
			$porte.play("fermé_abimé")

	

func _on_s_state(s: Building.STATE) -> void:
	state = s
	if player_inside: return
	match state:
		Building.STATE.good: $porte.play("fermé_bon")
		Building.STATE.mid: $porte.play("fermé_abimé")
		Building.STATE.broken: $porte.play("fermé_cassé")
