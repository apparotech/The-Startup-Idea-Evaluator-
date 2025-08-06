class Idea {
  final String name;
  final String tagline;
  final String description;
  final int rating;
  int votes;

  Idea({
    required this.name,
    required this.tagline,
    required this.description,
    required this.rating,
    this.votes = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tagline': tagline,
      'description': description,
      'rating': rating,
      'votes': votes,
    };
  }

  factory Idea.fromMap(Map<String, dynamic> map) {
    return Idea(
      name: map['name'],
      tagline: map['tagline'],
      description: map['description'],
      rating: map['rating'],
      votes: map['votes'],
    );
  }

}