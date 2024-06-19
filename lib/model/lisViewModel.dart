class Post {
  int? id;
  String? title;
  String? description;
  String? address;
  String? postcode;
  String? phoneNumber;
  String? latitude;
  String? longitude;
  PostImage? image;

  Post(
      {this.id,
      this.title,
      this.description,
      this.address,
      this.postcode,
      this.phoneNumber,
      this.latitude,
      this.longitude,
      this.image});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    address = json['address'];
    postcode = json['postcode'];
    phoneNumber = json['phoneNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'] != null ? PostImage.fromJson(json['image']) : null;
  }
}

class PostImage {
  String? small;
  String? medium;
  String? large;

  PostImage({this.small, this.medium, this.large});

  PostImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }
}
