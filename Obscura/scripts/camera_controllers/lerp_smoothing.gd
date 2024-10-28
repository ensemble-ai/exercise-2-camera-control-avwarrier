class_name LerpSmoothingCamera
extends CameraControllerBase


@export var follow_speed: float = 1.5
@export var catchup_speed: float = 5.5
@export var leash_distance: float = 6


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
	
	var new_position

	if target.velocity == Vector3(0, 0, 0):
		new_position = cpos + direction * catchup_speed * delta
	elif abs(direction.x) >= leash_distance or abs(direction.z) >= leash_distance:
		
		new_position = global_position
		
		var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - leash_distance)
		if diff_between_left_edges < 0:
			print(diff_between_left_edges)
			new_position.x += diff_between_left_edges
		#right
		var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + leash_distance)
		if diff_between_right_edges > 0:
			new_position.x += diff_between_right_edges
		#top
		var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - leash_distance)
		if diff_between_top_edges < 0:
			print(diff_between_top_edges)
			new_position.z += diff_between_top_edges
		#bottom
		var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + leash_distance)
		if diff_between_bottom_edges > 0:
			new_position.z += diff_between_bottom_edges
			
	else:
		new_position = cpos + direction * follow_speed * delta

	global_position = new_position
		
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
