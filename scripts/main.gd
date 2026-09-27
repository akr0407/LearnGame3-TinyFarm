extends Node2D

var crop_count = 0
var day = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_crop() -> void:
	crop_count += 1
	$UI/CropLabel.text = "Crops: " + str(crop_count) 


func _on_next_day_button_pressed() -> void:
	day += 1
	$UI/DayLabel.text = "Day: " + str(day)
	
	var crops = get_tree().get_nodes_in_group("crops")
	
	for crop in crops:
		crop.next_day()
