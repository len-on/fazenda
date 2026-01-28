extends CharacterBody2D

enum PlayerState {
	idle_down,
	idle_up,
	idle_side,
	walk_down,
	walk_up,
	walk_side,
	farming_down,
	farming_up,
	farming_side,
	irrigating_down,
	irrigating_up,
	irrigating_side
}

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_left: RayCast2D = $RayLeft
@onready var ray_right: RayCast2D = $RayRight
@onready var ray_down: RayCast2D = $RayDown
@onready var ray_up: RayCast2D = $RayUp

@export var max_speed = 80.0
@export var acceleration = 400
@export var deceleration = 400

const SPEED = 80.0
const JUMP_VELOCITY = -400.0

var status: PlayerState
var direction_x = 0
var direction_y = 0

func _ready() -> void:
	go_to_idle_down_state()


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
		PlayerState.farming_down:
			farming_down_state(delta)
		PlayerState.farming_up:
			farming_up_state(delta)
		PlayerState.farming_side:
			farming_side_state(delta)
		PlayerState.irrigating_down:
			irrigating_down_state(delta)
		PlayerState.irrigating_up:
			irrigating_up_state(delta)
		PlayerState.irrigating_side:
			irrigating_side_state(delta)
	
	
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
	
func go_to_farming_down_state():
	status = PlayerState.farming_down
	anim.play("farming_down")

func go_to_farming_up_state():
	status = PlayerState.farming_up
	anim.play("farming_up")

func go_to_farming_side_state():
	status = PlayerState.farming_side
	anim.play("farming_side")
	
func go_to_irrigating_down_state():
	status = PlayerState.irrigating_down
	anim.play("irrigating_down")

func go_to_irrigating_up_state():
	status = PlayerState.irrigating_up
	anim.play("irrigating_up")
	
func go_to_irrigating_side_state():
	status = PlayerState.irrigating_side
	anim.play("irrigating_side")

func idle_down_state(delta):
	move_y(delta)
	direction_press(delta)
	if Input.is_action_pressed("ui_farming"):
		go_to_farming_down_state()
		return
	elif Input.is_action_pressed("ui_irrigating"):
		go_to_irrigating_down_state()
		return
	
func idle_up_state(delta):
	move_y(delta)
	direction_press(delta)
	if Input.is_action_pressed("ui_farming"):
		go_to_farming_up_state()
		return
	elif Input.is_action_pressed("ui_irrigating"):
		go_to_irrigating_up_state()
		return
	
func idle_side_state(delta):
	move_x(delta)
	direction_press(delta)
	if Input.is_action_just_pressed("ui_farming"):
		go_to_farming_side_state()
		return
	elif Input.is_action_pressed("ui_irrigating"):
		go_to_irrigating_side_state()
		return
	
	
	
func walk_down_state(delta):
	move_y(delta)
	if Input.is_action_just_released("ui_down"):
		go_to_idle_down_state()
		return
		
func walk_up_state(delta):
	move_y(delta)
	if Input.is_action_just_released("ui_up"):
		go_to_idle_up_state()
		return
		
func walk_side_state(delta):
	move_x(delta)
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		go_to_idle_side_state()
		return
		
func farming_down_state(_delta):
	if Input.is_action_just_released("ui_farming"):
		go_to_idle_down_state()
		return

func farming_up_state(_delta):
	if Input.is_action_just_released("ui_farming"):
		go_to_idle_up_state()
		return

func farming_side_state(_delta):
	if Input.is_action_just_released("ui_farming"):
		go_to_idle_side_state()
		return

func irrigating_down_state(_delta):
	if Input.is_action_just_released("ui_irrigating"):
		go_to_idle_down_state()
		return

func irrigating_up_state(_delta):
	if Input.is_action_just_released("ui_irrigating"):
		go_to_idle_up_state()
		return
	
func irrigating_side_state(_delta):
	if Input.is_action_just_released("ui_irrigating"):
		go_to_idle_side_state()
		return
	
func update_direction():
	direction_x = Input.get_axis("ui_left", "ui_right")
	
	if direction_x < 0:
		anim.flip_h = true
	elif  direction_x > 0:
		anim.flip_h = false
		

func move_x(delta):
	update_direction()
	velocity.y = move_toward(velocity.y, 0, deceleration * delta)
	if direction_x != 0:
		velocity.x = move_toward(velocity.x, direction_x * max_speed, acceleration * delta)
		
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	return

func move_y(delta):
	direction_y = Input.get_axis("ui_up", "ui_down")
	velocity.x = move_toward(velocity.x, 0, deceleration * delta)
	if direction_y != 0:
		velocity.y = move_toward(velocity.y, direction_y * max_speed, acceleration * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, deceleration * delta)
	return
	
func direction_press(_delta):
	if Input.is_action_pressed("ui_down"):
		go_to_walk_down_state()
		return
	elif Input.is_action_pressed("ui_up"):
		go_to_walk_up_state()
		return
	elif Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		go_to_walk_side_state()
		return
