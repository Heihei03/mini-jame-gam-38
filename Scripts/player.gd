extends CharacterBody2D

@export var speed : float = 300.0

var direction : float = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	direction = Input.get_axis("left", "right")
	velocity.x = direction * speed
	
	move_and_slide()
	pass
