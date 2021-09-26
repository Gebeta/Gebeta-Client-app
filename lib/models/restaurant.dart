class Restaurant {
  late final String id;
  late final String name;
  late final String address;
  late final String image;
  late final String phoneNo;
  late final String email;
  late final double rating;
  late final bool isApproved;
  late final bool status;
  final double latitude;
  final double longtiude;

  Restaurant(
      {required this.id,
      required this.name,
      required this.address,
      required this.phoneNo,
      required this.image,
      required this.email,
      required this.rating,
      required this.isApproved,
      required this.status,
      required this.latitude,
      required this.longtiude});
}
