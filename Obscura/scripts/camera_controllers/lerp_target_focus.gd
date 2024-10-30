class_name LerpTargetFocusCamera
extends CameraControllerBase


@export var lead_speed: float
@export var catchup_delay_duration: float
@export var catchup_speed: float
@export var leash_distance: float

var waiting: bool = false
var timer_running: bool = false

func _ready() -> void:
	super()
	position = target.position
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position

	var direction = (tpos - cpos)
	
	var input_dir = Vector3(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		0,
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).limit_length(1)
		
	var new_position

	if target.velocity == Vector3(0, 0, 0):
		
		if not waiting and (abs(direction.x) >= 0.1 or abs(direction.z) >= 0.1) and not timer_running:
			timer_running = true
			await get_tree().create_timer(catchup_delay_duration).timeout
			waiting = true
			
		if waiting:
			global_position = global_position.lerp(tpos, catchup_speed * delta)
			if abs(direction.x) < 0.1 and abs(direction.z) < 0.1:
				timer_running = false
				waiting = false
		
	elif abs(direction.x) >= leash_distance or abs(direction.z) >= leash_distance:
		var temp_pos = cpos
		
		if input_dir.x != 0:
			temp_pos.x += input_dir.x
		if input_dir.z != 0:
			temp_pos.z += input_dir.z
		
		var curr_speed = pow(pow(target.velocity.x, 2) + pow(target.velocity.z, 2), 0.5)
		
		global_position = global_position.lerp(temp_pos, curr_speed * delta)
			
	else:
		global_position = global_position.lerp(cpos + input_dir, lead_speed * delta)

	if not timer_running:
		if input_dir.x == 0 and cpos.x > tpos.x + 0.16:
			global_position.x -= 0.3
		elif input_dir.x == 0 and cpos.x < tpos.x - 0.16:
			global_position.x += 0.3
		if input_dir.z == 0 and cpos.z > tpos.z + 0.16:
			global_position.z -= 0.3
		elif input_dir.z == 0 and cpos.z < tpos.z - 0.16:
			global_position.z += 0.3
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left:float = -5
	var right:float = 5
	var top:float = -5
	var bottom:float = 5
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(0, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, bottom))
	
	immediate_mesh.surface_add_vertex(Vector3(right, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, 0))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
