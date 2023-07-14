import Foundation

// MARK: - NewSentimentModel
struct NewSentimentModel: Codable {
    let items, sentimentScoreDefinition, relevanceScoreDefinition: String
    let feed: [Feed]

    enum CodingKeys: String, CodingKey {
        case items
        case sentimentScoreDefinition = "sentiment_score_definition"
        case relevanceScoreDefinition = "relevance_score_definition"
        case feed
    }
}

// MARK: - Feed
struct Feed: Codable {
    let title: String
    let url: String
    let timePublished: String
    let authors: [String]
    let summary: String
    let bannerImage: String
    let source, categoryWithinSource, sourceDomain: String
    let topics: [Topic]
    let overallSentimentScore: Double
    let overallSentimentLabel: SentimentLabel
    let tickerSentiment: [TickerSentiment]

    enum CodingKeys: String, CodingKey {
        case title, url
        case timePublished = "time_published"
        case authors, summary
        case bannerImage = "banner_image"
        case source
        case categoryWithinSource = "category_within_source"
        case sourceDomain = "source_domain"
        case topics
        case overallSentimentScore = "overall_sentiment_score"
        case overallSentimentLabel = "overall_sentiment_label"
        case tickerSentiment = "ticker_sentiment"
    }
}

enum SentimentLabel: String, Codable {
    case bearish = "Bearish"
    case bullish = "Bullish"
    case neutral = "Neutral"
    case somewhatBearish = "Somewhat-Bearish"
    case somewhatBullish = "Somewhat-Bullish"
}

// MARK: - TickerSentiment
struct TickerSentiment: Codable {
    let ticker, relevanceScore, tickerSentimentScore: String
    let tickerSentimentLabel: SentimentLabel

    enum CodingKeys: String, CodingKey {
        case ticker
        case relevanceScore = "relevance_score"
        case tickerSentimentScore = "ticker_sentiment_score"
        case tickerSentimentLabel = "ticker_sentiment_label"
    }
}

// MARK: - Topic
struct Topic: Codable {
    let topic, relevanceScore: String

    enum CodingKeys: String, CodingKey {
        case topic
        case relevanceScore = "relevance_score"
    }
}
