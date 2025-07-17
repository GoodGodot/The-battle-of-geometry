extends "res://Scene/enermy.gd"

func _ready() -> void:
	randomize()
	position = Vector2i(randi_range(-400,2000),randi_range(-400,1148))
	blood = EventBus.boss_blood
	normal_blood = blood
	damage = EventBus.boss_damage
	speed = EventBus.boss_speed
	score = EventBus.boss_score
