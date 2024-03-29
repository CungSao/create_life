extends Node2D

@onready var boid_scene = preload("res://_boid_p2/boid_2.tscn")
@onready var boids_container = $Boids

@export var BOIDS_COUNT = 50
var boids = []

func _ready():
	for i in BOIDS_COUNT:
		var boid = boid_scene.instantiate()
		boids_container.add_child(boid)
		boids.push_back(boid)
		
	for boid in boids_container.get_children():
		boid.boids = boids
