extends StaticBody2D

@export var max_health = 5000
@export var loss_health_by_tic = 500
var health = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health > max_health/2):
		$AnimatedSprite2D.play("établi_bon")
	elif(health==0):
		$AnimatedSprite2D.play("établi_cassé")	
	else:
		$AnimatedSprite2D.play("établi_abimé")


func _on_world_timer_timeout() -> void:
	health -= loss_health_by_tic
	health = clamp(health, 0, max_health)
