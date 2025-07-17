// expense_event.dart
abstract class ExpenseEvent {}

class ChangeFilter extends ExpenseEvent {
  final String filter;
  ChangeFilter(this.filter);
}
