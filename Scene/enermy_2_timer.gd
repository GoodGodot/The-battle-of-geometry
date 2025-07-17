extends Timer

func _ready() -> void:
	start()

func _on_timeout() -> void:
	var enermy  = preload("res://Scene/enermy_2.tscn")
	var tscn = enermy.instantiate()
	add_child(tscn)
