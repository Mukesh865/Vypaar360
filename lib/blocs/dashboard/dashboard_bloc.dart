import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

/// Bloc responsible for managing Dashboard state and business logic.
/// It handles platform selection, business card filtering, and card selection.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    
    /// Event: Load initial dashboard data
    /// - Fetches business cards for the default selected platform
    /// - Sets the initial filtered list to show all cards
    on<LoadDashboardData>((event, emit) {
      final platformCards = _getBusinessCardsForPlatform(state.selectedPlatform);

      emit(state.copyWith(
        isLoading: false,
        businessCards: platformCards,
        filteredBusinessCards: platformCards, // Show all cards by default
      ));
    });

    /// Event: When user selects a different business platform (Google, Indiamart, Justdial)
    /// - Updates platform
    /// - Fetches relevant cards for the selected platform
    /// - Filters them based on any existing search query
    on<BusinessPlatformSelected>((event, emit) {
      final cards = _getBusinessCardsForPlatform(event.platform);
      final filtered = _filterCards(cards, state.searchQuery);

      emit(state.copyWith(
        selectedPlatform: event.platform,
        businessCards: cards,
        filteredBusinessCards: filtered, // Keep previous search query applied
      ));
    });

    /// Event: Toggle selection of a business card
    /// - If card is already selected, unselect it
    /// - Else, select it
    on<ToggleCardSelection>((event, emit) {
      final updated = Set<String>.from(state.selectedCards);

      if (updated.contains(event.cardId)) {
        updated.remove(event.cardId);
      } else {
        updated.add(event.cardId);
      }

      emit(state.copyWith(selectedCards: updated));
    });

    /// Event: When user changes the dashboard search query
    /// - Filters current business cards based on the search query
    on<DashboardSearchChanged>((event, emit) {
      final filtered = _filterCards(state.businessCards, event.query);

      emit(state.copyWith(
        searchQuery: event.query,
        filteredBusinessCards: filtered,
      ));
    });
  }

  /// Helper: Filter business cards based on the search query (case-insensitive)
  List<BusinessCardModel> _filterCards(List<BusinessCardModel> cards, String query) {
    if (query.isEmpty) return cards;

    return cards
        .where((card) => card.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  /// Helper: Get dummy business cards for the selected platform.
  /// In the future, this will be replaced with actual Firebase Firestore fetch.
  List<BusinessCardModel> _getBusinessCardsForPlatform(String platform) {
    switch (platform) {
      case 'google':
        return [
          BusinessCardModel(
            title: "Google Business A",
            logoAssetPath: "assets/icons/google.png",
            platform: "google",
          ),
          BusinessCardModel(
            title: "Google Business B",
            logoAssetPath: "assets/icons/google.png",
            platform: "google",
          ),
        ];
      case 'indiamart':
        return [
          BusinessCardModel(
            title: "Indiamart Vendor A",
            logoAssetPath: "assets/icons/indiamart.png",
            platform: "indiamart",
          ),
          BusinessCardModel(
            title: "Indiamart Vendor B",
            logoAssetPath: "assets/icons/indiamart.png",
            platform: "indiamart",
          ),
        ];
      case 'justdial':
        return [
          BusinessCardModel(
            title: "Justdial Partner A",
            logoAssetPath: "assets/icons/justdial.png",
            platform: "justdial",
          ),
          BusinessCardModel(
            title: "Justdial Partner B",
            logoAssetPath: "assets/icons/justdial.png",
            platform: "justdial",
          ),
        ];
      default:
        return [];
    }
  }
}
