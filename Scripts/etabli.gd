extends Building


# Called when the node enters the scene tree for the first time.
func _ready():
	reparable = true
	interactable = true
	corresponding_item_name = ""
	repair_label = $RepairLabel
	interact_label = $InteractLabel
	interact_label.text = tr("REPAIR_TOOLS_SPACE") if Global.reparability else tr("CRAFT_TOOLS_SPACE")
	repair_label.text = tr("REPAIR_SPACE")
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)

func animate():
	match state:
		STATE.good:
			$AnimatedSprite2D.play("établi_bon")
		STATE.mid:
			$AnimatedSprite2D.play("établi_abimé")
		STATE.broken:
			$AnimatedSprite2D.play("établi_cassé")
			interact_label.hide()

func interact():
	s_state.emit(state)
	$InteractMenuEtabli.is_open = true
	get_tree().paused = true
	$InteractMenuEtabli/Anim.play("TransIN")

func repair():
	$RepairMenu.is_open = true
	get_tree().paused = true
	$RepairMenu/Anim.play("TransIN")

func _on_world_timer_timeout():
	timer_timeout()


func _on_area_2d_body_entered(body):
	enter_area(body)


func _on_area_2d_body_exited(body):
	exit_area(body)
