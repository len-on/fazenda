extends CharacterBody2D

enum PlayerState {
	idle_down,
	idle_up,
	idle_side,
	walk_down,
	walk_up,
	walk_side
}

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var status: PlayerState
var direction = 0


func _physics_process(delta: float) -> void:
	match status:
		PlayerState.idle_down:
			idle_down_state(delta)
		PlayerState.idle_up:
			idle_up_state(delta)
		PlayerState.idle_side:
			idle_side_state(delta)
		PlayerState.walk_down:
			walk_down_state(delta)
		PlayerState.walk_up:
			walk_up_state(delta)
		PlayerState.walk_side:
			walk_side_state(delta)

	
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	move_and_slide()

func go_to_idle_down_state():
	status = PlayerState.idle_down
	anim.play("idle_down")
func go_to_idle_up_state():
	status = PlayerState.idle_up
	anim.play("idle_up")
func go_to_idle_side_state():
	status = PlayerState.idle_side
	anim.play("idle_side")
func go_to_walk_down_state():
	status = PlayerState.walk_down
	anim.play("walk_down")
func go_to_walk_up_state():
	status = PlayerState.walk_up
	anim.play("walk_up")
func go_to_walk_side_state():
	status = PlayerState.walk_side
	anim.play("walk_side")
	
func idle_down_state(_delta):
		
	if Input.is_action_just_pressed("ui_down"):
		go_to_walk_down_state()
		return
	if Input.is_action_just_pressed("ui_up"):
		go_to_walk_up_state()
		return
	if Input.is_action_just_pressed("ui_right"):
		go_to_walk_side_state()
		return
	if Input.is_action_just_pressed("ui_left"):
		direction = -1
		go_to_walk_side_state()
		return
func idle_up_state(_delta):
	
	if Input.is_action_just_pressed("ui_down"):
		go_to_walk_down_state()
		return
	if Input.is_action_just_pressed("ui_up"):
		go_to_walk_up_state()
		return
	if Input.is_action_just_pressed("ui_right"):
		go_to_walk_side_state()
		return
	if Input.is_action_just_pressed("ui_left"):
		direction = -1
		go_to_walk_side_state()
		return
func idle_side_state(delta):
	move(delta)
	
	if Input.is_action_just_pressed("ui_down"):
		go_to_walk_down_state()
		return
	if Input.is_action_just_pressed("ui_up"):
		go_to_walk_up_state()
		return
	if Input.is_action_just_pressed("ui_right"):
		go_to_walk_side_state()
		return
	if Input.is_action_just_pressed("ui_left"):
		direction = -1
		go_to_walk_side_state()
		return
func walk_down_state(_delta):
	if Input.is_action_just_released("ui_down"):
		go_to_idle_down_state()
		return
func walk_up_state(_delta):
	if Input.is_action_just_released("ui_up"):
		go_to_idle_up_state()
		return
func walk_side_state(_delta):
	move(_delta)
	if Input.is_action_just_released("ui_right"):
		go_to_idle_side_state()
		return
	elif  Input.is_action_just_released("ui_left"):
		go_to_idle_side_state()
		return
	
func update_direction():
	direction = Input.get_axis("ui_left", "ui_right")
	
	if direction < 0:
		anim.flip_h = true
	elif  direction > 0:
		anim.flip_h = false
	
	#if direction_x:
		#velocity.x = direction_x * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)


func move(_delta):
	update_direction()
	
	
