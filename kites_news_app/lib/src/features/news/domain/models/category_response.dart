import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';

part 'category_response.g.dart';

@autoequal
class CategoryResponse extends Equatable {
  final String? category;
  final int? timestamp;
  final int? read;
  final List<Cluster>? clusters;

  CategoryResponse({this.category, this.timestamp, this.read, this.clusters});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        category: json["category"],
        timestamp: json["timestamp"],
        read: json["read"],
        clusters: json["clusters"] == null
            ? []
            : List<Cluster>.from(json["clusters"]!.map((x) => Cluster.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "timestamp": timestamp,
        "read": read,
        "clusters":
            clusters == null ? [] : List<dynamic>.from(clusters!.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => _$props;
}

@autoequal
class Cluster extends Equatable {
  final int? clusterNumber;
  final int? uniqueDomains;
  final int? numberOfTitles;
  final String? category;
  final String? title;
  final String? shortSummary;
  final String? didYouKnow;
  final List<String>? talkingPoints;
  final String? quote;
  final String? quoteAuthor;
  final String? quoteSourceUrl;
  final String? quoteSourceDomain;
  final String? location;
  final List<Perspective>? perspectives;
  final String? emoji;
  final String? geopoliticalContext;
  final String? historicalBackground;
  final dynamic internationalReactions;
  final String? humanitarianImpact;
  final String? economicImplications;
  final dynamic timeline;
  final String? futureOutlook;
  final List<dynamic>? keyPlayers;
  final dynamic technicalDetails;
  final String? businessAngleText;
  final List<String>? businessAnglePoints;
  final dynamic userActionItems;
  final List<String>? scientificSignificance;
  final List<dynamic>? travelAdvisory;
  final String? destinationHighlights;
  final String? culinarySignificance;
  final List<dynamic>? performanceStatistics;
  final String? leagueStandings;
  final String? diyTips;
  final String? designPrinciples;
  final dynamic userExperienceImpact;
  final List<dynamic>? gameplayMechanics;
  final List<String>? industryImpact;
  final String? technicalSpecifications;
  final List<Article>? articles;
  final List<Domain>? domains;

  Cluster({
    this.clusterNumber,
    this.uniqueDomains,
    this.numberOfTitles,
    this.category,
    this.title,
    this.shortSummary,
    this.didYouKnow,
    this.talkingPoints,
    this.quote,
    this.quoteAuthor,
    this.quoteSourceUrl,
    this.quoteSourceDomain,
    this.location,
    this.perspectives,
    this.emoji,
    this.geopoliticalContext,
    this.historicalBackground,
    this.internationalReactions,
    this.humanitarianImpact,
    this.economicImplications,
    this.timeline,
    this.futureOutlook,
    this.keyPlayers,
    this.technicalDetails,
    this.businessAngleText,
    this.businessAnglePoints,
    this.userActionItems,
    this.scientificSignificance,
    this.travelAdvisory,
    this.destinationHighlights,
    this.culinarySignificance,
    this.performanceStatistics,
    this.leagueStandings,
    this.diyTips,
    this.designPrinciples,
    this.userExperienceImpact,
    this.gameplayMechanics,
    this.industryImpact,
    this.technicalSpecifications,
    this.articles,
    this.domains,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) => Cluster(
        clusterNumber: json["cluster_number"],
        uniqueDomains: json["unique_domains"],
        numberOfTitles: json["number_of_titles"],
        category: json["category"],
        title: json["title"],
        shortSummary: json["short_summary"],
        didYouKnow: json["did_you_know"],
        talkingPoints: json["talking_points"] == null
            ? []
            : List<String>.from(json["talking_points"]!.map((x) => x)),
        quote: json["quote"],
        quoteAuthor: json["quote_author"],
        quoteSourceUrl: json["quote_source_url"],
        quoteSourceDomain: json["quote_source_domain"],
        location: json["location"],
        perspectives: json["perspectives"] == null
            ? []
            : List<Perspective>.from(
                json["perspectives"]!.map((x) => Perspective.fromJson(x)),
              ),
        emoji: json["emoji"],
        geopoliticalContext: json["geopolitical_context"],
        historicalBackground: json["historical_background"],
        internationalReactions: json["international_reactions"],
        humanitarianImpact: json["humanitarian_impact"],
        economicImplications: json["economic_implications"],
        timeline: json["timeline"],
        futureOutlook: json["future_outlook"],
        keyPlayers: json["key_players"] == null
            ? []
            : List<dynamic>.from(json["key_players"]!.map((x) => x)),
        technicalDetails: json["technical_details"],
        businessAngleText: json["business_angle_text"],
        businessAnglePoints: json["business_angle_points"] == null
            ? []
            : List<String>.from(json["business_angle_points"]!.map((x) => x)),
        userActionItems: json["user_action_items"],
        scientificSignificance: json["scientific_significance"] == null
            ? []
            : List<String>.from(json["scientific_significance"]!.map((x) => x)),
        travelAdvisory: json["travel_advisory"] == null
            ? []
            : List<dynamic>.from(json["travel_advisory"]!.map((x) => x)),
        destinationHighlights: json["destination_highlights"],
        culinarySignificance: json["culinary_significance"],
        performanceStatistics: json["performance_statistics"] == null
            ? []
            : List<dynamic>.from(json["performance_statistics"]!.map((x) => x)),
        leagueStandings: json["league_standings"],
        diyTips: json["diy_tips"],
        designPrinciples: json["design_principles"],
        userExperienceImpact: json["user_experience_impact"] is List
            ? List<dynamic>.from(json["user_experience_impact"]!)
            : json["user_experience_impact"],
        gameplayMechanics: json["gameplay_mechanics"] == null
            ? []
            : List<dynamic>.from(json["gameplay_mechanics"]!.map((x) => x)),
        industryImpact: json["industry_impact"] == null
            ? []
            : List<String>.from(json["industry_impact"]!.map((x) => x)),
        technicalSpecifications: json["technical_specifications"],
        articles: json["articles"] == null
            ? []
            : List<Article>.from(json["articles"]!.map((x) => Article.fromJson(x))),
        domains: json["domains"] == null
            ? []
            : List<Domain>.from(json["domains"]!.map((x) => Domain.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cluster_number": clusterNumber,
        "unique_domains": uniqueDomains,
        "number_of_titles": numberOfTitles,
        "category": category,
        "title": title,
        "short_summary": shortSummary,
        "did_you_know": didYouKnow,
        "talking_points":
            talkingPoints == null ? [] : List<dynamic>.from(talkingPoints!.map((x) => x)),
        "quote": quote,
        "quote_author": quoteAuthor,
        "quote_source_url": quoteSourceUrl,
        "quote_source_domain": quoteSourceDomain,
        "location": location,
        "perspectives": perspectives == null
            ? []
            : List<dynamic>.from(perspectives!.map((x) => x.toJson())),
        "emoji": emoji,
        "geopolitical_context": geopoliticalContext,
        "historical_background": historicalBackground,
        "international_reactions": internationalReactions,
        "humanitarian_impact": humanitarianImpact,
        "economic_implications": economicImplications,
        "timeline": timeline,
        "future_outlook": futureOutlook,
        "key_players":
            keyPlayers == null ? [] : List<dynamic>.from(keyPlayers!.map((x) => x)),
        "technical_details": technicalDetails,
        "business_angle_text": businessAngleText,
        "business_angle_points": businessAnglePoints == null
            ? []
            : List<dynamic>.from(businessAnglePoints!.map((x) => x)),
        "user_action_items": userActionItems,
        "scientific_significance": scientificSignificance == null
            ? []
            : List<dynamic>.from(scientificSignificance!.map((x) => x)),
        "travel_advisory": travelAdvisory == null
            ? []
            : List<dynamic>.from(travelAdvisory!.map((x) => x)),
        "destination_highlights": destinationHighlights,
        "culinary_significance": culinarySignificance,
        "performance_statistics": performanceStatistics == null
            ? []
            : List<dynamic>.from(performanceStatistics!.map((x) => x)),
        "league_standings": leagueStandings,
        "diy_tips": diyTips,
        "design_principles": designPrinciples,
        "user_experience_impact": userExperienceImpact,
        "gameplay_mechanics": gameplayMechanics == null
            ? []
            : List<dynamic>.from(gameplayMechanics!.map((x) => x)),
        "industry_impact": industryImpact == null
            ? []
            : List<dynamic>.from(industryImpact!.map((x) => x)),
        "technical_specifications": technicalSpecifications,
        "articles":
            articles == null ? [] : List<dynamic>.from(articles!.map((x) => x.toJson())),
        "domains":
            domains == null ? [] : List<dynamic>.from(domains!.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => _$props;
}

@autoequal
class Article extends Equatable {
  final String? title;
  final String? link;
  final String? domain;
  final DateTime? date;
  final String? image;
  final String? imageCaption;

  Article({this.title, this.link, this.domain, this.date, this.image, this.imageCaption});

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"],
        link: json["link"],
        domain: json["domain"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        image: json["image"],
        imageCaption: json["image_caption"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "domain": domain,
        "date": date?.toIso8601String(),
        "image": image,
        "image_caption": imageCaption,
      };

  @override
  // TODO: implement props
  List<Object?> get props => _$props;
}

@autoequal
class Domain extends Equatable {
  final String? name;
  final String? favicon;

  Domain({this.name, this.favicon});

  factory Domain.fromJson(Map<String, dynamic> json) =>
      Domain(name: json["name"], favicon: json["favicon"]);

  Map<String, dynamic> toJson() => {"name": name, "favicon": favicon};

  @override
  // TODO: implement props
  List<Object?> get props => _$props;
}

@autoequal
class Perspective extends Equatable {
  final String? text;
  final List<Source>? sources;

  Perspective({this.text, this.sources});

  factory Perspective.fromJson(Map<String, dynamic> json) => Perspective(
        text: json["text"],
        sources: json["sources"] == null
            ? []
            : List<Source>.from(json["sources"]!.map((x) => Source.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "sources":
            sources == null ? [] : List<dynamic>.from(sources!.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => _$props;
}

@autoequal
class Source extends Equatable {
  final String? name;
  final String? url;

  Source({this.name, this.url});

  factory Source.fromJson(Map<String, dynamic> json) =>
      Source(name: json["name"], url: json["url"]);

  Map<String, dynamic> toJson() => {"name": name, "url": url};

  @override
  // TODO: implement props
  List<Object?> get props => _$props;
}
