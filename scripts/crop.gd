extends Node2D

var growth_stage = 1
var growth_timer = 0.0

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
		grow_crop()

func grow_crop() -> void:
	if growth_stage < 3:
		growth_stage += 1
		print("Growth stage: ", growth_stage)
		update_crop_visual()
		
func update_crop_visual() -> void:
	if growth_stage == 1:
		$Sprite2D.texture = stage_1_texture
	elif growth_stage == 2:
		$Sprite2D.texture = stage_2_texture
	elif growth_stage == 3:
		$Sprite2D.texture = stage_3_texture
