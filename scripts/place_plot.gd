extends Node2D

@export var plot_scene: PackedScene  # Reference to the plot scene to instance

# Called when the node is added to the scene
func _ready():
	set_process_input(true)

# Handle input events for plot placement
func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var plot_position = get_global_mouse_position()
		place_plot(plot_position)

# Place a plot at the given position
func place_plot(position: Vector2):
	var plot_instance = plot_scene.instantiate()
	plot_instance.position = position
	add_child(plot_instance)
