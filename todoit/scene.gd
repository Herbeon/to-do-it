extends Node2D


# Called when the node enters the scene tree for the first time.

@export var playernode = "player1"

@onready var p1 = get_node(playernode)
@onready var circle1 = get_node("circle1")

@export var character = "doryfish"
@export var left = "p1_left"
@export var right = "p1_right"
@export var xcenter = 475

@onready var lowestcircle = $circle1
var lowestcirclenum = 1
var circnum = 1

var score = 0
var crashes = 0

var prev_spawned = 0

var circlelist = ["circle1","circle2","circle3","circle4","circle5"]
var incircle = ["circle1"]

func _ready() -> void:
	#p1.went_left.connect(p1_went_left)
	#p1.went_right.connect(p1_went_right)
	for i in circlelist:
		var ciri = get_node(i)
		ciri.on_ground.connect(check_for_cross)
		ciri.under_ground.connect(underground)

		ciri.floor_left.connect(floor_left)
		ciri.floor_right.connect(floor_right)
		if(i != "circle1"):
			ciri.in_play = false
	p1.play_become(character)
	#circlelist.append("circle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed(left)):
		if(!p1.restricted_movement):
			p1.animated_sprite.flip_h = false 
			p1.position.x = xcenter - 50
			p1_went_left()
	if(Input.is_action_just_pressed(right)):
		if(!p1.restricted_movement):
			p1.animated_sprite.flip_h = true 
			p1.position.x = xcenter + 50
			p1_went_right()
			
func crashed(whichcircle):
	p1.crashed()
	whichcircle.crashed()
	crashes += 1
	
func p1_went_left():
	score += 1
	p1.side = -1
	for i in incircle:
		get_node(i).chopped()
	#circle.chopped()
	spawn_circle()
	#$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes) + "\nside " + str(p1.side) + "\nheight " + str(circle.height)
	$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes)

func p1_went_right():
	score += 1
	p1.side = 1
	for i in incircle:
		get_node(i).chopped()
	spawn_circle()
	#$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes) + "\nside " + str(p1.side) + "\nheight" + str(circle.height)
	$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes)

func floor_left():
	#print("was on left")
	if(p1.side == -1):
		#print("player is on left")
		crashed(lowestcircle)
		
func floor_right():
	#print("was on right")
	if(p1.side == 1):
		#print("player is on right")
		crashed(lowestcircle)
	
func check_for_cross():
	if(p1.side == lowestcircle.height):
		# boom
		crashed(lowestcircle)
		
func spawn_circle():
	print(incircle)
	print("lowest circle " + str(lowestcircle))
	var choice = 0
	if (prev_spawned == 0):
		choice = [5,-5,0].pick_random() 
	elif(prev_spawned == -5):
		choice = [-5,0].pick_random()
	elif(prev_spawned == 5):
		choice = [5,0].pick_random()
	prev_spawned = choice
	print("previously spawned: " + str(prev_spawned))
	#print(prev_spawned)
	if(choice != 0):
		print("spawning something")
		var next_circle = get_node("circle" + str(circnum+1))
		next_circle.in_play = true
		next_circle.at_top(choice)
		incircle.append("circle" + str(circnum+1))
		circnum = (circnum + 1)%5
		#another_circle = circle.duplicate()
		#add_child(another_circle)
		#another_circle.at_top(choice)
		#circlelist.append("another_circle")
		#print(circlelist)
	else:
		print("spawns blank space")
		
func underground():
	lowestcircle.in_play = false
	lowestcircle = get_node("circle" + str(lowestcirclenum + 1))
	lowestcirclenum = (lowestcirclenum + 1)%5

	incircle.remove_at(0)
