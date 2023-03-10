import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:plant_plan/models/plant.dart';

@immutable
abstract class PlantState extends Equatable {}

class Empty extends PlantState {
  @override
  List<Object?> get props => [];
}

class Loading extends PlantState {
  @override
  List<Object?> get props => [];
}

class Error extends PlantState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loaded extends PlantState {
  final List<Plant> plants;

  Loaded({required this.plants});

  @override
  List<Object?> get props => [plants];
}
