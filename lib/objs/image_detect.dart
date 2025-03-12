class ImageDetect {
  final String prediction;
  final String image;
  ImageDetect({
    required this.prediction,
    required this.image,
  });
  factory ImageDetect.fromJson(Map<String, dynamic> json) =>
      ImageDetect(prediction: json['prediction'], image: json['image']);
  Map<String, dynamic> toJon() => {
        'prediction': prediction,
        'image': image,
      };
}
