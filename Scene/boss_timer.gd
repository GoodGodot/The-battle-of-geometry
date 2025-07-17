extends Timer

@onready var animation_player: AnimationPlayer = $"../boss_come/AnimationPlayer"


func _ready() -> void:
	start()
	$"../Boss_up".start()
	$"../boss_come".visible = false
	
	
func _on_timeout() -> void:
	var enermy  = preload("res://Scene/boss.tscn")
	var tscn = enermy.instantiate()
	animation_player.play("coming")
	await animation_player.animation_finished
	add_child(tscn)


func _on_boss_up_timeout() -> void:
	EventBus.boss_blood += 50
	EventBus.boss_damage += 5
	EventBus.boss_score += 500
	EventBus.boss_speed += 75.0
	
