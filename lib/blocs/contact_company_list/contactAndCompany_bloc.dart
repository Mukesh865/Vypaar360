import 'package:vypaar360/blocs/contact_company_list/contactAndCompany_event.dart';
import 'package:vypaar360/blocs/contact_company_list/contactAndCompany_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactCompanyBloc extends Bloc<ContactCompanyEvent, ContactCompanyState> {
  ContactCompanyBloc() : super(ContactCompanyState(isContactSelected: true)) {
    on<ToggleToContact>((event, emit) {
      emit(state.copyWith(isContactSelected: true));
    });

    on<ToggleToCompany>((event, emit) {
      emit(state.copyWith(isContactSelected: false));
    });
  }
}
