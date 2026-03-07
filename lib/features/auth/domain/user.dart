class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
  });

  User copyWith({String? id, String? name, String? email, String? photoUrl}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'photoUrl': photoUrl};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String? ?? '',
    );
  }
}
