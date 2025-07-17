extends Control

func _ready() -> void:
	$die_all/num.text = str(EventBus.way_1_num)
	$sky/num.text = str(EventBus.way_2_num)

func _on_die_all_pressed() -> void:
	if EventBus.way_1_num > 0:
		EventBus.way_1_num -= 1
		EventBus.save_value(EventBus.way_1_num,"way_1")
		$die_all/num.text = str(EventBus.way_1_num)
		
		$die_all/boom.play()
		
		var group = get_tree().get_nodes_in_group("Enermys")
		EventBus.can_shoot = false
		for node in group:
			node.queue_free()
		$die_all/CanvasLayer/ColorRect.visible = true
		await  get_tree().create_timer(1.5).timeout
		$die_all/CanvasLayer/ColorRect.visible = false
		EventBus.can_shoot = true


func _on_sky_pressed() -> void:
	if EventBus.way_2_num > 0:
		var bullet_dir := Vector2.DOWN
		var bullet := preload("res://Scene/bullet_2.tscn")
		
		EventBus.way_2_num -= 1
		EventBus.save_value(EventBus.way_2_num,"way_2")
		$sky/num.text = str(EventBus.way_2_num)
		
		for i in range(1,36*3+1):
			var ts = bullet.instantiate()
			ts.rotation = i * 10
			ts.position = get_node("/root/Game/Player").position
			ts.dir = Vector2.from_angle(ts.rotation)
			add_child(ts)
			await get_tree().create_timer(0.01).timeout
