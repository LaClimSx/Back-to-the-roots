extends CanvasLayer

@onready var wood = preload("res://Inventory/Items/stick.tres")
@onready var stones = preload("res://Inventory/Items/stone.tres")

var inventory_gui
signal damage_building

var nb_wood 
var nb_stone

var max = 0
var mid = 0.5
var low = 1
var multi = 0

var outil_cost_stone = 4
var outil_cost_wood = 2
var seau_stone = 0

var hache_cost: Vector2i = Vector2i(0,0)
var pioche_cost: Vector2i = Vector2i(0,0)
var fau_cost: Vector2i = Vector2i(0,0)
var seau_cost: Vector2i = Vector2i(0,0)
var marteau_cost: Vector2i = Vector2i(0,0)

var marteau 
var hache 
var pioche 
var fau 
var seau

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.inventory_gui:
		inventory_gui = Global.inventory_gui
	$Control/repare_hache.disabled = true
	$Control/repare_pioche.disabled = true
	$Control/repare_fau.disabled = true
	$Control/repare_seau.disabled = true
	$Control/repare_hammer.disabled = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	nb_wood = inventory_gui.find_item(wood)
	nb_stone = inventory_gui.find_item(stones)		
	
	if(marteau.state == 2):
		$"Control/wood hammer".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones hammer".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
		marteau_cost = Vector2(outil_cost_wood*max*multi,outil_cost_stone*max*multi)
	elif(marteau.state == 1):
		$"Control/wood hammer".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones hammer".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
		marteau_cost = Vector2(outil_cost_wood*mid*multi,outil_cost_stone*mid*multi)
	else:
		$"Control/wood hammer".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones hammer".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
		marteau_cost = Vector2(outil_cost_wood*low*multi,outil_cost_stone*low*multi)
		
	if(hache.state == 2):
		$"Control/wood hache".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones hache".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
		hache_cost = Vector2(outil_cost_wood*max*multi,outil_cost_stone*max*multi)
	elif(hache.state == 1):
		$"Control/wood hache".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones hache".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
		hache_cost = Vector2(outil_cost_wood*mid*multi,outil_cost_stone*mid*multi)
	else:
		$"Control/wood hache".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones hache".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
		hache_cost = Vector2(outil_cost_wood*low*multi,outil_cost_stone*low*multi)
	
	if(pioche.state == 2):
		$"Control/wood pioche".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones pioche".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
		pioche_cost = Vector2(outil_cost_wood*max*multi,outil_cost_stone*max*multi)
	elif(pioche.state == 1):
		$"Control/wood pioche".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones pioche".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
		pioche_cost = Vector2(outil_cost_wood*mid*multi,outil_cost_stone*mid*multi)
	else:
		$"Control/wood pioche".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones pioche".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
		pioche_cost = Vector2(outil_cost_wood*low*multi,outil_cost_stone*low*multi)
	
	if(fau.state == 2):
		$"Control/wood fau".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones fau".text = "x" + str(outil_cost_stone*max*multi) + " pierres"
		fau_cost = Vector2(outil_cost_wood*max*multi,outil_cost_stone*max*multi)
	elif(fau.state == 1):
		$"Control/wood fau".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones fau".text = "x" + str(outil_cost_stone*mid*multi) + " pierres"
		fau_cost = Vector2(outil_cost_wood*mid*multi,outil_cost_stone*mid*multi)
	else:
		$"Control/wood fau".text = "x" + str(outil_cost_wood*low*multi) +" bois"
		$"Control/stones fau".text = "x" + str(outil_cost_stone*low*multi) + " pierres"
		fau_cost = Vector2(outil_cost_wood*low*multi,outil_cost_stone*low*multi)
	
	if(seau.state == 2):
		$"Control/wood seau".text = "x" + str(outil_cost_wood*max*multi) +" bois"
		$"Control/stones seau".text = "x" + str(seau_stone) + " pierres"
		seau_cost = Vector2(outil_cost_wood*max*multi,outil_cost_stone*max*multi)
	elif(seau.state == 1):
		$"Control/wood seau".text = "x" + str(outil_cost_wood*mid*multi) +" bois"
		$"Control/stones seau".text = "x" + str(seau_stone) + " pierres"
		seau_cost = Vector2(outil_cost_wood*mid*multi,outil_cost_stone*mid*multi)
	else:
		$"Control/wood seau".text = "x" + str(outil_cost_wood*low*multi) + " bois"
		$"Control/stones seau".text = "x" + str(seau_stone) + " pierres"
		seau_cost = Vector2(outil_cost_wood*low*multi,outil_cost_stone*low*multi)
	
	if(hache_cost.x <= nb_wood && hache_cost.y <= nb_stone):
		$Control/repare_hache.disabled = false
	else:
		$Control/repare_hache.disabled = true
	
	if(pioche_cost.x <= nb_wood && pioche_cost.y <= nb_stone):
		$Control/repare_pioche.disabled = false
	else:
		$Control/repare_pioche.disabled = true
	
	if(fau_cost.x <= nb_wood && fau_cost.y <= nb_stone):
		$Control/repare_fau.disabled = false
	else:
		$Control/repare_fau.disabled = true
	
	if(seau_cost.x <= nb_wood && seau_cost.y <= nb_stone):
		$Control/repare_seau.disabled = false
	else:
		$Control/repare_seau.disabled = true
	
	if(marteau_cost.x <= nb_wood && marteau_cost.y <= nb_stone):
		$Control/repare_hammer.disabled = false
	else:
		$Control/repare_hammer.disabled = true
	
	

func _on_close_pressed() -> void:
	$Anim.play("TransOUT")
	get_tree().paused = false


func _on_etabli_s_state(s: Building.STATE):
	
	marteau = inventory_gui.get_tool("hammer")
	hache = inventory_gui.get_tool("axe")
	pioche = inventory_gui.get_tool("pickaxe")
	fau = inventory_gui.get_tool("hoe")
	seau = inventory_gui.get_tool("bucket")
	if s == Building.STATE.good:
		multi = 1
	elif s == Building.STATE.mid:
		multi = 2

func _on_repare_hammer_pressed() -> void:
	marteau.repair()
	inventory_gui.remove_item(wood, marteau_cost.x)
	inventory_gui.remove_item(stones, marteau_cost.y)
	damage_building.emit()


func _on_repare_hache_pressed() -> void:
	if hache_cost != Vector2i(0,0) : 
		hache.repair()
		inventory_gui.remove_item(wood, hache_cost.x)
		inventory_gui.remove_item(stones, hache_cost.y)
		damage_building.emit()


func _on_repare_pioche_pressed() -> void:
	if pioche_cost != Vector2i(0, 0):
		pioche.repair()
		inventory_gui.remove_item(wood, pioche_cost.x)
		inventory_gui.remove_item(stones, pioche_cost.y)
		damage_building.emit()


func _on_repare_fau_pressed() -> void:
	if fau_cost != Vector2i(0, 0):
		fau.repair()
		inventory_gui.remove_item(wood, fau_cost.x)
		inventory_gui.remove_item(stones, fau_cost.y)
		damage_building.emit()


func _on_repare_seau_pressed() -> void:
	if seau_cost != Vector2i(0, 0):
		seau.repair()
		inventory_gui.remove_item(wood, seau_cost.x)
		inventory_gui.remove_item(stones, seau_cost.y)
		damage_building.emit()
