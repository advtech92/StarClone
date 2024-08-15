extends Area2D

@export var crop_type: String
var growth_time: float
var stages: int
var sprite_paths: Array

var current_stage: int = 0
var timer: Timer

# Load crop configurations
var crop_config = load("res://data/crop_config.json").get_data()

# Called when the node is added to the scene
func _ready():
	if crop_type in crop_config:
		growth_time = crop_config[crop_type]["growth_time"]
		stages = crop_config[crop_type]["stages"]
		sprite_paths = crop_config[crop_type]["sprite_paths"]
	else:
		print("Unknown crop type: ", crop_type)
		return

	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

	start_growing()

# Start the growth process
func start_growing():
	if current_stage < stages:
		timer.start(growth_time / stages)

# Called when the timer times out
func _on_timer_timeout():
	current_stage += 1
	update_crop_stage()
	
	if current_stage < stages:
		start_growing()

# Update the crop's visual representation for the current stage
func update_crop_stage():
	if current_stage - 1 < sprite_paths.size():
		var sprite = $Sprite
		sprite.texture = load(sprite_paths[current_stage - 1])
