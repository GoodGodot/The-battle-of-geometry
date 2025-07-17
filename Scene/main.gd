extends Node2D 

func _ready() -> void:
	var crosshair := ResourceLoader.load("res://pictures/crosshair.png")
	Input.set_custom_mouse_cursor(crosshair,Input.CURSOR_ARROW,Vector2(20,20.0))
	$game_over.visible=false
	$wave.text = "波次：" + str(EventBus.enermy_wave)
	
	$back.pressed.connect(_on_back_pressed)
	
	
func set_score(new_score:int):
	$boss_come/AnimationPlayer.play("score")
	$boss_come.visible = false
	$enermy_die.play()
	$score.text = "Score: "+str(EventBus.player_score)
func _on_back_pressed():
	$Player.game_over()
	SceneChanger.change_sence("res://Scene/Start.tscn")
