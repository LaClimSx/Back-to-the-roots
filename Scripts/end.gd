extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score = Global.scores.max()
	$"Panel/text fin".text = tr("ENDTEXT").format({"score" : score, "game_var": Global.game_variation})
