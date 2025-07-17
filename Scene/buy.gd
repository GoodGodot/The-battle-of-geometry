extends Panel

var up_spend 
var way_spend := 150
var new_coin:int

func _ready() -> void:
	$damage_up.pressed.connect(_on_damage_up)
	$blood_up.pressed.connect(_on_blood_up)
	$close.pressed.connect(_on_close_buy)
	$buy_way_1.pressed.connect(_on_way1_buy)
	$buy_way_2.pressed.connect(_on_way2_buy)
	
	$damage_up/damage.text = "当前攻击力：" + str(EventBus.player_damage)
	$"blood_up/blood".text = "当前血量：" + str(EventBus.player_blood)
	$buy_way_1/num.text = "道具数量： " + str(EventBus.way_1_num)
	$buy_way_2/num.text = "道具数量： " + str(EventBus.way_2_num)
	
	$"can't_buy".visible = false
	
	
	up_spend = EventBus.load_value("user://up_spend.cfg","up_spend")
	$spend.text = "注：每次花费" + str(up_spend) + "金币"
	
func _on_damage_up():
	buy_sth("damage")

func _on_blood_up():
	buy_sth("blood")

func _on_way1_buy():
	buy_sth("way_1")

func _on_way2_buy():
	buy_sth("way_2")

func _on_close_buy():
	visible = false
	$"../../shopClose".play()


func buy_sth(sth:String):
	$"../../buy2".play()
	#if EventBus.load_coin() >= up_spend:
	if sth == "blood" || sth == "damage":
		if EventBus.load_coin() >= up_spend:
			if sth == "blood":
				EventBus.player_blood += 1
				EventBus.save_value(EventBus.player_blood,"blood")
				$"blood_up/blood".text = "当前血量：" + str(EventBus.player_blood)
				new_coin = EventBus.load_coin()-up_spend
			elif sth == "damage":
				EventBus.player_damage += 1
				EventBus.save_value(EventBus.player_damage,"damage")
				$"damage_up/damage".text = "当前攻击力：" + str(EventBus.player_damage)
				new_coin = EventBus.load_coin()-up_spend
			up_spend += 25
			EventBus.save_value(up_spend,"up_spend")
			$spend.text = "注：每次花费" + str(up_spend) + "金币"
			
		else:
			$"can't_buy".visible = true
			await get_tree().create_timer(2.0).timeout
			$"can't_buy".visible = false
	if sth == "way_1" || sth == "way_2":
		if EventBus.load_coin() >= way_spend:
			if sth == "way_1":
				EventBus.way_1_num +=1
				EventBus.save_value(EventBus.way_1_num,"way_1")
				$buy_way_1/num.text = "道具数量：" + str(EventBus.way_1_num)
				new_coin = EventBus.load_coin()-way_spend
			elif sth == "way_2":
				EventBus.way_2_num +=1
				EventBus.save_value(EventBus.way_2_num,"way_2")
				$buy_way_2/num.text = "道具数量：" + str(EventBus.way_2_num)
				new_coin = EventBus.load_coin()-way_spend
		else:
			$"can't_buy".visible = true
			await get_tree().create_timer(2.0).timeout
			$"can't_buy".visible = false
	
	EventBus.save_coin(new_coin)
	$"../../coin".text = "金币：" + str(new_coin)
	

		
