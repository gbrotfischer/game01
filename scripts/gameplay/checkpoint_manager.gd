extends Node

class_name CheckpointManager

@export var player_path: NodePath
@export var respawn_offset: Vector3 = Vector3(0, 1, 0)

var player: CharacterBody3D
var current_checkpoint: Node3D
var initial_transform: Transform3D

func _ready() -> void:
        if player_path != NodePath():
                var node := get_node_or_null(player_path)
                if node is CharacterBody3D:
                        register_player(node)

func register_player(new_player: CharacterBody3D) -> void:
        player = new_player
        initial_transform = player.global_transform

func register_checkpoint(checkpoint: Node3D) -> void:
        current_checkpoint = checkpoint

func has_checkpoint() -> bool:
        return current_checkpoint != null

func respawn_player() -> void:
        if player == null:
                return

        var target_transform := initial_transform
        if current_checkpoint != null:
                target_transform = current_checkpoint.global_transform

        var target_position := target_transform.origin + respawn_offset
        player.velocity = Vector3.ZERO
        player.gravity = 0
        player.jump_single = true
        player.jump_double = true
        player.global_transform = Transform3D(target_transform.basis, target_position)
