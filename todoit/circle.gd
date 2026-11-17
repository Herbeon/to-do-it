extends CharacterBody2D

var height = 5 # spawns on either left or right side, negative = left, pos = right
# calculation is abs -1
# if height value is same as player's (player is always at -1 or 1) then player crashed
# or just more if statements

signal on_ground

func _ready() -> void:
	position.y = 180

func _physics_process(delta: float) -> void:
	pass

func chopped():
	if(abs(height) == 1):
		on_ground.emit()
		
	if(height == 0):
		#despawn 
		position.y = 0
	elif(height > 0):
		height -= 1
	else:
		height += 1
	position.y = 440 - abs(height) * 60
