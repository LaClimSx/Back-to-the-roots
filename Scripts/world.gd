extends Node2D

@onready var ground : TileMapLayer = $LayerGroup/Ground
@onready var crops : TileMapLayer = $LayerGroup/Crops
@onready var wheat_item = preload("res://Inventory/Items/wheat.tres")
@onready var inventory_gui : Control = Global.inventory_gui

const TILEMAP_SCALING : float = 0.16

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start(Vector2(556, 324))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkActions()


func checkActions():
	if Input.is_action_just_pressed("Interact"):
		var player : Player = $Player
		var selected_item : Item = inventory_gui.get_selected_item()
		var player_tile_pos : Vector2i = ground.local_to_map(player.position / TILEMAP_SCALING)
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
		var ground_atlas : Vector2i = ground.get_cell_atlas_coords(viewing_tile)
		
		#If clicked tile has grown wheat, add 1 to 3 wheat to inventory and remove the wheat from the tile
		if crops.get_cell_atlas_coords(viewing_tile) == Vector2i(2,0) :
			for i in range(randi_range(1,3)): $Player.inventory.insert(wheat_item)
			crops.set_cell(viewing_tile)
			print("Harvested")

		#If player has hoe (not broken) and tile is dirt, plow the tile
		elif selected_item && selected_item.name  == "hoe" && selected_item.state > 0 :
			#If dirt
			if ground_atlas == Vector2i(1,0) :
				#If full durability plow entirely else only half plow
				ground.set_cell(viewing_tile,0,Vector2i(0,1)) if selected_item.state > 1 else ground.set_cell(viewing_tile,0,Vector2i(2,0))
				inventory_gui.use_item()
				print("Plowed")
			#If half_tilted_dirt
			elif ground_atlas == Vector2i(2,0) :
				ground.set_cell(viewing_tile,0,Vector2i(0,1))
				inventory_gui.use_item()
				print("Plowed")

		#If player has wheat and tile is empty field, plant the wheat
		elif selected_item && selected_item.name == "wheat" && ground_atlas == Vector2i(4,1) && crops.get_cell_atlas_coords(viewing_tile) == Vector2i(-1,-1) :
			crops.set_cell(viewing_tile,1,Vector2i(0,0))
			inventory_gui.use_item()
			print("Planted")

func _on_timer_timeout() -> void:
	pass # Replace with function body.
