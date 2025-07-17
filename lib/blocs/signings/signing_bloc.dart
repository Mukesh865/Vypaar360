import 'package:vypaar360/blocs/signings/signing_event.dart';
import 'package:vypaar360/blocs/signings/signing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * Bloc responsible for managing the Signings screen state and logic.
 * Handles loading signings, filtering by status, and searching by text.
 */
class SigningsBloc extends Bloc<SigningsEvent, SigningsState> {
  SigningsBloc() : super(const SigningsState()) {
    // Event handler for loading initial signings data
    on<LoadSignings>(_onLoadSignings);

    // Event handler for filtering signings by status (e.g., Open, Closed, Paydue)
    on<FilterSigningsByStatus>(_onFilterByStatus);

    // Event handler for searching signings by text query
    on<SearchSignings>(_onSearchSignings);
  }

  /**
   * Loads sample signings data into the state.
   * This simulates fetching data (replace with API/Firestore in the future).
   */
  void _onLoadSignings(LoadSignings event, Emitter<SigningsState> emit) {
    final sampleData = ['Contract A', 'Contract B', 'Contract C']; // Dummy data
    emit(state.copyWith(
      allSignings: sampleData,
      filteredSignings: sampleData, // Initially show all
    ));
  }

  /**
   * Filters the signings list based on the selected status (Open/Closed/Paydue).
   * Updates the filtered signings list accordingly.
   */
  void _onFilterByStatus(FilterSigningsByStatus event, Emitter<SigningsState> emit) {
    final filtered = state.allSignings
        .where((item) => item.toLowerCase().contains(event.status))
        .toList();

    emit(state.copyWith(
      selectedStatus: event.status,
      filteredSignings: filtered,
    ));
  }

  /**
   * Filters the signings list based on the user’s search query.
   * Performs case-insensitive search over all signings.
   */
  void _onSearchSignings(SearchSignings event, Emitter<SigningsState> emit) {
    final filtered = state.allSignings
        .where((item) => item.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(state.copyWith(
      searchQuery: event.query,
      filteredSignings: filtered,
    ));
  }
}
