extends RigidBody2D

var growing = true;
export var growthSpeed = 1;


func _process(delta):
	if(growing):
		$CollisionShape2D.scale.x += growthSpeed * delta;
		$CollisionShape2D.scale.y += growthSpeed * delta;
		mass = 1 * $CollisionShape2D.scale.x * $CollisionShape2D.scale.x;
