import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica/global/data/models/animal_model.dart';
import 'package:practica/global/presentation/cubits/animal_state.dart';
import '../../presentation/cubits/animal_cubit.dart';
import '../../data/repository/animal_repository.dart';
import 'package:practica/global/presentation/screen/edit_animal_dialog.dart';
import 'package:practica/global/presentation/screen/add_anima_dialog.dart';

class AnimalListView extends StatelessWidget {
  const AnimalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animal List'),
      ),
      body: BlocProvider(
        create: (context) => AnimalCubit(
          animalRepository: RepositoryProvider.of<AnimalRepository>(context),
        ),
        child: const AnimalListScreen(),
      ),
    );
  }
}

class AnimalListScreen extends StatelessWidget {
  const AnimalListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animalCubit = BlocProvider.of<AnimalCubit>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            animalCubit.fetchAllAnimals();
          },
          child: const Text('Fetch Animals'),
        ),
        ElevatedButton(
          onPressed: () {
            _showAddAnimalDialog(context, animalCubit);
          },
          child: const Text('Add Animal'),
        ),
        Expanded(
          child: BlocBuilder<AnimalCubit, AnimalState>(
            builder: (context, state) {
              if (state is AnimalLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AnimalSuccess) {
                final animals = state.animals;
                return ListView.builder(
                  itemCount: animals.length,
                  itemBuilder: (context, index) {
                    final animal = animals[index];
                    return ListTile(
                      title: Text(animal.nombre),
                      subtitle: Text(animal.raza),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              _showEditAnimalDialog(
                                  context, animalCubit, animal);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _showDeleteConfirmationDialog(
                                  context, animalCubit, animal);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is AnimalError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(
                  child: Text('Press the button to fetch animals'));
            },
          ),
        ),
      ],
    );
  }

  void _showAddAnimalDialog(BuildContext context, AnimalCubit animalCubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAnimalDialog(animalCubit: animalCubit);
      },
    );
  }

  void _showEditAnimalDialog(
      BuildContext context, AnimalCubit animalCubit, AnimalModel animal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditAnimalDialog(
          animalCubit: animalCubit,
          animal: animal,
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, AnimalCubit animalCubit, AnimalModel animal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Animal'),
          content: Text(
              'Are you sure you want to delete ${animal.nombre}? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await animalCubit.deleteAnimal(animal.id.toString()); // Elimina el animal
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}