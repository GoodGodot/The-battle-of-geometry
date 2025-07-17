extends CanvasLayer

@onready var animation: AnimationPlayer = $Scene/animation


func _ready() -> void:
	visible=false

func change_sence(path:String):
	visible=true
	animation.play("loading")
	await animation.animation_finished
	get_tree().change_scene_to_file(path)
	visible=false
	EventBus.screen_shake(5,0.2)




	
