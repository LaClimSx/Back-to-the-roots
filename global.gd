extends Node
var gameVariation : int
var inventory_gui

@export var money : int = 0
const MONEY_TO_WIN : int = 500

var world_size: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	gameVariation = randi_range(1,3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
