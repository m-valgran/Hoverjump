extends Sprite2D

@onready var initial_y_pos = position.y
var jump_max_distance = 40
var jump_force = 5
var jump_distance = 0
var reached_top = false
var is_jumping = false
var movement_speed = 100
var is_dead = false
var score = 0
signal dead

func _ready():
	$AnimationPlayer.play("Moving")

func _process(delta):
	move(delta)
	jump(delta)

func move(delta):
	if !is_dead:
		position.x += movement_speed * delta
		score += 1

func jump(delta):
	if Input.is_action_just_pressed("ui_up") and !is_jumping and !is_dead:
		is_jumping = true
		reached_top = false
	if is_jumping == true:
		if !reached_top:
			jump_distance += 1
			position.y -= (jump_max_distance - jump_distance) * delta * jump_force
			if jump_distance == jump_max_distance:
				reached_top = true
		else:
			jump_distance -= 1
			position.y += (jump_max_distance - jump_distance) * delta * jump_force
			if jump_distance == 1:
				is_jumping = false
				jump_distance = 0
				position.y = initial_y_pos

func _on_hurtbox_area_entered(_area):
	$AnimationPlayer.play("Exploding")
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	dead.emit()
	is_dead = true

func _on_timer_speed_timeout():
	movement_speed += 10
