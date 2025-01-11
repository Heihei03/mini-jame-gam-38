extends CharacterBody2D

@export var speed : float = 300.0
@export var jump_velocity : float = -400.0

var direction : float = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if velocity.x == 0:
		$Sprite.animation = "idle"
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	direction = Input.get_axis("left", "right")
	velocity.x = direction * speed
	
	if(Input.is_action_pressed("jump")&&is_on_floor()):
		velocity.y = jump_velocity
		
	if(Input.is_action_just_pressed("jump")&& not is_on_floor() && not has_double_jumped):
		velocity.y = jump_velocity
		has_double_jumped = false
		
	if is_on_floor():
		has_double_jumped = false
		
	if velocity.x != 0:
		$Sprite.animation = "walk"
		$Sprite.flip_h = velocity.x < 0
	$Sprite.play()
	
	move_and_slide()
