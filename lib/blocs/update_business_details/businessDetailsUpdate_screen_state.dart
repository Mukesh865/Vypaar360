class BusinessDetailsUpdateState {
  final String businessName;
  final String contactNumber;
  final String email;
  final String gstNo;
  final String panNo;
  final String udhyamNo;
  final String taxCode;
  final String address;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  BusinessDetailsUpdateState({
    this.businessName = '',
    this.contactNumber = '',
    this.email = '',
    this.gstNo = '',
    this.panNo = '',
    this.udhyamNo = '',
    this.taxCode = '',
    this.address = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  BusinessDetailsUpdateState copyWith({
    String? businessName,
    String? contactNumber,
    String? email,
    String? gstNo,
    String? panNo,
    String? udhyamNo,
    String? taxCode,
    String? address,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return BusinessDetailsUpdateState(
      businessName: businessName ?? this.businessName,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      gstNo: gstNo ?? this.gstNo,
      panNo: panNo ?? this.panNo,
      udhyamNo: udhyamNo ?? this.udhyamNo,
      taxCode: taxCode ?? this.taxCode,
      address: address ?? this.address,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
