class Coach {
  final String id;
  final String name;
  final String specialization;
  final dynamic speciality;
  final dynamic photoUrl;
  String gender;
  String dateOfB;
  String city;
  String country;
  String email;
  String phoneNumber;
  List<SocialMedia> coachSocialMedia = [];

  Coach(
      {required this.id,
      required this.gender,
      required this.dateOfB,
      required this.name,
      required this.specialization,
      required this.speciality,
      required this.photoUrl,
      required this.city,
      required this.country,
      required this.phoneNumber,
      required this.coachSocialMedia,
      required this.email});
}

class Customer {
  final String id;
  final String name;
  final String email;
  // Add other customer-related fields

  Customer({required this.id, required this.name, required this.email});
}

class SocialMedia {
  String url;
  String picture;
  SocialMedia({required this.url, required this.picture});
}
