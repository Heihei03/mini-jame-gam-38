extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	$AnimatedSprite2D.play("idle")

	move_and_slide()
