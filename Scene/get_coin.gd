extends Control

@onready var question: Label = $question
@onready var answer: LineEdit = $answer

var a;var b
var true_ans:int
var get_coin := 0
var op_size := 1
var op := 1

func _ready() -> void:
	$check.pressed.connect(_on_check_pressed)
	$back.pressed.connect(_on_back_pressed)
	$"加".pressed.connect(_on_jia_pressed)
	$"减".pressed.connect(_on_jian_pressed)
	$"乘".pressed.connect(_on_cheng_pressed)
	$"除".pressed.connect(_on_chu_pressed)
	$less_coin.visible = false
	true_ans = set_question()
	
func set_question() -> int:
	randomize()
	var ans :int = 0
	a = randi_range(1,100)
	b = randi_range(1,100)
	if op==1:#加
		question.text = str(a) + '+' + str(b) + "= "
		ans = a+b
	if op==2 :#减
		if a < b:
			var t = b
			b=a
			a=t
		question.text = str(a) + '-' + str(b) + "= "
		ans = a-b
	if op==3:
		a = randi_range(1,10)
		b = randi_range(1,10)
		question.text = str(a) + '×' + str(b) + "= "
		ans = a*b
	if op == 4:
		b = randi_range(1,10)
		a= randi_range(1,15) * b
		question.text = str(a) + '÷' + str(b) + "= "
		ans = a / b
		
	return ans
	
func _on_check_pressed():
	var player_ans := int(answer.text)
	if player_ans == true_ans:
		get_coin += 10
		true_ans = set_question()
	else:
		get_coin -= 10
	$answer.text = ""
	$get_coin_value.text = "获得金币数： " + str(get_coin)

func _on_back_pressed():
	EventBus.save_value(EventBus.load_coin()+get_coin,"coin")
	SceneChanger.change_sence("res://Scene/Start.tscn")

func _on_jia_pressed():
	if $"加".button_pressed:
		op=1
		op_size += 1
		true_ans = set_question()
		close_other_button("加")
	else:
		if op_size != 1:
			op_size -= 1
		else:
			$"加".button_pressed = true
func _on_jian_pressed():
	if $"减".button_pressed:
		op=2
		op_size += 1
		true_ans = set_question()
		close_other_button("减")
	else:
		if op_size != 1:
			op_size -= 1
		else:
			$"减".button_pressed = true
func _on_cheng_pressed():
	if $"乘".button_pressed:
		op=3
		op_size += 1
		true_ans = set_question()
		close_other_button("乘")
	else:
		if op_size != 1:
			op_size -= 1
		else:
			$"乘".button_pressed = true
func _on_chu_pressed():
	if $"除".button_pressed:
		op=4
		op_size += 1
		true_ans = set_question()
		close_other_button("除")
	else:
		if op_size != 1:
			op_size -= 1
		else:
			$"除".button_pressed = true
func close_other_button(name:String):
	var group = get_tree().get_nodes_in_group("op")
	for node in group:
		if node.name != name && node.button_pressed:
			node.button_pressed = false
			op_size -= 1
