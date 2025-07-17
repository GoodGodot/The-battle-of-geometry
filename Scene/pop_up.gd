extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	visible=false
	$yes.pressed.connect(on_yes_pressed)
	$no.pressed.connect(on_no_pressed)
	
func on_yes_pressed():
	get_tree().quit()

func on_no_pressed():
	animation_player.play_backwards("pop")
	await animation_player.animation_finished
	visible=false
