extends Node2D

@onready var ground : TileMapLayer = $LayerGroup/Ground
@onready var crops : TileMapLayer = $LayerGroup/Crops
@onready var wheat_item : Item = preload("res://Inventory/Items/wheat.tres")
@onready var stick_item: Item = preload("res://Inventory/Items/stick.tres")
@onready var stone_item: Item = preload("res://Inventory/Items/stone.tres")
@onready var inventory_gui : Control = Global.inventory_gui

const TILEMAP_SCALING : float = 0.25
const TILE_SIDE_SIZE : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start(Vector2(380, 185))
	Global.world_size = ground.get_used_rect().size * TILE_SIDE_SIZE * TILEMAP_SCALING
	GlobalScene.get_node("ambiance").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_tile_pos : Vector2i = ground.local_to_map($Player.position / TILEMAP_SCALING)
	$Cursor.position = player_tile_pos * TILE_SIDE_SIZE * TILEMAP_SCALING + $Cursor.texture.get_size()/2 + Vector2(2, 2)
	
	checkActions()

func checkActions():
	if Input.is_action_just_pressed("Interact"):
		var player : Player = $Player
		var selected_item : Item = inventory_gui.get_selected_item()
		var viewing_tile : Vector2i = ground.local_to_map(player.position / TILEMAP_SCALING)
		viewing_tile.clamp(Vector2i.ZERO, ground.get_used_rect().size)
		var ground_atlas : Vector2i = ground.get_cell_atlas_coords(viewing_tile)
		
		#If clicked tile has grown wheat, add 2 wheat to inventory and remove the wheat from the tile
		#Also set the tile to dirt or second stage of watered soil
		if crops.get_cell_atlas_coords(viewing_tile) == Vector2i(2,0) :
			inventory_gui.insert_at(wheat_item, 5, 2)
			Global.display_indicator(2, Global.player_looking_position, Color.WHITE)
			crops.set_cell(viewing_tile)
			#Set ground if second stage of watered soil else set to second stage
			ground.set_cell(viewing_tile, 0, Vector2i(1,0)) if ground_atlas == Vector2i(4,0) else ground.set_cell(viewing_tile, 0, Vector2i(4,0))
			$planter.play(0.5)
			print("Harvested")

		#If player has hoe (not broken) and tile is dirt, plow the tile
		elif selected_item && selected_item.name  == "hoe" && selected_item.state > 0 :
			#If dirt
			if ground_atlas == Vector2i(1,0) :
				$creuser.play()
				#If full durability plow entirely else only half plow
				if !Global.efficiency_decline || selected_item.state == Tool.STATE.good:
					await animateTile(viewing_tile, false)
				else:
					ground.set_cell(viewing_tile,0,Vector2i(2,0))
				inventory_gui.use_item()
				print("Plowed")
			#If half_tilted_dirt
			elif ground_atlas == Vector2i(2,0) :
				$creuser.play()
				ground.set_cell(viewing_tile,0,Vector2i(0,1))
				inventory_gui.use_item()
				print("Plowed")
			
		#If player has bucket (not broken) and tile is tilled soil, water the soil
		elif selected_item && selected_item.name == "bucket" && selected_item.state > Tool.STATE.broken :
			var current_water_level: int = 0
			match (ground_atlas):
				Vector2i(0,1): current_water_level = 0
				Vector2i(1,1): current_water_level = 1
				Vector2i(2,1): current_water_level = 2
				Vector2i(3,1): current_water_level = 3
				_: return
			var used_water = selected_item.useBucket(4 - current_water_level)
			inventory_gui.update()
			if(used_water > 0):
				$water.play()
			var new_water_level = current_water_level + used_water
			match (new_water_level):
				0: ground.set_cell(viewing_tile,0,Vector2i(0,1))
				1: ground.set_cell(viewing_tile,0,Vector2i(1,1))
				2: ground.set_cell(viewing_tile,0,Vector2i(2,1))
				3: ground.set_cell(viewing_tile,0,Vector2i(3,1))
				4: await animateTile(viewing_tile, true)
			print("Watered")

		#If player has wheat and tile is empty field, plant the wheat
		elif selected_item && selected_item.name == "wheat" && (ground_atlas == Vector2i(4,1) || ground_atlas == Vector2i(4,0)) && crops.get_cell_atlas_coords(viewing_tile) == Vector2i(-1,-1) :
			crops.set_cell(viewing_tile,1,Vector2i(0,0))
			inventory_gui.use_item()
			$planter.play(0.5)
			print("Planted")

func animateTile(position: Vector2i, water: bool):
	if water:
		for i in range(14):
			ground.set_cell(position,1,Vector2i(i,0))
			await get_tree().create_timer(0.05).timeout
		ground.set_cell(position,0,Vector2i(4,1))
	else:
		for i in range(10):
			ground.set_cell(position,1,Vector2i(i,1))
			await get_tree().create_timer(0.05).timeout
		ground.set_cell(position,0,Vector2i(0,1))

#This function does not check every softlock possibilty but only 2
func checkSoftLock() -> void:
	var hammer : Tool = inventory_gui.get_tool("hammer")
	if hammer:
		#House, workbench and hammer broken -> can't finish the game
		if $House.state == Building.STATE.broken && $Etabli.state == Building.STATE.broken && hammer.state == Tool.STATE.broken:
			print("SOFTLOCK1")
	
	#If the house is broken and you'll never have enough resources to repair it -> softlock
	var cost_to_repair_house : Vector2i = Vector2i(4,2)
	if $House.state == Building.STATE.broken && (($Forest.state == Building.STATE.broken && inventory_gui.find_item(stick_item) < cost_to_repair_house[0]) || ($Quarry.state == Building.STATE.broken && inventory_gui.find_item(stone_item) < cost_to_repair_house[1])):
		print("SOFTLOCK2") #TODO: Check that this actually works
	


func _on_world_timer_timeout():
	checkSoftLock()
