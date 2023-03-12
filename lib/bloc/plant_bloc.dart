import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_plan/bloc/plant_event.dart';
import 'package:plant_plan/bloc/plant_state.dart';
import 'package:plant_plan/repository/plant_repository.dart';

class PlantBloc extends Bloc<PlantEvent, PlantState> {
  final PlantRepository plantRepository;

  PlantBloc({
    required this.plantRepository,
  }) : super(Empty()) {
    on<GetPlantListEvent>(((event, emit) async {
      try {
        emit(Loading());
        final plants = await plantRepository.getPlantList();
        emit(Loaded(plants: plants));
      } catch (e) {
        emit(Error(message: e.toString()));
      }
    }));
    on<CreatePlantEvent>(((event, emit) async {
      try {
        emit(Loading());
        final plants = await plantRepository.getPlantList();
        emit(Loaded(plants: plants));
      } catch (e) {
        emit(Error(message: e.toString()));
      }
    }));
  }
}
