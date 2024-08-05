import 'package:bloc/bloc.dart';
import '../../data/models/animal_model.dart';
import '../../data/repository/animal_repository.dart';
import 'animal_state.dart';

class AnimalCubit extends Cubit<AnimalState>{
  final AnimalRepository animalRepository;

  AnimalCubit({ required this.animalRepository}) : super(AnimalInitial());

  Future<void> createAnimal(AnimalModel animal) async{
    try{
      emit(AnimalLoading());
      await animalRepository.createAnimal(animal);
      final animals = await animalRepository.getAllAnimals();
      emit(AnimalSuccess(animals: animals));
    }catch(e){
      emit(AnimalError(message: e.toString()));
    }
  }


  Future<void> fetchAllAnimals() async {
    try {
      emit(AnimalLoading());
      final animals = await animalRepository.getAllAnimals();
      emit(AnimalSuccess(animals: animals));
    } catch (e) {
      emit(AnimalError(message: e.toString()));
    }
  }
  Future<void> updateAnimal(AnimalModel user) async {
    try {
      emit(AnimalLoading());
      await animalRepository.updateAnimal(user);
      final animals = await animalRepository.getAllAnimals();
      emit(AnimalSuccess(animals: animals));
    } catch (e) {
      emit(AnimalError(message: e.toString()));
    }
  }

  Future<void> deleteAnimal(String id) async {
    try {
      emit(AnimalLoading());
      await animalRepository.deleteUser(id);
      final animals = await animalRepository.getAllAnimals();
      emit(AnimalSuccess(animals: animals));
    } catch (e) {
      emit(AnimalError(message: e.toString()));
    }
  }




}