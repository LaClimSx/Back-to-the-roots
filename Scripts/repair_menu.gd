class_name RepairMenu extends CanvasLayer

var wood_cost: int
var stone_cost: int
var state: Building.STATE
var default_cost: Vector2i
signal repair

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var parent_name: String = get_parent().name
	print(parent_name)
	match parent_name:
		"House": default_cost = Vector2i(2, 1)
		"Moulin": default_cost = Vector2i(1, 2)
		"Etabli": default_cost = Vector2i(2, 1)
		"Puits": default_cost = Vector2i(0, 3)
		_: default_cost = Vector2i(-1, -1) #This should not happen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/stone.text = "x" + str(stone_cost) + " stone(s)"
	$Control/wood.text = "x" + str(wood_cost) + " woods(s)"


func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_repair_pressed() -> void:
	# TODO faire des bails avec les ressources + enlever durabilité marteau
	$Anim.play("TransOUT")
	get_tree().paused = false

func _on_house_s_state(s: Building.STATE) -> void:
	if s == Building.STATE.good:
		wood_cost = 0
		stone_cost = 0
	elif s == Building.STATE.mid:
		wood_cost = default_cost[0]
		stone_cost = default_cost[1]
	elif s == Building.STATE.broken:
		wood_cost = 2 * default_cost[0]
		stone_cost = 2 * default_cost[1]
