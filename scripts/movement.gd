extends CharacterBody2D

@export var move_speed = 100  # Pixels per second
@export var tile_size = 32  # Size of each "space" in pixels

var is_moving = false
var target_position = Vector2.ZERO

# Called when the node is added to the scene
func _ready():
	target_position = position

# Called every frame
func _process(delta):
	if not is_moving:
		handle_input()

	if is_moving:
		move_towards_target(delta)

# Handle player input for movement
func handle_input():
	var direction = Vector2.ZERO

	if Input.is_action_just_pressed("ui_right"):
		direction.x += 1
	elif Input.is_action_just_pressed("ui_left"):
		direction.x -= 1
	elif Input.is_action_just_pressed("ui_down"):
		direction.y += 1
	elif Input.is_action_just_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		set_target_position(direction)

# Set the target position for movement
func set_target_position(direction: Vector2):
	target_position = position + direction * tile_size
	is_moving = true

# Move the player towards the target position
func move_towards_target(delta):
	var distance = move_speed * delta
	position = position.move_toward(target_position, distance)

	if position.distance_to(target_position) < 1:
		position = target_position
		is_moving = false
