class ExpenseState {
  final String selectedFilter;
  final double totalExpense;

  ExpenseState({this.selectedFilter = 'All Time', this.totalExpense = 2000.0});

  ExpenseState copyWith({String? selectedFilter, double? totalExpense}) {
    return ExpenseState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      totalExpense: totalExpense ?? this.totalExpense,
    );
  }
}
