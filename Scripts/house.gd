extends Building

var price: int = 0
signal actual_price(p: int)


# Called when the node enters the scene tree for the first time.
func _ready():
	price = 5
	reparable = true
	interactable = true
	corresponding_item_name = ""
	repair_label = $RepairLabel
	interact_label = $InteractLabel
	actual_price.emit(price)
	super()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func animate():
	match state:
		STATE.good:
			$AnimatedSprite2D.play("maison_bon")
		STATE.mid:
			$AnimatedSprite2D.play("maison_abimé")
			price = 3
			actual_price.emit(price)
		STATE.broken:
			$AnimatedSprite2D.play("maison_cassé")
			interact_label.hide()

func interact():
	get_tree().paused = true
	$InteractMenu/Anim.play("TransIN")

func repair():
	get_tree().paused = true
	$RepairMenu/Anim.play("TransIN")

func _on_world_timer_timeout():
	timer_timeout()

func _on_area_2d_body_entered(body):
	enter_area(body)

func _on_area_2d_body_exited(body):
	exit_area(body)
