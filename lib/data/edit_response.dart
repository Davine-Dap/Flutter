class EditResponse {
  final String message;
  final bool status;

  EditResponse(this.message, this.status);

  factory EditResponse.fromJson(Map<String, dynamic> json) {
    return EditResponse(json['message'] ?? '', json['status'] ?? true);
  }
}
