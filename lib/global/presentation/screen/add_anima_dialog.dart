import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/animal_model.dart';
import '../cubits/animal_cubit.dart';

class AddAnimalDialog extends StatefulWidget {
  const AddAnimalDialog({Key? key, required AnimalCubit animalCubit}) : super(key: key);

  @override
  _AddAnimalDialogState createState() => _AddAnimalDialogState();
}

class _AddAnimalDialogState extends State<AddAnimalDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _raceController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  @override
  void dispose() {
    // Liberar los controladores cuando el widget se elimine para evitar fugas de memoria.
    _idController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _raceController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Animal'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildTextField(_idController, 'ID', 'Enter the animal ID', TextInputType.number),
              _buildTextField(_nameController, 'Name', 'Enter the animal name'),
              _buildTextField(_ageController, 'Age', 'Enter the animal age', TextInputType.number),
              _buildTextField(_raceController, 'Race', 'Enter the animal race'),
              _buildTextField(_colorController, 'Color', 'Enter the animal color'),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _addAnimal,
          child: const Text('Add'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, [TextInputType inputType = TextInputType.text]) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a valid $label.';
        }
        return null;
      },
    );
  }

  void _addAnimal() {
    if (_formKey.currentState!.validate()) {
      final animal = AnimalModel(
        id: int.tryParse(_idController.text) ?? 0, // Usa tryParse para evitar excepciones en caso de entrada no válida
        nombre: _nameController.text,
        edad: int.tryParse(_ageController.text) ?? 0,
        raza: _raceController.text,
        color: _colorController.text,
      );

      // Utiliza AnimalCubit para agregar el nuevo animal
      BlocProvider.of<AnimalCubit>(context).createAnimal(animal);

      // Cierra el diálogo después de agregar el animal
      Navigator.of(context).pop();
    }
  }
}