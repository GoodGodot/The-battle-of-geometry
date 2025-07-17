extends Area2D

var damage := 15 #对敌人的伤害

var dir := Vector2.DOWN
var speed := 500.0

func _ready() -> void:
	$shoot.play()

func _process(delta: float) -> void:
	global_position += delta * dir * speed

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enermys"):
		body.blood -=damage
		body.lose_blood(100/body.normal_blood*damage)
		EventBus.screen_shake(3.0,0.35)
		body.position -= body.direction * 15.0
		queue_free()
		if body.blood <= 0:
			if body.name == "Enermy2":
				body.self_boom()
			else:
				body.boom()
			EventBus.player_score += body.score
			get_node("/root/Game").set_score(EventBus.player_score)
			


func _on_free_screen_exited() -> void:
	queue_free()
