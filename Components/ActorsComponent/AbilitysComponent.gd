extends Node
class_name AbilitysComponent

export(NodePath) var statsPath
onready var stats = get_node(statsPath)

export(PackedScene) var Defense1Packscene
export(PackedScene) var Defense2Packscene
export(PackedScene) var Defense3Packscene
export(PackedScene) var Defense4Packscene
export(PackedScene) var Spell1Packscene
export(PackedScene) var Spell2Packscene
export(PackedScene) var Spell3Packscene
export(PackedScene) var Spell4Packscene

