extends Timer


func _enter_tree():
	Singleton.switch_cooldown = self
