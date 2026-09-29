extends Area2D

@export var move_speed = 20.0

var target_position = Vector2.ZERO
var moving = false
var wait_timer = 0.0
var was_clicked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	choose_new_target()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if moving:
		$AnimatedSprite2D.play("walk")
		
		if target_position.x < global_position.x:
			$AnimatedSprite2D.flip_h = true
		else: 
			$AnimatedSprite2D.flip_h = false
		
		global_position = global_position.move_toward(target_position, move_speed * delta)
		
		if global_position.distance_to(target_position) < 2:
			moving = false
			wait_timer = randf_range(1.0, 3.0)
			$AnimatedSprite2D.play("idle")
	else:
		wait_timer -= delta
		
		if wait_timer <= 0:
			choose_new_target()
				
func choose_new_target() -> void:
	target_position = global_position + Vector2(
		randf_range(-50, 50),
		randf_range(-50, 50)
	)
	
	moving = true
	$AnimatedSprite2D.play("idle")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Chicken clicked")
			moving = false
			wait_timer = 2.0
			$AnimatedSprite2D.play("idle")
