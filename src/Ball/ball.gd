extends CharacterBody2D
var speed = 600

func _ready():
	randomize()
	velocity.x = [-1,1] [randi() % 2]
	velocity.y = [-0.8,0.8] [randi() % 2]
	
func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		velocity = velocity.bounce(collision_object.get_normal())
		if collision_object.get_collider().name == "PlayerPaddle":
			$"../LeftHit".play()
		else: if collision_object.get_collider().name == "OpponentPaddle":
			$"../RightHit".play()
		else:
			$"../OtherHit".play()

func stop_ball():
	speed = 0
	
func restart_ball():
	speed = 600
	velocity.x = [-1,1] [randi() % 2]
	velocity.y = [-0.8,0.8] [randi() % 2]
