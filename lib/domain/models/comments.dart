class CommentModel{
  String? text;
  String? parkId;
  String? author;
  String? authorId;
  String? docId;

  CommentModel.fromJsonMap(Map<String, dynamic> map):
        text = map["text"],
        author = map["author"],
        authorId = map["authorId"],
        docId = map["commentId"],
        parkId=map["parkId"];
}