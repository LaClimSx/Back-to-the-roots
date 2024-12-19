extends Node2D

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/LinkButton.text = tr("FORM")
	$Panel/LinkButton.uri = "https://docs.google.com/forms/d/e/1FAIpQLScZFicrxvPb0sCQBfN8kK4m9aLRZvkUkR04hDhDEAgnlUazig/viewform?usp=sf_link" if TranslationServer.get_locale() == "fr" else "https://docs.google.com/forms/d/e/1FAIpQLScUo2auDTp-JVOfQUs9jjvOzxbCIh53ljPaYBJkAE6UhWKWLw/viewform?usp=sf_link"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score = Global.scores.max()
	$"Panel/text fin".text = tr("END_TEXT").format({"score" : score, "game_var": Global.game_variation})
