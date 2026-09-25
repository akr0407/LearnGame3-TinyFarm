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
		
	if crop_scene:
			var crop = crop_scene.instantiate()
			add_child(crop)
			is_planted = true
			print("Planting corp!")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		plant_corp()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		print("player enter farm area")
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		print("player exited farm area")
