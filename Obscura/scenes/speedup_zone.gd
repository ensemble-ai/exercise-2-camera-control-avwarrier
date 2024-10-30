class_name SpeedupZoneCamera
extends CameraControllerBase


@export var push_ratio: float
@export var pushbox_top_left: Vector2
@export var pushbox_bottom_right: Vector2
@export var speedup_zone_top_left: Vector2
@export var speedup_zone_bottom_right: Vector2

var outer_x: bool = false
var outer_y: bool = false

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
	
	
	if direction.x <= speedup_zone_top_left.x or direction.x >= speedup_zone_bottom_right.x:
		outer_x = true
		global_position = global_position.lerp(Vector3(tpos.x, 0, cpos.z), 6.3 * delta)
		
	if direction.z <= speedup_zone_top_left.y or direction.z >= speedup_zone_bottom_right.y:
		outer_y = true
		global_position = global_position.lerp(Vector3(cpos.x, 0, tpos.z), 6.3 * delta)
		
	if not outer_x and (direction.x <= pushbox_top_left.x or direction.x >= pushbox_bottom_right.x):
		global_position = global_position.lerp(Vector3(tpos.x, 0, cpos.z), 3 * push_ratio * delta)
		
	if not outer_y and (direction.z <= pushbox_top_left.y or direction.z >= pushbox_bottom_right.y):
		global_position = global_position.lerp(Vector3(cpos.x, 0, tpos.z), 3 * push_ratio * delta)
		
	
	if direction.x > pushbox_top_left.x and direction.x < pushbox_bottom_right.x:
		outer_x = false
		
	if direction.z > pushbox_top_left.y and direction.z < pushbox_bottom_right.y:
		outer_y = false
	
	#if (
		#direction.x <= speedup_zone_top_left.x or
		#direction.x >= speedup_zone_bottom_right.x or
		#direction.z <= speedup_zone_top_left.y or
		#direction.z >= speedup_zone_bottom_right.y
	#):
		#global_position = global_position.lerp(tpos, 6.3 * delta)
	#elif (
		#direction.x <= pushbox_top_left.x or
		#direction.x >= pushbox_bottom_right.x or
		#direction.z <= pushbox_top_left.y or
		#direction.z >= pushbox_bottom_right.y
	#):
		#global_position = global_position.lerp(tpos, 2 * push_ratio * delta)
		
	super(delta)


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	
	# Push Box
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_top_left.x, 0, pushbox_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(pushbox_bottom_right.x, 0, pushbox_bottom_right.y))
	
	
	# Speedup Zone
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_top_left.x, 0, speedup_zone_bottom_right.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_top_left.y))
	immediate_mesh.surface_add_vertex(Vector3(speedup_zone_bottom_right.x, 0, speedup_zone_bottom_right.y))
	
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.WHITE
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
