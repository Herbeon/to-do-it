extends Node2D

@onready var timer = $Timer
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(30)
	label.text = str(int(timer.time_left * 1000) / 1000.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(int(timer.time_left * 1000) / 1000.0)
