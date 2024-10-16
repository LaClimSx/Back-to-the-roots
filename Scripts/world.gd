extends Node2D

@onready var tile_map : TileMap = $TileMap
@onready var carrot_item = preload("res://Inventory/Items/carrot.tres")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.start(Vector2(556, 324))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Interact"):
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tile_map_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		print(tile_map_pos)
		var current_tile_atlas : Vector2i = tile_map.get_cell_atlas_coords(0,tile_map_pos)
		tile_map.set_cell(0,tile_map_pos,1,Vector2i(10,4)) if current_tile_atlas == Vector2i(1,1) else tile_map.set_cell(0,tile_map_pos,1,Vector2i(3,3))
		
		#If clicked tile has grown carrot, add carrot to inventory
		if tile_map.get_cell_atlas_coords(1,tile_map_pos) == Vector2i(4,1) :
			$Player.inventory.insert(carrot_item)
