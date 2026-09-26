extends CharacterBody2D

const SPEED = 100.0

var facing_direction = "down"
var selected_tool = "watering_can"
var is_watering = false

@onready var tool_sprite = $ToolSprite


func _ready() -> void:
	update_tool_visual()

func use_watering_can() -> void:
	if is_watering:
		return
	
	is_watering = true
	
	#tool_sprite.stop()
	#tool_sprite.frame = 0
	tool_sprite.play("water")
	print("Watering animation played")
	
	await tool_sprite.animation_finished
	
	is_watering = false
	
func update_tool_visual() -> void:
	if selected_tool == "watering_can":
		tool_sprite.visible = true
	else:
		tool_sprite.visible = false

func face_target(target_position: Vector2) -> void:
	if target_position.x > global_position.x:
		facing_direction = "right"
		$AnimatedSprite2D.flip_h = false
		tool_sprite.flip_h = false
		tool_sprite.position.x = abs(tool_sprite.position.x)
	else: 
		facing_direction = "right"
		$AnimatedSprite2D.flip_h = true
		tool_sprite.flip_h = true
		tool_sprite.position.x = -abs(tool_sprite.position.x)


func _physics_process(_delta: float) -> void:
	if is_watering:
		velocity = Vector2.ZERO
		return
	
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				facing_direction = "right"
				$AnimatedSprite2D.flip_h = false
				tool_sprite.flip_h = false
				tool_sprite.position.x = abs(tool_sprite.position.x)

			elif direction.x < 0:
				facing_direction = "left"
				$AnimatedSprite2D.flip_h = true
				tool_sprite.flip_h = true
				tool_sprite.position.x = -abs(tool_sprite.position.x)

		else:
			if direction.y > 0:
				facing_direction = "down"
			else:
				facing_direction = "up"

		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

	velocity = direction * SPEED
	move_and_slide()
