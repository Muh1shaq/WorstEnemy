extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = -425.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D if has_node("AnimatedSprite2D") else $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

# Referensi Node Audio SFX
@onready var walk_sfx: AudioStreamPlayer2D = $WalkSFX
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var death_sfx: AudioStreamPlayer2D = $DeathSFX

const SCALE_IDLE = Vector2(0.954, 0.954)
const SCALE_RUN = Vector2(2.293, 2.293)
const SCALE_JUMP = Vector2(3.904, 3.904)

var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# 1. Gravitasi
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Input Lompat + Suara Lompat
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	# 3. Input Pergerakan Kiri & Kanan
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Suara Berjalan
	if is_on_floor() and direction != 0:
		if not walk_sfx.playing:
			walk_sfx.play()
	else:
		walk_sfx.stop()

	update_animation(direction)
	move_and_slide()

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

# 5. Fungsi Mati + Suara Mati (Menggunakan Jeda Timer agar suara selesai)
func die() -> void:
	if is_dead:
		return
	is_dead = true
	walk_sfx.stop()
	death_sfx.play()
	velocity = Vector2.ZERO
	
	# Menunggu 0.6 detik agar suara mati terdengar sebelum reload
	await get_tree().create_timer(0.6).timeout
	get_tree().reload_current_scene()
