import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is NurseChange) {
      yield state.copyWith(
        status: NurseChanged(nurseId: event.nurseId),
        nurseId: event.nurseId,
      );
    }
  }
}
