import 'dart:io';

class BusinessDetailsState {
  final String businessName;
  final String contactNumber;
  final String emailAddress;
  final String gstNumber;
  final String panNumber;
  final String udhyamNumber;
  final File? profileImage;

  final bool isSubmitting;
  final bool formSubmissionSuccess;

  BusinessDetailsState({
    this.businessName = '',
    this.contactNumber = '',
    this.emailAddress = '',
    this.gstNumber = '',
    this.panNumber = '',
    this.udhyamNumber = '',
    this.profileImage,
    this.isSubmitting = false,
    this.formSubmissionSuccess = false,
  });

  BusinessDetailsState copyWith({
    String? businessName,
    String? contactNumber,
    String? emailAddress,
    String? gstNumber,
    String? panNumber,
    String? udhyamNumber,
    File? profileImage,
    bool? isSubmitting,
    bool? formSubmissionSuccess,
  }) {
    return BusinessDetailsState(
      businessName: businessName ?? this.businessName,
      contactNumber: contactNumber ?? this.contactNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      gstNumber: gstNumber ?? this.gstNumber,
      panNumber: panNumber ?? this.panNumber,
      udhyamNumber: udhyamNumber ?? this.udhyamNumber,
      profileImage: profileImage ?? this.profileImage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      formSubmissionSuccess: formSubmissionSuccess ?? this.formSubmissionSuccess,
    );
  }
}
