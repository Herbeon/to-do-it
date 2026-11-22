extends CharacterBody2D


var side = -1
# negative = left

var restricted_movement = false 
#signal went_left
#signal went_right
@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func play_become(personne: String):
	animated_sprite.play(personne)
	
func crashed():
	animated_sprite.material.set_shader_parameter("flash",1.0)
	restricted_movement = true
	await get_tree().create_timer(1).timeout
	restricted_movement = false
	animated_sprite.material.set_shader_parameter("flash",0.0)
