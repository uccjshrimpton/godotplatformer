extends KinematicBody2D

const GRAVITY = 10
const SPEED = 30
const FLOOR = Vector2(0, -1)

var velocity = Vector2(0,0)
var direction = 1
var is_dead = false

func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("dead")
	$CollisionShape2D.disabled = true
	$Timer.start()

func _physics_process(delta):
	if not is_dead:
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
			
		$AnimatedSprite.play("running")
	
		velocity.x = SPEED * direction
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		
		if is_on_wall():
			direction *= -1
			$RayCast2D.position.x *= -1
			
		if $RayCast2D.is_colliding() == false:
			direction *= -1	
			$RayCast2D.position.x *= -1

func _on_Timer_timeout():
	queue_free()
