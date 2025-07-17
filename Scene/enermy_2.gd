extends "res://Scene/enermy.gd"

func _ready() -> void:
	randomize()
	position = Vector2i(randi_range(-400,2000),randi_range(-400,1148))
	blood = EventBus.enermy_blood + 2
	normal_blood = blood
	damage = EventBus.enermy_damage+ 3
	speed = 150.0
	score = 600

func self_boom():
	$AnimationPlayer.play("boom")
	await $AnimationPlayer.animation_finished
	queue_free()
