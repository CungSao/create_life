extends Node2D

@onready var detectors = $ObsticleDetectors
@onready var sensors = $ObsticleSensors

var move_speed = 100
var velocity:Vector2
var steer_force = 50.0
var perception_radius:float = 50

var boids = []
var acceleration:Vector2
var alignment_force = 0.5
var cohesion_force = 0.5
var seperation_force = 1.0
var avoidance_force = 3.0

@export var colors:Array[Color]

func _ready():
	position = Vector2(randf_range(0, get_viewport().size.x), randf_range(0, get_viewport().size.y))
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * move_speed
	modulate = colors[randf_range(0, colors.size())]
	
func get_neighbors(view_radius):
	var neighbors = []

	for boid in boids:
		if boid == self: continue
		elif position.distance_to(boid.position) <= view_radius:
			neighbors.push_back(boid)
	return neighbors
	
func is_obsticle_ahead():
	for ray in detectors.get_children():
		if ray.is_colliding():
			return true
	return false

func process_obsticle_avoidance():
	for ray in sensors.get_children():
		if not ray.is_colliding():
			return steering( (ray.target_position.rotated(ray.rotation + rotation)).normalized() * move_speed )
	return Vector2.ZERO

func _process(delta):
	var neighbors = get_neighbors(perception_radius)
	
	acceleration += process_alignments(neighbors) * alignment_force
	acceleration += process_cohesion(neighbors) * cohesion_force
	acceleration += process_seperation(neighbors) * seperation_force

	if is_obsticle_ahead():
		acceleration += process_obsticle_avoidance() * avoidance_force
		
	velocity += acceleration * delta
	velocity = velocity.limit_length(move_speed)
	rotation = velocity.angle()
	
	translate(velocity * delta)
	position.x = wrapf(position.x, -32, get_viewport().size.x + 32)
	position.y = wrapf(position.y, -32, get_viewport().size.y + 32)
	
func process_alignments(neightbors, vector = Vector2.ZERO):
	if !neightbors:
		return vector
	
	for boid in neightbors:
		vector += boid.position
	vector /= neightbors.size()

	return steering(vector.normalized() * move_speed)

func process_cohesion(neightbors, vector = Vector2.ZERO):
	if !neightbors:
		return vector
	
	for boid in neightbors:
		vector += boid.position
	vector /= neightbors.size()

	return steering((vector-position).normalized() * move_speed)

func process_seperation(neightbors, vector = Vector2.ZERO):
	var close_neighbors = []
	for boid in neightbors:
		if position.distance_to(boid.position) < perception_radius/2:
			close_neighbors.push_back(boid)
	if !close_neighbors:
		return vector
	
	for boid in close_neighbors:
		var difference = position - boid.position
		vector += difference.normalized() / difference.length()
		
	vector /= close_neighbors.size()
	return steering(vector.normalized() * move_speed)

func steering(target:Vector2):
	var steer = target - velocity
	steer = steer.normalized() * steer_force
	return steer
