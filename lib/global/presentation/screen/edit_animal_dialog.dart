import 'package:flutter/material.dart';
import '../../presentation/cubits/animal_cubit.dart';
import '../../data/models/animal_model.dart';

class EditAnimalDialog extends StatefulWidget {
  final AnimalCubit animalCubit;
  final AnimalModel animal;

  const EditAnimalDialog({
    Key? key,
    required this.animalCubit,
    required this.animal,
  }) : super(key: key);

  @override
  _EditAnimalDialogState createState() => _EditAnimalDialogState();
}

class _EditAnimalDialogState extends State<EditAnimalDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _raceController;
  late TextEditingController _colorController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.animal.nombre);
    _ageController = TextEditingController(text: widget.animal.edad.toString());
    _raceController = TextEditingController(text: widget.animal.raza);
    _colorController = TextEditingController(text: widget.animal.color);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _raceController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Animal'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Campo para el nombre del animal
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            // Campo para la edad del animal
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an age';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            // Campo para la raza del animal
            TextFormField(
              controller: _raceController,
              decoration: const InputDecoration(labelText: 'Race'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a race';
                }
                return null;
              },
            ),
            // Campo para el color del animal
            TextFormField(
              controller: _colorController,
              decoration: const InputDecoration(labelText: 'Color'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a color';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        // Botón para cancelar la edición
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Cierra el diálogo sin acción
          },
          child: const Text('Cancel'),
        ),
        // Botón para guardar los cambios
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Crea un nuevo modelo de animal con los datos actualizados
              final updatedAnimal = AnimalModel(
                id: widget.animal.id, // Mantiene el ID original
                nombre: _nameController.text,
                edad: int.parse(_ageController.text),
                raza: _raceController.text,
                color: _colorController.text,
              );

              // Llamada al método updateAnimal del cubit
              await widget.animalCubit.updateAnimal(updatedAnimal);

              // Cierra el diálogo después de la edición
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}