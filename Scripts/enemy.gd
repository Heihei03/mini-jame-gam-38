extends CharacterBody2D

@onready var _player = get_parent().get_node("Player")
@onready var timer = $Timer
@onready var turn_timer = $Timer2

const SPEED = 160.0

var hostile = false
var searching = 0
var direction = 1

#enemy states
func _hostile() :
	scale.x = 1
	$AnimatedSprite2D.flip_h = velocity.x < 0
	
	searching = 1
	if _player.global_position.x > global_position.x :
		direction = 1
	else :
		direction = -1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if hostile :
		_hostile()
	
	$AnimatedSprite2D.play("idle")

	velocity.x = SPEED * direction * searching
	move_and_slide()

# Sight functions
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body == _player :
		if _player.hat_id == 1 :
			timer.wait_time = 3
		else :
			timer.wait_time = 1
		timer.start()

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body == _player :
		timer.stop()

func _on_timer_2_timeout() -> void:
	if not hostile :
		direction *= -1
		scale.x *= -1


# Attack functions
func _on_timer_timeout() -> void:
	hostile = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == _player and hostile :
		body.death()
