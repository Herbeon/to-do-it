extends Node2D


# Called when the node enters the scene tree for the first time.

@export var playernode = "player1"

@onready var p1 = get_node(playernode)
@onready var circle = get_node("circle")
@export var character = "doryfish"
@export var left = "p1_left"
@export var right = "p1_right"
@export var xcenter = 475

var circle2
var another_circle

var score = 0
var crashes = 0

var prev_spawned = 0

var circlelist = []

func _ready() -> void:
	#p1.went_left.connect(p1_went_left)
	#p1.went_right.connect(p1_went_right)
	circle.on_ground.connect(check_for_cross)
	circle.floor_left.connect(floor_left)
	circle.floor_right.connect(floor_right)
	p1.play_become(character)
	circlelist.append("circle")

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
func crashed():
	p1.crashed()
	circle.crashed()
	crashes += 1
	
func p1_went_left():
	score += 1
	p1.side = -1
	for i in circlelist:
		get_node(i).chopped()
	#circle.chopped()
	#spawn_circle()
	#$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes) + "\nside " + str(p1.side) + "\nheight " + str(circle.height)
	$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes)

func p1_went_right():
	score += 1
	p1.side = 1
	for i in circlelist:
		get_node(i).chopped()
	#spawn_circle()
	#$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes) + "\nside " + str(p1.side) + "\nheight" + str(circle.height)
	$Control/Label.text = "score = " + str(score) + "\ncrashes = " + str(crashes)

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
	var choice = 0
	if (prev_spawned == 0):
		choice = [5,-5,0].pick_random() 
	elif(prev_spawned == -5):
		choice = [-5,0].pick_random()
	elif(prev_spawned == 5):
		choice = [5,0].pick_random()
	prev_spawned = choice
	if(choice != 0):
		another_circle = circle.duplicate()
		#add_child(another_circle)
		#another_circle.at_top(choice)
		#circlelist.append("another_circle")
		#print(circlelist)
		
