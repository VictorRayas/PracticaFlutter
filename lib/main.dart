import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica/global/presentation/screen/get_all_animals_sceen.dart';
import 'package:practica/global/data/repository/animal_repository.dart';
import 'package:practica/global/presentation/cubits/animal_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AnimalRepository>(
          create: (context) => AnimalRepository(
            apiUrl: 'https://kyqzrot9a8.execute-api.us-east-1.amazonaws.com/Prod',
            //accessToken: 'your-access-token', // Reemplaza con tu token
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AnimalCubit>(
            create: (context) => AnimalCubit(
              animalRepository: RepositoryProvider.of<AnimalRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AnimalListView(),
        ),
      ),
    );
  }
}
