class Post {
  int id;
  String title;
  String content;

  Post({
    this.id,
    this.title,
    this.content
  });

  @override
  List<Object> get props => [id, title, content];
}