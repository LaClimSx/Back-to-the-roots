extends CanvasLayer

@onready var flour = preload("res://Inventory/Items/flour.tres")

var inventory_gui
var max_health

var max = 0
var mid = 0.5
var low = 1
		
var outil_cost_stone = 4
var outil_cost_wood = 2
var seau_stone = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_pressed() -> void:
	get_node("Anim").play("TransOUT")
	get_tree().paused = false


func _on_etabli_s_durability(d):
	var multi = 0
	
	var marteau = preload("res://Inventory/Items/hammer.tres")
	var hache = preload("res://Inventory/Items/axe.tres")
	var pioche = preload("res://Inventory/Items/pickaxe.tres")
	var fau = preload("res://Inventory/Items/hoe.tres")
	var seau = preload("res://Inventory/Items/bucket.tres")
	if(d == max_health):
		multi = 1
	elif d == max_health/2:
		multi = 2
		
	if(marteau.state == 2):
		$"Control/wood hammer".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones hammer".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
	elif(marteau.state == 1):
		$"Control/wood hammer".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones hammer".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
	else:
		$"Control/wood hammer".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones hammer".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
		
	if(hache.state == 2):
		$"Control/wood hache".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones hache".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
	elif(hache.state == 1):
		$"Control/wood hache".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones hache".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
	else:
		$"Control/wood hache".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones hache".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
		
	if(pioche.state == 2):
		$"Control/wood pioche".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones pioche".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
	elif(pioche.state == 1):
		$"Control/wood pioche".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones pioche".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
	else:
		$"Control/wood pioche".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones pioche".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
	
	if(fau.state == 2):
		$"Control/wood fau".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones fau".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
	elif(fau.state == 1):
		$"Control/wood fau".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones fau".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
	else:
		$"Control/wood fau".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones fau".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
	
	if(seau.state == 2):
		$"Control/wood seau".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones seau".text = "x" + str(seau_stone) + " pierres"
	elif(seau.state == 1):
		$"Control/wood seau".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones seau".text = "x" + str(seau_stone) + " pierres"
	else:
		$"Control/wood seau".text = "x" + str(outil_cost_wood*low*multi) + " bois"
		$"Control/stones seau".text = "x" + str(seau_stone) + " pierres"


func _on_etabli_s_max_durability(md: int) -> void:
	max_health = md
	
func _on_repare_hammer_pressed() -> void:
	pass # Replace with function body.


func _on_repare_hache_pressed() -> void:
	pass # Replace with function body.


func _on_repare_pioche_pressed() -> void:
	pass # Replace with function body.


func _on_repare_fau_pressed() -> void:
	pass # Replace with function body.


func _on_repare_seau_pressed() -> void:
	pass # Replace with function body.
