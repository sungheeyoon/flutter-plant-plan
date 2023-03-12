import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:plant_plan/models/plant.dart';

@immutable
abstract class PlantEvent extends Equatable {}

class GetPlantListEvent extends PlantEvent {
  @override
  List<Object> get props => [];
}

class CreatePlantEvent extends PlantEvent {
  final Plant plant;

  CreatePlantEvent({
    required this.plant,
  });

  @override
  List<Object> get props => [plant];
}

class DeletePlantEvent extends PlantEvent {
  final Plant plant;

  DeletePlantEvent({
    required this.plant,
  });

  @override
  List<Object> get props => [plant];
}
