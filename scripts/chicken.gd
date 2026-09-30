extends Area2D

@export var move_speed = 20.0

var target_position = Vector2.ZERO
var moving = false
var wait_timer = 0.0
var was_clicked = false
var can_give_egg = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	choose_new_target()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().current_scene.game_completed:
		moving = false
		$AnimatedSprite2D.play("idle")
		return
		
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
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_give_egg:
			print("Chicken clicked")
			$ReactionLabel.visible = true
			$ReactionTimer.start()
			
			var main = get_tree().current_scene
			main.eggs += 1
			main.update_egg_label()
			
			can_give_egg = false
			$EggTimer.start()
			
			moving = false
			wait_timer = 2.0
			$AnimatedSprite2D.play("idle")


func _on_egg_timer_timeout() -> void:
	can_give_egg = true


func _on_reaction_timer_timeout() -> void:
	$ReactionLabel.visible = false
