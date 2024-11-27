extends Node
var gameVariation : int
var inventory_gui

@export var money : int = 0
const MONEY_TO_WIN : int = 500

var world_size: Vector2i

var chewy_regular : Font = preload("res://Assets/Fonts/Chewy-Regular.ttf")

var player_looking_position : Vector2

func display_indicator(value, position: Vector2 = player_looking_position, color: Color = Color.WHITE) -> void:
	var indicator = Label.new()
	indicator.global_position = position
	indicator.text = "+" + str(value)
	indicator.z_index = 10
	indicator.label_settings = LabelSettings.new()
	indicator.label_settings.font_color = color
	indicator.label_settings.font_size = 18
	indicator.label_settings.font = chewy_regular
	indicator.label_settings.outline_color = "#000"
	indicator.label_settings.outline_size = 1
	
	call_deferred("add_child", indicator)
	
	await indicator.resized
	indicator.pivot_offset = Vector2(indicator.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		indicator, "position:y", indicator.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		indicator, "position:y", indicator.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		indicator, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	indicator.queue_free()
	
	
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	gameVariation = randi_range(1,3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
