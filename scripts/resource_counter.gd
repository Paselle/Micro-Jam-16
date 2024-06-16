class_name ResourceCounter extends RichTextLabel


@export var initial_text: String = "Resources: "


func _enter_tree():
	Singleton.resource_couter = self
