extends Area2D

@export var crop_scene: PackedScene

var player_inside = false
var is_planted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func plant_corp() -> void:
	if is_planted:
		return
		
	var main = get_tree().current_scene
	
	if main.seeds <= 0:
		print("no seeds")
		return
		
	if crop_scene:
			var crop = crop_scene.instantiate()

			main.add_child(crop)

			crop.global_position = global_position
			crop.farm_plot = self
			
			main.seeds -= 1
			main.update_seed_label()
			
			is_planted = true
			print("Planting corp!")
	
func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if player_inside:
				plant_corp()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		print("player enter farm area")
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		print("player exited farm area")
