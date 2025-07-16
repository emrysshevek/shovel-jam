class_name Player
extends Entity

@onready var default_collision: CollisionShape2D = $DefaultCollision
@onready var floating_collision: CollisionShape2D = $FloatingCollision

func take_damage(amount: int):
    current_hearts -= amount
    print("The player took %d damage!" %[amount])
    print("Current Health: %d" % current_hearts)

func _process(_delta):
    if Input.is_action_just_pressed("accel"):
        velocity.y -= 500
        print("accel")