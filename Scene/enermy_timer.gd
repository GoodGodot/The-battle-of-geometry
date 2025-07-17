extends Timer

func _ready() -> void:
	start()
	$"../Enermy_up".start()

func _on_timeout() -> void:
	var enermy  = preload("res://Scene/enermy.tscn")
	var tscn = enermy.instantiate()
	add_child(tscn)


func _on_enermy_up_timeout() -> void:
	EventBus.enermy_blood += 3
	EventBus.enermy_damage += 2
	
	EventBus.enermy_wave += 1
	$"../wave".text = "波次：" + str(EventBus.enermy_wave)
	print("up")
