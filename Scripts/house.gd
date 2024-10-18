extends StaticBody2D

signal actual_health(h: int)
signal s_max_health(mh: int)

@export var max_health = 5000
@export var loss_health_by_tic = 500
var health = max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("s_max_health", max_health)
	health = max_health
	emit_signal("actual_health", health)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health > max_health/2):
		$AnimatedSprite2D.play("maison_bon")
	elif(health==0):
		$AnimatedSprite2D.play("maison_cassé")	
	else:
		$AnimatedSprite2D.play("maison_abimé")

func _on_world_timer_timeout() -> void:
	health -= loss_health_by_tic
	health = clamp(health, 0, max_health)
	emit_signal("actual_health", health)
