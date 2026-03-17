extends CharacterBody2D
var startSpeed = 400
var speed = startSpeed
var isInWater = false

func _ready():
	randomize()
	velocity.x = [-1,1] [randi() % 2]
	velocity.y = [-0.8,0.8] [randi() % 2]
	
func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		if collision_object.get_collider().is_in_group("LeftPlayerGroup"):
			$"../LeftHit".play()
			speed += 20
		elif collision_object.get_collider().is_in_group("RightPlayerGroup"):
			$"../RightHit".play()
			speed += 20
		else:
			$"../OtherHit".play()
			speed += 10
		velocity = velocity.bounce(collision_object.get_normal())

func stop_ball():
	speed = 0
	
func restart_ball():
	speed = startSpeed
	velocity.x = [-1,1] [randi() % 2]
	velocity.y = [-0.8,0.8] [randi() % 2]
