class Book {
  int? id;
  String title;
  String author;
  String coverUrl;
  String description;
  double rating;
  String category; // want / reading / read
  int totalPages;
  int currentPage;
  String notes;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    this.rating = 0.0,
    this.category = "want",
    this.totalPages = 0,
    this.currentPage = 0,
    this.notes = "",
  });

  double get progress =>
      totalPages == 0 ? 0 : currentPage / totalPages;

  // Convert to database map
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "author": author,
      "coverUrl": coverUrl,
      "description": description,
      "rating": rating,
      "category": category,
      "totalPages": totalPages,
      "currentPage": currentPage,
      "notes": notes,
    };
  }

  // Create from DB map
  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map["id"],
      title: map["title"],
      author: map["author"],
      coverUrl: map["coverUrl"],
      description: map["description"],
      rating: map["rating"] * 1.0,
      category: map["category"],
      totalPages: map["totalPages"],
      currentPage: map["currentPage"],
      notes: map["notes"],
    );
  }
}
