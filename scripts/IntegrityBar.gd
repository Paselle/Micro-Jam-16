extends ProgressBar


func _enter_tree():
	Singleton.integrity_bar = self
