extends Area3D

@export var checkpoint_manager_path: NodePath
@export var checkpoint_node_path: NodePath

var checkpoint_manager: CheckpointManager
var checkpoint_node: Node3D

func _ready() -> void:
	if checkpoint_manager_path != NodePath():
		checkpoint_manager = get_node_or_null(checkpoint_manager_path)
	if checkpoint_node_path != NodePath():
		checkpoint_node = get_node_or_null(checkpoint_node_path)
	else:
		checkpoint_node = get_parent() as Node3D

	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if checkpoint_manager == null:
		return
	if not body.is_in_group("player"):
		return
	if checkpoint_node == null:
		checkpoint_node = get_parent() as Node3D
	checkpoint_manager.register_checkpoint(checkpoint_node)
