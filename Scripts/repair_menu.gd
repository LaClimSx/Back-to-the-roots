extends CanvasLayer

var wood_cost
var stone_cost
var max_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/stone.text = "x" + str(stone_cost) + " stone(s)"
	$Control/wood.text = "x" + str(wood_cost) + " woods(s)"
	pass


func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_repair_pressed() -> void:
	# TODO faire des bails avec les ressources + enlever durabilité marteau
	$Anim.play("TransOUT")
	get_tree().paused = false

func _on_house_s_durability(d: int) -> void:
	if(d == max_health):
		wood_cost = 0
		stone_cost = 0
	elif d == max_health/2:
		wood_cost = 2
		stone_cost = 1
	elif d == 0:
		wood_cost = 4
		stone_cost = 2


func _on_house_s_max_durability(md: int) -> void:
	max_health = md
