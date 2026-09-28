extends Node2D

var crop_count = 0
var day = 1
var money = 0
var seeds = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_crop() -> void:
	crop_count += 1
	$UI/CropLabel.text = "Crops: " + str(crop_count) 

func update_seed_label() -> void:
	$UI/SeedLabel.text = "Seeds: " + str(seeds)

func _on_next_day_button_pressed() -> void:
	var crops = get_tree().get_nodes_in_group("crops")
	
	for crop in crops:
		if not crop.is_watered:
			print("some crop is not watered")
			return
			
	day += 1
	$UI/DayLabel.text = "Day: " + str(day)
	
	$UI/DayMessageLabel.visible = true
	$UI/DayMessageTimer.start()
	
	for crop in crops:
		crop.next_day()


func _on_day_message_timer_timeout() -> void:
	$UI/DayMessageLabel.visible = false


func _on_sell_button_pressed() -> void:
	if crop_count <= 0:
		print("no crop to sell!")
		return
	
	print("Sold ", crop_count, " crops!")
	var earnings = crop_count * 10
	
	crop_count = 0
	$UI/CropLabel.text = "Crops: 0"
	
	money += earnings
	
	$UI/MoneyLabel.text = "Money: " + str(money)


func _on_buy_seed_button_pressed() -> void:
	if money < 5:
		print("no money for seed")
		return
	
	money -= 5
	seeds += 1
	
	$UI/MoneyLabel.text = "Money: " + str(money)
	update_seed_label()
	
	print("bought 1 seed")


func _on_shop_button_pressed() -> void:
	$UI/ShopPanel.visible = true


func _on_close_button_pressed() -> void:
	$UI/ShopPanel.visible = false
