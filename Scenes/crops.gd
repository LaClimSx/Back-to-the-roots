extends TileMapLayer

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()

const TIME_TO_GROW : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#Make the plants grow
func _on_world_timer_timeout():
	for cell_position in get_used_cells():
		match get_cell_atlas_coords(cell_position):
			Vector2i(2,1):
				if rng.randi_range(1,TIME_TO_GROW) == 1 : set_cell(cell_position, 2, Vector2i(3,1))
			Vector2i(3,1):
				if rng.randi_range(1,TIME_TO_GROW) == 1 : set_cell(cell_position, 2, Vector2i(4,1))
