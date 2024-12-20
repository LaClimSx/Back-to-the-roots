extends Building

# Called when the node enters the scene tree for the first time.
func _ready():
	interactable = true
	corresponding_item_name = "bucket"
	reparable = true
	repair_label = $RepairLabel
	interact_label = null
	repair_label.text = tr("REPAIR_SPACE")
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
	#Check that the bucket isn't already full:
	if (Global.efficiency_decline && selected_item.quantity == selected_item.state * 2) || (!Global.efficiency_decline && selected_item.quantity == 4):
		print("already full")
		return
	print("filling up")
	if state == STATE.good || !Global.efficiency_decline:
		$water.play()
		selected_item.fillBucket(4)
	elif state == STATE.mid:
		$water.play()
		selected_item.fillBucket(2)
	damage_itself()
	inventory_gui.update()
	
func repair():
	$RepairMenu.is_open = true
	get_tree().paused = true
	$RepairMenu/Anim.play("TransIN")
