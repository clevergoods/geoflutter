class SupportScreenModelState {
  final String userEmail;
  final String userMessage;
  final bool hasAttachedFile;

  SupportScreenModelState({
    required this.userEmail,
    required this.userMessage,
    required this.hasAttachedFile
  });

  SupportScreenModelState.empty()
      : userEmail = '',
        userMessage = '',
        hasAttachedFile = false;

  SupportScreenModelState copyWith({
    String? userEmail,
    String? userMessage,
    bool? hasAttachedFile,
  }) {
    return SupportScreenModelState(
      userEmail: userEmail ?? this.userEmail,
      userMessage: userMessage ?? this.userMessage,
      hasAttachedFile: hasAttachedFile ?? this.hasAttachedFile,
    );
  }
}