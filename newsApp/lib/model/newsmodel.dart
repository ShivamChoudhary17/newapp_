class NewsModel {
  late String newsHead;
  late String newsDes;
  late String newsImg;
  late String newsUrl;
  late String newsContent;
  late String status;

  NewsModel({
    this.newsHead = "HEADING",
    this.newsDes = "NEWS_DESCRIPTION",
    this.newsImg = "IMAGE",
    this.newsUrl = "URL",
    this.newsContent = "CONTENT",
    this.status = "STATUS"
  });

  factory NewsModel.fromMap(Map news) {
    return NewsModel(
      newsHead: news["title"],
      newsDes: news["description"],
      newsUrl: news["url"],
      newsImg: news["urlToImage"],
      newsContent: news["content"],
    );
  }
}
