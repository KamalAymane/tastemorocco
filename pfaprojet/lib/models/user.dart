class User {
  final String id;
  final String email;
  final List<String> allergies;
  final List<String> dietaryPreferences;

  User({
    required this.id,
    required this.email,
    this.allergies = const [],
    this.dietaryPreferences = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      allergies: List<String>.from(json['allergies']),
      dietaryPreferences: List<String>.from(json['dietary_preferences']),
    );
  }
}