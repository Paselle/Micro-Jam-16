extends AnimationPlayer


func _enter_tree():
	Singleton.losing_animation = self
