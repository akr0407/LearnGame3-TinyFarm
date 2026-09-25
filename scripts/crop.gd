extends Node2D

var growth_stage = 1
var growth_timer = 0.0
var is_watered = false
var farm_plot

@export var stage_1_texture: AtlasTexture
@export var stage_2_texture: AtlasTexture
@export var stage_3_texture: AtlasTexture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_crop_visual()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	growth_timer += delta
	
	if growth_timer >= 5.0:
		growth_timer = 0.0
		
		if is_watered:
			grow_crop()

func grow_crop() -> void:
	if growth_stage < 3:
		growth_stage += 1
		is_watered = false
		$WaterIndicator.visible = false
		print("Growth stage: ", growth_stage)
		update_crop_visual()
		
func update_crop_visual() -> void:
	if growth_stage == 1:
		$Sprite2D.texture = stage_1_texture
	elif growth_stage == 2:
		$Sprite2D.texture = stage_2_texture
	elif growth_stage == 3:
		$Sprite2D.texture = stage_3_texture


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if growth_stage == 3:
				harvest()
			else: 
				var player = get_tree().get_first_node_in_group("player")
				
				if player.selected_tool == "watering_can":
					water_crop()

func harvest() -> void:
	print("Crop harvested")
	
	var main = get_tree().current_scene
	main.add_crop()
	
	farm_plot.is_planted = false
	
	queue_free()

func water_crop() -> void:
	if is_watered:
		return
	
	is_watered = true
	$WaterIndicator.visible = true
	print("Crop watered")
