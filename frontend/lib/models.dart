class Paragraph {
   int id;
   String title;
   String description;

  Paragraph({
    required this.id,
    required this.title,
    required this.description,
  });

  // factory Paragraph.fromJson(Map<String, dynamic> json) {
  //   return Paragraph(
  //      id: json['id'] ?? 0, title: json['title'] ?? '', description: json['description'] ?? '');
  // }
}
