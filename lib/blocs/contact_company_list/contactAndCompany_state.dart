class ContactCompanyState {
  final bool isContactSelected;

  ContactCompanyState({required this.isContactSelected});

  ContactCompanyState copyWith({bool? isContactSelected}) {
    return ContactCompanyState(
      isContactSelected: isContactSelected ?? this.isContactSelected,
    );
  }
}
