extends Panel

func _ready() -> void:
	$back.pressed.connect(_on_back_pressed)


func _on_back_pressed():
	visible = false
	SceneChanger.change_sence("res://Scene/Start.tscn")
	
	
