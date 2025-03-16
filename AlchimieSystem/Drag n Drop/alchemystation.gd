extends Node2D

@onready var absorber = $recep_mortier 
@onready var spawner = $spawner_mortier 
@onready var marmAbsorber = $recep_marmite
@onready var marmSpawner = $spawner_marmite
@onready var alamAbsorber = $recep_alambic
@onready var alamSpawner = $spawner_alambic

func _ready():
	var absorber = get_node_or_null("RecepMortier")  # Match exact name
	var spawner = get_node_or_null("SpawnerMortier")
	var marmAbsorber = get_node_or_null("RecepMarmite")  # Match exact name
	var marmSpawner = get_node_or_null("SpawnerMarmite")
	var alamAbsorber = get_node_or_null("RecepAlambic")  # Match exact name
	var alamSpawner = get_node_or_null("SpawnerAlambic")

	if absorber and spawner:
		spawner.call_deferred("connect_to_absorber", absorber)
	else:
		print("Error: One or both nodes are missing! Absorber:", absorber, " Spawner:", spawner)
	if marmAbsorber and marmSpawner:
		marmSpawner.call_deferred("connect_to_absorber", marmAbsorber)
	else:
		print("Error: One or both nodes are missing!marmAbsorber:", marmAbsorber, " marmSpawner:", marmSpawner)
	if alamAbsorber and alamSpawner:
		alamSpawner.call_deferred("connect_to_absorber", alamAbsorber)
	else:
		print("Error: One or both nodes are missing!alamAbsorber:", alamAbsorber, " alamSpawner:", alamSpawner)
