import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../data/models/animal_model.dart';

abstract class AnimalState extends Equatable {
  @override
  List<Object?> get props => [];

}
  class AnimalInitial extends AnimalState{}

  class AnimalLoading extends AnimalState{}

  class AnimalSuccess extends AnimalState{
    final List<AnimalModel> animals;
    AnimalSuccess({required this.animals});

    @override
    List<Object> get props =>[animals];
  }

  class AnimalError extends AnimalState{
    final String message;

    AnimalError({required this.message});

    @override
  List<Object?> get props => [message];
  }



