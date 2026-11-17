extends CharacterBody2D

var height = 10 # spawns on either left or right side, negative = left, pos = right
# calculation is abs -1
# if height value is same as player's (player is always at -1 or 1) then player crashed

func _physics_process(delta: float) -> void:
	pass
