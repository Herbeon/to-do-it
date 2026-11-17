extends Node2D


# Called when the node enters the scene tree for the first time.

@onready var p1 = $player1
@onready var circle = $circle

var score = 0


func _ready() -> void:
	p1.went_left.connect(p1_went_left)
	p1.went_right.connect(p1_went_right)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func p1_went_left():
	pass
func p1_went_right():
	pass
