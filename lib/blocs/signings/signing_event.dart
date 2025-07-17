import 'package:equatable/equatable.dart';

/// Abstract base class for all Signings-related events.
/// All specific events will extend this class.
abstract class SigningsEvent extends Equatable {
  const SigningsEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Load all signings data when the screen initializes or refreshes.
class LoadSignings extends SigningsEvent {}

/// Event: Filter signings based on their status.
/**
 * Triggered when the user taps on status filter buttons (Open, Closed, Paydue).
 * Example statuses: "open", "closed", "paydue"
 */
class FilterSigningsByStatus extends SigningsEvent {
  final String status; // Selected status for filtering

  const FilterSigningsByStatus(this.status);

  @override
  List<Object?> get props => [status];
}

/// Event: Search signings by user-entered text query.
/**
 * Triggered when user types in the search bar.
 * Filters signings list by checking if each signing contains the query text.
 */
class SearchSignings extends SigningsEvent {
  final String query; // Current search query entered by the user

  const SearchSignings(this.query);

  @override
  List<Object?> get props => [query];
}
