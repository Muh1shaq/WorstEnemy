extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = -320.0

func _physics_process(delta: float) -> void:
	# Gravitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Pergerakan Kiri & Kanan
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		# Balikkan arah sprite (flip)
		$Sprite2D.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Fungsi ketika player terkena jebakan
func die() -> void:
	print("Player mati! Mengulang level...")
	get_tree().reload_current_scene()
