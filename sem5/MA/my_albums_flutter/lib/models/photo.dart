class Photo {
  final int id;
  final String title;
  String? albumTitle;
  final String url;
  DateTime? dateTaken;

  Photo({
    required this.id,
    required this.title,
    this.albumTitle,
    required this.url,
    this.dateTaken,
  }) {
    dateTaken = DateTime.now();
  }
}
