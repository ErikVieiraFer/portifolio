class Project {
  final String title;
  final String description;
  final String imagePath;
  final String? githubUrl;
  final String? demoUrl;
  final bool isDraft;
  final List<String> techs;

  Project({
    required this.title,
    required this.description,
    required this.imagePath,
    this.githubUrl,
    this.demoUrl,
    this.isDraft = false,
    this.techs = const [],
  });
}
