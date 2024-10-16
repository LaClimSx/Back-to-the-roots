extends Area2D

@export var speed = 400
var screen_size
var last_dir = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		last_dir = velocity
		$AnimatedSprite2D.play()
	#else:
	#	$AnimatedSprite2D.animation = "idle_face"
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
		
	if velocity.x != 0:
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "walk_right"
			#$AnimatedSprite2D.flip_v = false
		else:
			$AnimatedSprite2D.animation = "walk_left"
	
	elif velocity.y != 0:
		if velocity.y > 0:
			$AnimatedSprite2D.animation = "walk_face"
			#$AnimatedSprite2D.flip_v = false
		else:
			$AnimatedSprite2D.animation = "walk_dos"
	
	else:
		if abs(last_dir.x) >= abs(last_dir.y):
			if last_dir.x > 0:
				$AnimatedSprite2D.animation = "idle_right"
			else:
				$AnimatedSprite2D.animation = "idle_left"
		else:
			if last_dir.y > 0:
				$AnimatedSprite2D.animation = "idle_face"
			else:
				$AnimatedSprite2D.animation = "idle_dos"
				
			

func start(pos):
	position = pos
	show()
