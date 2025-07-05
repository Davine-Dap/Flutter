/// Represents the response received from the server after a delete operation.
class DeleteResponse {
  /// The message from the server, e.g., "Item successfully deleted."
  final String message;

  DeleteResponse({required this.message});

  /// A factory constructor for creating a new `DeleteResponse` instance
  /// from a map. This is used to parse the JSON response from the server.
  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResponse(message: json['message']);
  }
}
