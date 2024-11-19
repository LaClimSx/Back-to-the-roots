extends Building

signal actual_exchange(p: int)
var exchange : int


# Called when the node enters the scene tree for the first time.
func _ready():
	exchange = 3
	reparable = true
	interactable = true
	corresponding_item_name = ""
	repair_label = get_node("Repair label")
	interact_label = get_node("Interract Label")
	actual_exchange.emit(exchange)
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func animate():
	match state:
		STATE.good:
			$AnimatedSprite2D.play("moulin_bon")
		STATE.mid:
			$AnimatedSprite2D.play("moulin_abimé")
			exchange = 1
			actual_exchange.emit(exchange)
		STATE.broken:
			$AnimatedSprite2D.play("moulin_cassé")
			interact_label.hide()

func interact():
	get_tree().paused = true
	get_node("Interact Menu Moulin/Anim").play("TransIN")

func repair():
	get_tree().paused = true
	get_node("RepairMenuMoulin/Anim").play("TransIN")

func _on_world_timer_timeout():
	timer_timeout()

func _on_area_2d_body_entered(body):
	enter_area(body)

func _on_area_2d_body_exited(body):
	exit_area(body)
