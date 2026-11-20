extends CharacterBody2D

@export var xcenter = 475
var height = 5 # spawns on either left or right side, negative = left, pos = right
# calculation is abs -1
# if height value is same as player's (player is always at -1 or 1) then player crashed
# or just more if statements

# instead of doing fancier number things might be better to just look at sides...
var left = true # true = left, false = right
signal on_ground
signal floor_left
signal floor_right

func _ready() -> void:
	at_top()

func _physics_process(delta: float) -> void:
	pass

func at_top():
	position.y = 0
	height = [5,-5].pick_random()
	position.y = 180
	left = height < 0
	if(height > 0):
		position.x = xcenter + 50
	elif(height < 0):
		position.x = xcenter - 50
		
func chopped():
	if(abs(height) == 1):
		on_ground.emit()
	if(height == 0):
		if(left):
			floor_left.emit()
		else:
			floor_right.emit()
		at_top()
	elif(height > 0):
		height -= 1
	else:
		height += 1
	position.y = 440 - abs(height) * 60

func crashed():
	$AnimatedSprite2D.material.set_shader_parameter("flash",1.0)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.material.set_shader_parameter("flash",0.0)
