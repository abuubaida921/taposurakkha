class Court {
  final int id;
  final String name;
  final String? phone;
  final String? email;
  final String? address;
  final String? about;
  final String? governmentRegistrationNumber;
  final String? file;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Court({
    required this.id,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.about,
    this.governmentRegistrationNumber,
    this.file,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Court.fromJson(Map<String, dynamic> json) {
    return Court(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      about: json['about'],
      governmentRegistrationNumber: json['government_registration_number'],
      file: json['file'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
