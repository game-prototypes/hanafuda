class_name Utils
extends Reference


static func reparent_node(node: Node, to:Node):
	var node_transform=node.get_global_transform()
	var parent=node.get_parent()
	if parent!=null:
		parent.remove_child(node)
	to.add_child(node)
	node.global_transform=node_transform
