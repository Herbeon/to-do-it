extends CharacterBody2D

@export var xcenter = 475
var height = 5 # spawns on either left or right side, negative = left, pos = right
# calculation is abs -1
# if height value is same as player's (player is always at -1 or 1) then player crashed
# or just more if statements

# instead of doing fancier number things might be better to just look at sides...
var left = true # true = left, false = right
var in_play = true

signal on_ground
signal under_ground
signal floor_left
signal floor_right

func _ready() -> void:
	at_top(5)

func _physics_process(delta: float) -> void:
	if(!in_play):
		position.x = 0
		position.y = 0
		visible = false
	else:
		visible = true
func at_top(picked_thing : int):
	if(in_play):
		if(picked_thing == 0):
			return
		position.y = 0
		height = picked_thing
		position.y = 180
		left = height < 0
		if(height > 0):
			position.x = xcenter + 50
		elif(height < 0):
			position.x = xcenter - 50
		
func chopped():
	if(in_play):
		if(abs(height) == 1):
			on_ground.emit()
		if(height == 0):
			if(left):
				floor_left.emit()
			else:
				floor_right.emit()
			under_ground.emit()
			#at_top([5,-5].pick_random())
		elif(height > 0):
			height -= 1
		else:
			height += 1
		position.y = 440 - abs(height) * 60

func crashed():
	$AnimatedSprite2D.material.set_shader_parameter("flash",1.0)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("flash",0.0)
	#at_top([5,-5].pick_random())
	in_play = false
	
