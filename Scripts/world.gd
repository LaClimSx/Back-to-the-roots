extends Node2D

@onready var ground : TileMapLayer = $LayerGroup/Ground
@onready var crops : TileMapLayer = $LayerGroup/Crops
@onready var wheat_item = preload("res://Inventory/Items/wheat.tres")
@onready var inventory_gui : Control = $CanvasLayer/Inventory


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start(Vector2(556, 324))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkActions()


func checkActions():
	'''
	if Input.is_action_just_pressed("Right_click"):
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_map_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		print(tile_map_pos)
		var current_tile_atlas : Vector2i = tile_map.get_cell_atlas_coords(0,tile_map_pos)
		tile_map.set_cell(0,tile_map_pos,1,Vector2i(10,4)) if current_tile_atlas == Vector2i(1,1) else tile_map.set_cell(0,tile_map_pos,1,Vector2i(3,3))
		
		#If clicked tile has grown carrot, add carrot to inventory
		if tile_map.get_cell_atlas_coords(1,tile_map_pos) == Vector2i(4,1) :
			$Player.inventory.insert(carrot_item)		
	'''
	
	if Input.is_action_just_pressed("Interact"):
		var player : Player = $Player
		var selected_item : Item = inventory_gui.get_selected_item()
		var player_tile_pos : Vector2i = ground.local_to_map(player.position)
		var viewing_tile : Vector2i
		match player.direction:
			0:
				viewing_tile = player_tile_pos + Vector2i(-1,0)
			1:
				viewing_tile = player_tile_pos + Vector2i(1,0)
			2:
				viewing_tile = player_tile_pos + Vector2i(0,-1)
			3:
				viewing_tile = player_tile_pos + Vector2i(0,1)
		viewing_tile.clamp(Vector2i.ZERO, ground.get_used_rect().size)
		print(viewing_tile)
		
		#If clicked tile has grown wheat, add 1 to 3 wheat to inventory and remove the wheat from the tile
		if crops.get_cell_atlas_coords(viewing_tile) == Vector2i(2,0) :
			for i in range(randi_range(1,3)): $Player.inventory.insert(wheat_item)
			crops.set_cell(viewing_tile)
			print("Harvested")

		#If player has hoe (not broken) and tile is dirt, plow the tile
		elif selected_item && selected_item.name  == "hoe" && selected_item.durability >= 1 && ground.get_cell_atlas_coords(viewing_tile) == Vector2i(10,4) :
			ground.set_cell(viewing_tile,0,Vector2i(1,0))
			inventory_gui.use_item()
			print("Plowed")

		#If player has wheat and tile is empty field, plant the wheat
		elif selected_item && selected_item.name == "wheat" && ground.get_cell_atlas_coords(viewing_tile) == Vector2i(2,0) && crops.get_cell_atlas_coords(viewing_tile) == Vector2i(-1,-1) :
			crops.set_cell(viewing_tile,1,Vector2i(0,0))
			inventory_gui.use_item()
			print("Planted")

func _on_timer_timeout() -> void:
	pass # Replace with function body.
