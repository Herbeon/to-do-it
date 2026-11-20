extends Node2D


# Called when the node enters the scene tree for the first time.

@onready var p1 = $player1
@onready var circle = $circle

var score = 0
var crashes = 0

func _ready() -> void:
	p1.went_left.connect(p1_went_left)
	p1.went_right.connect(p1_went_right)
	circle.on_ground.connect(check_for_cross)
	circle.floor_left.connect(floor_left)
	circle.floor_right.connect(floor_right)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func crashed():
	p1.crashed()
	circle.crashed()
	crashes += 1
	
func p1_went_left():
	score += 1
	p1.side = -1
	circle.chopped()
	$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes) + "\nside " + str(p1.side) + "\nheight " + str(circle.height)

func p1_went_right():
	score += 1
	p1.side = 1

	circle.chopped()
	$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes) + "\nside " + str(p1.side) + "\nheight" + str(circle.height)

func floor_left():
	#print("was on left")
	if(p1.side == -1):
		#print("player is on left")
		crashed()
		
func floor_right():
	#print("was on right")
	if(p1.side == 1):
		#print("player is on right")
		crashed()
	
func check_for_cross():
	if(p1.side == circle.height):
		# boom
		crashed()
		
func spawn_circle():
	var choice = [5,-5,0].pick_random()
	if(choice != 0):
		var another_circle = circle.duplicate()
		another_circle.height = choice
		
