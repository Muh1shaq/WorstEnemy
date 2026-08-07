extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -425.0

# Referensi node sprite animation
# Catatan: Jika node di panel Scene Anda bernama "Sprite2D", ubah $AnimatedSprite2D menjadi $Sprite2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D if has_node("AnimatedSprite2D") else $Sprite2D

# Nilai skala untuk menyamakan ukuran visual karakter
const SCALE_IDLE = Vector2(0.954, 0.954)
const SCALE_RUN = Vector2(2.293, 2.293)
const SCALE_JUMP = Vector2(3.904, 3.904)

var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# 1. Gravitasi saat berada di udara
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Input Lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Input Pergerakan Kiri & Kanan
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		# Membalikkan arah pandang sprite (flip)
		animated_sprite.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Pembaruan Status Animasi & Skala
	update_animation(direction)

	move_and_slide()

# Memutar animasi serta menerapkan skala gambar yang sesuai
func update_animation(direction: float) -> void:
	if is_on_floor():
		if direction != 0:
			animated_sprite.play("running")
			animated_sprite.scale = SCALE_RUN
		else:
			animated_sprite.play("idle")
			animated_sprite.scale = SCALE_IDLE
	else:
		animated_sprite.play("jump")
		animated_sprite.scale = SCALE_JUMP

# Fungsi kematian player saat menyentuh jebakan
func die() -> void:
	if is_dead:
		return
	is_dead = true
	print("Player mati! Mengulang level...")
	velocity = Vector2.ZERO
	get_tree().reload_current_scene()
