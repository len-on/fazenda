extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var start_timer: Timer = $StartTimer
@onready var timer_2: Timer = $Timer2
@onready var area_2d: Area2D = $Area2D

var start_position: Vector2
var is_plant = false
var player_inside = false
var is_planted = false

func _ready() -> void:
	start_position = global_position
	anim.visible = false


func _process(_delta: float) -> void:
	if player_inside == true and is_plant == false:
		if Input.is_action_just_pressed("ui_farming"):
			plant()
			return
	elif player_inside == true and is_plant == true:
		if Input.is_action_just_pressed("ui_irrigating"):
			planted()
	


func plant():
	if is_plant:
		return

	is_plant = true
	anim.visible = true
	anim.play("planted")

func planted():
	if is_planted:
		return
	
	is_planted = false
	anim.play("grow")
	

func _on_start_timer_timeout() -> void:
	pass # Replace with function body.


func _on_regen_timer_timeout() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside = false
