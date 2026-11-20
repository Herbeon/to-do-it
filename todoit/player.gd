extends CharacterBody2D

@export var character = "doryfish"
@export var left = "p1_left"
@export var right = "p1_right"
@export var xcenter = 475

var side = -1
# negative = left

var restricted_movement = false 
signal went_left
signal went_right

func _ready() -> void:
	$AnimatedSprite2D.play(character)

func _physics_process(delta: float) -> void:
	if(Input.is_action_just_pressed(left)):
		if(!restricted_movement):
			$AnimatedSprite2D.flip_h = false 
			position.x = xcenter - 50
			went_left.emit()
	if(Input.is_action_just_pressed(right)):
		if(!restricted_movement):
			$AnimatedSprite2D.flip_h = true 
			position.x = xcenter + 50
			went_right.emit()
		
func crashed():
	$AnimatedSprite2D.material.set_shader_parameter("flash",1.0)
	restricted_movement = true
	await get_tree().create_timer(1).timeout
	restricted_movement = false
	$AnimatedSprite2D.material.set_shader_parameter("flash",0.0)
