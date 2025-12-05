class_name GPUBurstParticles2D extends GPUParticles2D


func _ready() -> void:
	finished.connect(queue_free)
	emitting = true
	explosiveness = 1.0
	one_shot = true
	restart()
