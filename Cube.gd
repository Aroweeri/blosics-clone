extends RigidBody2D

enum CubeType {
	GREEN,
	RED,
}

export var scaleX = 1.0;
export var scaleY = 1.0;
export(CubeType) var type = CubeType.GREEN;

func _ready():
	mass = scaleX * scaleY;
	$CollisionShape2D.scale.x = scaleX;
	$CollisionShape2D.scale.y = scaleY;
	
	if(type == CubeType.GREEN):
		$CollisionShape2D/Sprite.texture = load("res://Resources/cube_green.png");
	elif(type == CubeType.RED):
		$CollisionShape2D/Sprite.texture = load("res://Resources/cube_red.png");
