extends CharacterBody2D

@export var character = "doryfish"
@export var left = "p1_left"
@export var right = "p1_right"

var side = -1

signal went_left
signal went_right

func _ready() -> void:
	$AnimatedSprite2D.play(character)

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed(left)):
		$AnimatedSprite2D.flip_h = false 
		position.x -= 100
		side = -1
		went_left.emit()
	if(Input.is_action_just_pressed(right)):
		$AnimatedSprite2D.flip_h = true 
		position.x += 100
		side = 1
		went_right.emit()
