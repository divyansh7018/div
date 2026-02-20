class AppUser {
  AppUser({
    required this.uid,
    required this.name,
    required this.email,
  });

  final String uid;
  final String name;
  final String email;

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        uid: json['uid'] as String,
        name: json['name'] as String? ?? 'Learner',
        email: json['email'] as String? ?? '',
      );
}
