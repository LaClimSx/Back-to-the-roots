class_name Bucket extends Tool

var quantity : int = 0

var good4 : Texture2D = preload("res://Assets/Outils/Seau/Sans titre 46_20241118145828.png")
var good3 : Texture2D = preload("res://Assets/Outils/Seau/Sans titre 46_20241118145819.png")
var good2 : Texture2D = preload("res://Assets/Outils/Seau/Sans titre 46_20241118145803.png")
var good1 : Texture2D = preload("res://Assets/Outils/Seau/Sans titre 46_20241118145749.png")
var good0 : Texture2D = preload("res://Assets/Outils/Seau/seau_bon_vide.png")

var mid2: Texture2D = preload("res://Assets/Outils/Seau/Sans titre 46_20241118150240.png")
var mid1: Texture2D = preload("res://Assets/Outils/Seau/Sans titre 46_20241118150254.png")
var mid0: Texture2D = preload("res://Assets/Outils/Seau/seau_abimé_vide.png")

var broken: Texture2D = preload("res://Assets/Outils/Seau/seau_cassé.png")


func use(player: Player) -> void:
	pass
	
func useBucket(water_amount: int) -> int:
<S	if quantity <= 0 || state == STATE.broken: return 0
	if durability > 0:
		durability -= 1
		if durability <= maxDurability/3:
			state = STATE.mid
		if durability == 0:
			texture = broken
			state = STATE.broken
			
	if state == STATE.good:
		if water_amount >= quantity : texture = good0
		match (quantity - water_amount):
			1: texture = good1
			2: texture = good2
			3: texture = good3
	elif state == STATE.mid:
		if water_amount >= quantity : texture = mid0
		match (quantity - water_amount):
			1: texture = mid1
			_: texture = mid2
	
	var used_water =  min(quantity, water_amount)
	quantity = quantity - used_water
	return used_water
	
func fillBucket(amount: int) -> void:
	if state == STATE.broken : return
	if state == STATE.good:
		quantity = clamp(quantity + amount, 0, 4)
		match (quantity):
			0: texture = good0
			1: texture = good1
			2: texture = good2
			3: texture = good3
			4: texture = good4
	elif state == STATE.mid:
		quantity = clamp(quantity + amount, 0, 2)
		match (quantity):
			0: texture = mid0
			1: texture = mid1
			2: texture = mid2
	print(quantity)
