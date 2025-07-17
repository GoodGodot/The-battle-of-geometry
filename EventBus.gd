extends Node

var player_score := 0
var player_coin := 0
var player_damage := 1
var player_blood := 20

var enermy_damage := 1;
var enermy_blood := 3

var boss_damage := 5#伤害
var boss_blood := 50#血量
var boss_score := 5000;#击杀boss得分
var boss_speed := 150.0

var enermy_wave := 1 #敌人波次

var can_shoot := true

var way_1_num := 0#毁灭数量
var way_2_num := 0#天罚数量

func _ready() -> void:
	player_damage = load_damage()
	player_blood = load_blood()
	way_1_num = load_value("user://way_1.cfg","way_1")
	way_2_num = load_value("user://way_2.cfg","way_2")
	
func screen_shake(strength:float,duration:float):
	var camera = get_viewport().get_camera_2d()
	if not camera:
		print_debug("wrong!Don't have camera")
		return
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	tween.tween_method(
		func(s:float):
			get_viewport().get_camera_2d().offset = Vector2.from_angle(randf_range(0,TAU))*s,
		strength,
		0.0,
		duration
	)

func save_coin(coin:int):
	var sa = ConfigFile.new()
	sa.set_value("Game","coin",coin)
	sa.save("user://coin.cfg")

func load_coin() -> int:
	var lo = ConfigFile.new()
	lo.load("user://coin.cfg")
	if lo.get_value("Game","coin") == null:
		return 0
	else:
		return int(lo.get_value("Game","coin"))

func save_damage(damage:int):
	var sa = ConfigFile.new()
	sa.set_value("Game","damage",damage)
	sa.save("user://damage.cfg")

func load_damage() -> int:
	var lo = ConfigFile.new()
	lo.load("user://damage.cfg")
	if lo.get_value("Game","damage") == null:
		return 1
	else:
		return int(lo.get_value("Game","damage"))

func save_blood(blood:int):
	var sa = ConfigFile.new()
	sa.set_value("Game","blood",blood)
	sa.save("user://blood.cfg")

func load_blood() -> int:
	var lo = ConfigFile.new()
	lo.load("user://blood.cfg")
	if lo.get_value("Game","blood") == null:
		return 20
	else:
		return int(lo.get_value("Game","blood"))

#         数值       保存的物品类型名称
func save_value(value:int,things:String):
	var sa = ConfigFile.new()
	sa.set_value("Game",things,value)
	sa.save("user://"+things+".cfg")

#                加载路径       加载的物品类型名称
func load_value(path:String,things:String):
	var lo = ConfigFile.new()
	lo.load(path)
	if lo.get_value("Game",things) == null:
		if things == "coin":
			return 0
		elif things == "damage":
			return 1
		elif things == "blood":
			return 20
		elif things == "up_spend":
			return 100
		elif things == "way_1" || things == "way_2":
			return 0
	else:
		return int(lo.get_value("Game",things))
