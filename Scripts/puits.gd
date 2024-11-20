extends Building

# Called when the node enters the scene tree for the first time.
func _ready():
	interactable = true
	corresponding_item_name = "bucket"
	reparable = true
	repair_label = $RepairLabel
	interact_label = null
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func animate():
	match state:
		STATE.good:
			$AnimatedSprite2D.play("puit_bon")
		STATE.mid:
			$AnimatedSprite2D.play("puit_abimé")
		STATE.broken:
			$AnimatedSprite2D.play("puit_cassé")
			repair_label.hide()

func interact():
	print("interacting")
	if state == STATE.good:
		selected_item.fillBucket(4)
	elif state == STATE.mid:
		selected_item.fillBucket(2)
	damage_itself()
	inventory_gui.update()
	
func repair():
	get_tree().paused = true
	$RepairMenu/Anim.play("TransIN")
