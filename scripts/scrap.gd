extends Area3D


func _on_body_entered(body):
	if body is Ship:
		Singleton.increase_resources()
		queue_free()
