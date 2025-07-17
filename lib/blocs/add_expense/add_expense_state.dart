class SigningState {
  final bool isUploading;

  SigningState({this.isUploading = false});

  SigningState copyWith({bool? isUploading}) {
    return SigningState(
      isUploading: isUploading ?? this.isUploading,
    );
  }
}
