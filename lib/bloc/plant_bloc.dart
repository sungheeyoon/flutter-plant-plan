
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_plan/bloc/plant_event.dart';
import 'package:plant_plan/bloc/plant_state.dart';
import 'package:plant_plan/repository/plant_repository.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  final PlantRepository repository;

  PlantBloc({
    required this.repository,
  }) : super(Empty());

  @override
  on<ListPlantsEvent>((mapListPlantsEvent(event)));

  Stream<PlantState>_mapListPlantsEvent(ListPlantsEvent event)async*{
    try{
      yield Loading();

      repository.listPlant();
      
    }catch(e){
      yield Error(message: e.toString());
    }

  }
}
