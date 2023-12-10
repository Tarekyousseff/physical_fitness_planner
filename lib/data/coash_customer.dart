class Coach {
  final String id;
  final String name;
  final String specialization;
  final dynamic speciality;
  final dynamic photoUrl;

  Coach({
    required this.id,
    required this.name,
    required this.specialization,
    required this.speciality,
    required this.photoUrl,
  });
}


class Customer {
  final String id;
  final String name;
  final String email;
  // Add other customer-related fields

  Customer({required this.id, required this.name, required this.email});
}
