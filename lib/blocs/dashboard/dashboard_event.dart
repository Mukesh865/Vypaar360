/// Abstract base class for all Dashboard-related events.
/// All dashboard events will extend this.
abstract class DashboardEvent {}

/** 
 * Event: When the user selects a business platform
 * Example platforms: 'google', 'indiamart', 'justdial'
 * Used to load relevant business cards for the selected platform.
 */
class BusinessPlatformSelected extends DashboardEvent {
  final String platform; // Selected platform name (e.g., 'google')

  BusinessPlatformSelected(this.platform);
}

/// Event: Triggered when dashboard data needs to load initially.
/// Typically dispatched when the screen first opens.
class LoadDashboardData extends DashboardEvent {}

/// Event: Toggles selection state of a business card (select/unselect).
/// Used when the user taps a business card.
class ToggleCardSelection extends DashboardEvent {
  final String cardId; // Unique ID of the business card

  ToggleCardSelection(this.cardId);
}

/// Event: Triggered when the user updates the dashboard search query.
/// Used to filter business cards by title.
class DashboardSearchChanged extends DashboardEvent {
  final String query; // Current search input text

  DashboardSearchChanged(this.query);
}
