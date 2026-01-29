extends StaticBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var start_timer: Timer = $StartTimer
@onready var restart_timer: Timer = $RestartTimer
@onready var area_2d: Area2D = $Area2D

var start_position: Vector2
var is_plant = false
var player_inside = false
var is_planted = false
var is_collected = false

func _ready() -> void:
	start_position = global_position
	anim.visible = false


func _process(_delta: float) -> void:
	if player_inside == true and is_plant == false:
		if Input.is_action_just_pressed("ui_farming"):
			plant()
			return
	elif player_inside == true and is_planted == false:
		if Input.is_action_just_pressed("ui_irrigating"):
			planted()
			return
	elif  player_inside == true and is_collected == false:
		if Input.is_action_just_pressed("ui_collect"):
			collected()
			
			return
	


func plant():
	if is_plant:
		return

	is_plant = true
	anim.visible = true
	anim.play("planted")

func planted():
	if is_planted:
		return
	
	is_planted = true
	anim.play("grow")
	
func collected():
	if is_collected:
		return
	
	is_collected = true
	anim.play("collected")
	restart_timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_inside = false


func _on_restart_timer_timeout() -> void:
	is_plant = false
	is_planted = false
	is_collected = false
	anim.visible = false
	global_position = start_position
	var fade_in_tween = create_tween()
	fade_in_tween.tween_property(anim, "modulate:a", 1, 0.5)
	
