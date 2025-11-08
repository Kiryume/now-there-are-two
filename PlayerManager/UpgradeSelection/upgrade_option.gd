@tool
extends Control

@onready var Title = $MarginContainer/BoxContainer/Title
@onready var Description = $MarginContainer/BoxContainer/Description

@export
var title: String:
	get:
		return Title.text
	set(val):
		Title.text = val

@export
var description: String:
	get:
		return Description.text
	set(val):
		Description.text = val
