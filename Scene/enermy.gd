extends CharacterBody2D
class_name Enermy


@onready var blood_process: ProgressBar = $blood_process


@export var speed := 100.0 
@export var blood := EventBus.enermy_blood#自身血量
@export var damage := EventBus.enermy_damage #攻击玩家伤害

var normal_blood#自身默认血量，不可更改，便于计算一击减少多少血
var score := 100 #击败得分
var direction

func _ready() -> void:
	randomize()
	normal_blood = blood
	position = Vector2i(randi_range(-200,1892),randi_range(-200,948))

func _physics_process(delta: float) -> void:
	var player = get_node("/root/Game/Player")
	var target_rotation = (player.position - global_position).angle()
	rotation = lerp_angle(rotation,target_rotation,15.0*delta)
	direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func lose_blood(size:int) -> void:
	blood_process.value -= size

func boom():
	queue_free()
