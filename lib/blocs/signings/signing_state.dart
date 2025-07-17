import 'package:equatable/equatable.dart';

/**
 * State class for the Signings screen.
 * Holds the complete list of signings, filtered list (after search or status filter),
 * currently selected status filter, and the search query.
 */
class SigningsState extends Equatable {
  final List<String> allSignings; // Full list of all signings (from backend or dummy data)
  final List<String> filteredSignings; // List after applying search or status filter
  final String selectedStatus; // Currently selected status filter ('open', 'closed', 'paydue')
  final String searchQuery; // Current search query text

  /// Constructor with default values for initial state
  const SigningsState({
    this.allSignings = const [],
    this.filteredSignings = const [],
    this.selectedStatus = 'open',
    this.searchQuery = '',
  });

  /**
   * Creates a new SigningsState by copying the current state
   * and replacing only the provided fields.
   * This helps maintain immutability while updating state in the Bloc.
   */
  SigningsState copyWith({
    List<String>? allSignings,
    List<String>? filteredSignings,
    String? selectedStatus,
    String? searchQuery,
  }) {
    return SigningsState(
      allSignings: allSignings ?? this.allSignings,
      filteredSignings: filteredSignings ?? this.filteredSignings,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  /// Required for Equatable: ensures Bloc rebuilds UI only when state actually changes.
  @override
  List<Object?> get props => [allSignings, filteredSignings, selectedStatus, searchQuery];
}
