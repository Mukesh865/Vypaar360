import 'dart:io';
import 'package:vypaar360/blocs/update_business_details/businessDetailsUpdate_screen_event.dart';

abstract class BusinessDetailsEvent {}

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

// --- Update Individual Fields ---
class UpdateBusinessName extends BusinessDetailsEvent {
  final String businessName;
  UpdateBusinessName(this.businessName);
}

class UpdateContactNumber extends BusinessDetailsEvent {
  final String contactNumber;
  UpdateContactNumber(this.contactNumber);
}

class UpdateEmailAddress extends BusinessDetailsEvent {
  final String emailAddress;
  UpdateEmailAddress(this.emailAddress);
}

class UpdateGstNumber extends BusinessDetailsEvent {
  final String gstNumber;
  UpdateGstNumber(this.gstNumber);
}

class UpdatePanNumber extends BusinessDetailsEvent {
  final String panNumber;
  UpdatePanNumber(this.panNumber);
}

class UpdateUdhyamNumber extends BusinessDetailsEvent {
  final String udhyamNumber;
  UpdateUdhyamNumber(this.udhyamNumber);
}

// --- Profile Image Update ---
class UpdateProfileImage extends BusinessDetailsEvent {
  final File imageFile;
  UpdateProfileImage(this.imageFile);
}

// --- Form Submit Action ---
class SubmitForm extends BusinessDetailsEvent {}
