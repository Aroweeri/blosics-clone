extends RigidBody2D

enum CubeType {
	GREEN,
	RED,
	WHITE
}

export var scaleX = 1.0;
export var scaleY = 1.0;
export(CubeType) var type = CubeType.GREEN;

func _ready():
	mass = scaleX * scaleY;
	$CollisionShape2D.scale.x = scaleX;
	$CollisionShape2D.scale.y = scaleY;
	
	if(type == CubeType.GREEN):
		$CollisionShape2D/Sprite.modulate = Color(0,1,0,0.8);
	elif(type == CubeType.RED):
		$CollisionShape2D/Sprite.modulate = Color(1,0,0,0.8);
	elif(type == CubeType.WHITE):
		$CollisionShape2D/Sprite.modulate = Color(1,1,1,1);
