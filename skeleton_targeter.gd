class_name SkeletonTargeter extends Node2D


func get_distance_to_skeleton() -> float:
	var skeleton = get_tree().get_first_node_in_group("Skeleton") as Skeleton
	if skeleton is not Skeleton: return -1
	return global_position.distance_to(skeleton.global_position)

func get_direction_to_skeleton() -> float:
	var skeleton = get_tree().get_first_node_in_group("Skeleton") as Skeleton
	if skeleton is not Skeleton: return -1
	return sign(global_position.direction_to(skeleton.global_position).x)
