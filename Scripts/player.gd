class_name Player extends CharacterBody2D

@export var speed = 100
var screen_size
var last_dir = Vector2(0,0)

enum Directions {LEFT, RIGHT, UP, DOWN}
var direction = Directions.LEFT

@export var inventory : Inventory

@export var money : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inventory.use_item.connect(use_item)
	screen_size = get_viewport_rect().size
	hide()


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
		
	move_and_collide(velocity * delta)
	position = position.clamp(Vector2.ZERO, screen_size)
		
	var animation = $AnimatedSprite2D.animation
	
	if velocity.x != 0:
		if velocity.x > 0:
			animation = "walk_right"
			direction = Directions.RIGHT
			#$AnimatedSprite2D.flip_v = false
		else:
			animation = "walk_left"
			direction = Directions.LEFT
	
	elif velocity.y != 0:
		if velocity.y > 0:
			animation = "walk_face"
			direction = Directions.DOWN
			#$AnimatedSprite2D.flip_v = false
		else:
			animation = "walk_dos"
			direction = Directions.UP
	
	else:
		if abs(last_dir.x) >= abs(last_dir.y):
			if last_dir.x > 0:
				animation = "idle_right"
				direction = Directions.RIGHT
			else:
				animation = "idle_left"
				direction = Directions.LEFT
		else:
			if last_dir.y > 0:
				animation = "idle_face"
				direction = Directions.DOWN
			else:
				animation = "idle_dos"
				direction = Directions.UP
		
	$AnimatedSprite2D.animation = animation

func start(pos):
	position = pos
	show()
	
func use_item(item: Item) -> void:
	item.use(self)
	
func add_money(amount: int) -> void:
	money += amount
