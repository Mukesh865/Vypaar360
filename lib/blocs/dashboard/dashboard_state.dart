/// Model class representing a single business card item shown on the dashboard.
class BusinessCardModel {
  final String title; // Display title of the business card
  final String logoAssetPath; // Path to the logo image asset
  final String platform; // Platform type (e.g., 'google', 'indiamart', 'justdial')

  BusinessCardModel({
    required this.title,
    required this.logoAssetPath,
    required this.platform,
  });
}

/**
 * State class representing the entire UI state of the Dashboard screen.
 * It holds platform selection, loading status, selected cards, all available business cards,
 * filtered cards (after search), and the current search query.
 */
class DashboardState {
  final String selectedPlatform; // Currently selected platform ('google', 'indiamart', 'justdial')
  final bool isLoading; // Indicates whether data is currently being loaded
  final Set<String> selectedCards; // Set of selected business card IDs (for multi-select behavior)
  final List<BusinessCardModel> businessCards; // All business cards for the selected platform
  final List<BusinessCardModel> filteredBusinessCards; // Cards after applying search filter
  final String searchQuery; // Current search query entered by the user

  DashboardState({
    this.selectedPlatform = 'google',
    this.isLoading = true,
    Set<String>? selectedCards,
    this.businessCards = const [],
    this.filteredBusinessCards = const [],
    this.searchQuery = '',
  }) : selectedCards = selectedCards ?? {};

  /**
   * Creates a new DashboardState by copying the current state and
   * replacing only the fields provided in the parameters.
   * This helps in maintaining immutability while updating state in the Bloc.
   */
  DashboardState copyWith({
    String? selectedPlatform,
    bool? isLoading,
    Set<String>? selectedCards,
    List<BusinessCardModel>? businessCards,
    List<BusinessCardModel>? filteredBusinessCards,
    String? searchQuery,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      selectedPlatform: selectedPlatform ?? this.selectedPlatform,
      selectedCards: selectedCards ?? this.selectedCards,
      businessCards: businessCards ?? this.businessCards,
      filteredBusinessCards: filteredBusinessCards ?? this.filteredBusinessCards,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
