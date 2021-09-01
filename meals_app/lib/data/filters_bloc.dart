import 'package:bloc/bloc.dart';

import 'filters_events.dart';
import 'filters_state.dart';

export 'filters_events.dart';
export 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersState.initial());

  @override
  Stream<FiltersState> mapEventToState(FiltersEvent event) async* {
    switch (event.runtimeType) {
      case SetFilterEvent:
        yield _mergeFilters(event as SetFilterEvent);
        break;
      case ClearFiltersEvent:
        yield FiltersState.initial();
        break;
    }
  }

  FiltersState _mergeFilters(SetFilterEvent event) => FiltersState(
        showGlutenFree: event.showGlutenFree ?? state.showGlutenFree,
        showLactoseFree: event.showLactoseFree ?? state.showLactoseFree,
        showVegan: event.showVegan ?? state.showVegan,
      );
}
