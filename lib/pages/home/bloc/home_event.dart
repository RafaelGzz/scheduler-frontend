part of 'home_bloc.dart';

abstract class HomeEvent {}

class NurseChange extends HomeEvent {
  int nurseId;

  NurseChange({required this.nurseId});
}
