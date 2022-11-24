class Photo {
  final int id;
  final String title;
  final String author;
  final int nrOfPages;
  final int rating;

  Photo({
    required this.id,
    required this.title,
    required this.author,
    this.nrOfPages = 0,
    this.rating = 1,
  });
}
