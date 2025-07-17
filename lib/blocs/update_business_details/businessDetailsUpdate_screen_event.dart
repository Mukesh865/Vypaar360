abstract class BusinessDetailsUpdateEvent {}

class InitializeBusinessDetails extends BusinessDetailsUpdateEvent {
  final String businessName;
  final String contactNumber;
  final String email;
  final String gstNo;
  final String panNo;
  final String udhyamNo;

  InitializeBusinessDetails({
    required this.businessName,
    required this.contactNumber,
    required this.email,
    required this.gstNo,
    required this.panNo,
    required this.udhyamNo,
  });
}

class BusinessFieldChanged extends BusinessDetailsUpdateEvent {
  final String field;
  final String value;

  BusinessFieldChanged({required this.field, required this.value});
}

class SubmitBusinessDetails extends BusinessDetailsUpdateEvent {}
