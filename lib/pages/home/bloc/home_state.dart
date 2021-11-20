part of 'home_bloc.dart';

abstract class HomeStatus {}

class NurseChanged extends HomeStatus {
  int nurseId;

  NurseChanged({required this.nurseId});
}

class HomeState {
  final HomeStatus? status;
  final int nurseId;

  HomeState({
    this.status,
    this.nurseId = 0,
  });

  HomeState copyWith({
    HomeStatus? status,
    int? nurseId,
  }) {
    return HomeState(
      status: status ?? this.status,
      nurseId: nurseId ?? this.nurseId,
    );
  }
}
