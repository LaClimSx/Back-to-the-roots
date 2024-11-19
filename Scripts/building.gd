class_name Building extends StaticBody2D

signal s_durability(d: int)
signal s_max_durability(md: int)

@export var max_durability : int = 5000
@export var loss_dura_by_tic : int = 100
var durability = max_durability
var player_inside : bool = false

@onready var inventory_gui = Global.inventory_gui

var selected_item

#Specific to each building
var reparable : bool = false
var repair_label : Label
var interactable : bool = false
var interact_label : Label
var corresponding_item_name : String

enum STATE {broken, mid, good}
var state: STATE = STATE.good



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	s_max_durability.emit(max_durability)
	durability = max_durability
	s_durability.emit(durability)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if durability > max_durability/2:
		state = STATE.good
	elif durability == 0:
		state = STATE.broken
	else:
		state = STATE.mid
	
	animate()

	selected_item = inventory_gui.get_selected_item()
	var holds_working_hammer : bool = selected_item && selected_item.name == "hammer" && selected_item.state > 0

	#Check if the player can repair the building
	if reparable:
		if player_inside && holds_working_hammer && state != STATE.good:
			if repair_label : repair_label.show()
		else:
			if repair_label : repair_label.hide()

	#Check if the player can interact with the building (and it needs to be displayed)
	if interactable:
		if player_inside && state > 0:
			if interact_label : interact_label.show()
		else:
			if interact_label : interact_label.hide()

	checkInteraction()
	checkRepair(holds_working_hammer)


func checkInteraction() -> void:
	if interactable && player_inside && Input.is_action_just_released("Interact") && state > 0:
		if corresponding_item_name :
			if selected_item && selected_item.name == corresponding_item_name:
				interact()
		else:
			interact()


func checkRepair(holds_working_hammer: bool) -> void:
	if reparable && player_inside && holds_working_hammer && Input.is_action_just_released("Repair") && state != STATE.good:
		repair()


func timer_timeout() -> void:
	durability -= loss_dura_by_tic
	durability = clamp(durability, 0, max_durability)
	s_durability.emit(durability)


func enter_area(body : Node2D) -> void:
	if body.name == "Player":
		player_inside = true


func exit_area(body : Node2D) -> void:
	if body.name == "Player":
		player_inside = false
		if repair_label : repair_label.hide()
		if interact_label : interact_label.hide()
		

func interact() -> void:
	pass

func repair() -> void:
	pass

func animate() -> void:
	pass
