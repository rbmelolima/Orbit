class Apod {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String title;
  final String url;
  final String mediaType;

  Apod({
    this.copyright,
    this.date,
    this.explanation,
    this.hdurl,
    this.title,
    this.url,
    this.mediaType,
  });

  factory Apod.fromJson(Map<String, dynamic> json) {
    return Apod(
      copyright: json['copyright'],
      date: json['date'],
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      title: json['title'],
      url: json['url'],
      mediaType: json['media_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'copyright': copyright,
        'date': date,
        'explanation': explanation,
        'hdurl': hdurl,
        'title': title,
        'url': url,
        'media_type': mediaType,
      };
}
