extends Node
var gameVariation : int
var reparability : bool
var efficiency_decline : bool

var inventory_gui

@export var score : int = 0
const DEV_SCORE : int = 480
var scores : Array[int] = []

var world_size: Vector2i

var chewy_regular : Font = preload("res://Assets/Fonts/Chewy-Regular.ttf")

var player_looking_position : Vector2

var timer : Timer
var game_number

# Called when the node enters the scene tree for the first time.
func _ready():
	#gameVariation = randi_range(1,3) #TODO: uncomment this line and remove the next one
	gameVariation = 1
	match gameVariation:
		1:
			reparability = true
			efficiency_decline = true
		2:
			reparability = true
			efficiency_decline = false
		3:
			reparability = false
			efficiency_decline = false
			
	timer = Timer.new()
	timer.one_shot = false
	timer.wait_time = 5.0 * 60
	timer.timeout.connect(_on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_timer_timeout() -> void:
	scores.append(score)
	
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
	
