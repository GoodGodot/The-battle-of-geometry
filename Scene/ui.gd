extends Control

@onready var animation_player: AnimationPlayer = $PopUP/AnimationPlayer
var mouse_pic :Resource = ResourceLoader.load("res://pictures/mouse2.png")

func _ready() -> void:
	get_tree().paused = false
	$buy/background.visible = false
	$start_game.pressed.connect(on_start_game)
	$exit_game.pressed.connect(on_exit_game)
	$get_con.pressed.connect(on_get_coin)
	$buy.pressed.connect(on_buy)
	$coin.text = "金币：" + str(EventBus.load_coin())
	Input.set_custom_mouse_cursor(mouse_pic,Input.CURSOR_ARROW,Vector2(1.0,1.0))
	
func on_start_game():
	$start_game2.play()
	SceneChanger.change_sence("res://Scene/main.tscn")

func on_exit_game():
	$PopUP.visible=true
	animation_player.play("pop")
	await animation_player.animation_finished

func on_buy():
	$buy/background.visible = true

func on_get_coin():
	SceneChanger.change_sence("res://Scene/get_coin.tscn")


func _on_about_pressed() -> void:
	SceneChanger.change_sence("res://Scene/about.tscn")
