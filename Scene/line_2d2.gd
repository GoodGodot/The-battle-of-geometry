extends Line2D

func _ready() -> void:
	visible = false
	await get_tree().create_timer(0.2).timeout
	visible = true
	
	await get_tree().create_timer(5).timeout
	queue_free()
