extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_detected_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$anim.play("opening")
		await $anim.animation_finished
		$anim.play("open")


func _on_player_detected_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$anim.play("closing")
		await $anim.animation_finished
		$anim.play("close")