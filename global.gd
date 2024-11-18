extends Node
var gameVariation : int


# Called when the node enters the scene tree for the first time.
func _ready():
	gameVariation = randi_range(1,3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
