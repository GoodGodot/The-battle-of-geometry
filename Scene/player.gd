extends Area2D

@onready var blood_process: ProgressBar = $blood_process

@export var speed := 250.0
@export var normal_blood := EventBus.player_blood #玩家默认血量
var blood = EventBus.player_blood


var mouse_pic:Resource = ResourceLoader.load("res://pictures/crosshair.png")
var mouse_pic2:Resource = ResourceLoader.load("res://pictures/crosshair2.png")
var is_mouse2:bool = false

func _ready() -> void:
	blood = normal_blood

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left") && EventBus.can_shoot:
		Input.set_custom_mouse_cursor(mouse_pic2,Input.CURSOR_ARROW,Vector2(20.0,20.0))
		var bullet2 := preload("res://Scene/bullet_3.tscn")
		var ts = bullet2.instantiate()
		ts.position = position 
		get_parent().get_parent().add_child(ts)
		
	else:
		Input.set_custom_mouse_cursor(mouse_pic,Input.CURSOR_ARROW,Vector2(20.0,20.0))
	
	
func _physics_process(delta: float) -> void:
	move(delta)
	#var target_rotation = (get_global_mouse_position()-global_position).angle()
	#rotation = lerp_angle(rotation,target_rotation,15.0*delta)
	look_at(get_global_mouse_position())

func move(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		position+=Vector2.LEFT * speed *delta
	if Input.is_action_pressed("move_right"):
		position+=Vector2.RIGHT * speed *delta
	if Input.is_action_pressed("move_up"):
		position+=Vector2.UP * speed *delta
	if Input.is_action_pressed("move_down"):
		position+=Vector2.DOWN * speed *delta
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enermys"):
		EventBus.screen_shake(5.0,0.3)
		blood -= body.damage
		if(blood<=0):
			$"../game_over".visible = true
			blood_process.value = 0
			game_over()
		body.position -= body.direction * 30.0
		var 减血 = (100 / normal_blood) * body.damage
		if 减血==0:
			减血 = 1
		blood_process.value -= 减血
		
		
		$AnimationPlayer.play("hurt")


func game_over():
	get_tree().paused = true
	$game_over.play()
	randomize()
	var 金币率 = 0.02
	var coin = EventBus.player_score*金币率
	$"../game_over/background/coin".text = "所获金币为："+str(coin)
	EventBus.save_coin(EventBus.load_coin() + coin)
	#动态游戏结束后得分
	$"../game_over/background/Label".text = "Score: "+str(EventBus.player_score)
	EventBus.player_score = 0
	
