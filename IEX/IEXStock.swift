//
//  Copyright © 2020 Jackson Utsch.
//
//  Licensed under the MIT license.
//

// MARK: IEX Core Data Stock Prices
// Documentation - https://iexcloud.io/docs/api/#core-data

// Optionals used because documentation is unclear of possible values, more fault tolerant
// TODO: change some types, ex: doubles to int in places
// TODO: flesh out query parameters

import Foundation

extension IEX {

    /// docs - https://iexcloud.io/docs/api/#book
    public struct Book: Codable {
        let quote: Quote?
        let bids: [BidAsk]?
        let asks: [BidAsk]?
        let trades: [Trade]?
        let systemEvent: SystemEvent?
    }

    /// docs - https://iexcloud.io/docs/api/#delayed-quote
    public struct DelayedQuote: Codable {
        let symbol: String?
        let delayedPrice: Double?
        let high: Double?
        let low: Double?
        let delayedSize: Double?
        let delayedPriceTime: Double?
        let totalVolume: Double?
        let processedTime: Double?
    }

    /// docs - https://iexcloud.io/docs/api/#extended-hours-quote
    // MARK: Extended Hours Quote = Quote

    /// docs - https://iexcloud.io/docs/api/#historical-prices
    public struct HistoricalPrice: Codable {
        let date: String?
        let high: Double?
        let low: Double?
        let volume: Double?
        let open: Double?
        let close: Double?
        let uHigh: Double?
        let uLow: Double?
        let uVolume: Double?
        let uOpen: Double?
        let uClose: Double?
        let changeOverTime: Double?
        let label: String?
        let change: Double?
        let changePercent: Double?
    }

    /// docs - https://iexcloud.io/docs/api/#historical-prices
    public struct HistoricalPricesDynamic: Codable {
        let range: String?
        let data: [HistoricalPrice]?
    }

    /// docs - https://iexcloud.io/docs/api/#intraday-prices
    public struct IntradayPrice: Codable {
        let date: String?
        let minute: String?
        let marketAverage: Double?
        let marketNotation: Double?
        let marketNumberOfTrades: Double?
        let marketOpen: Double?
        let marketClose: Double?
        let marketHigh: Double?
        let marketLow: Double?
        let marketVolume: Double?
        let marketChangeOverTime: Double?
        let label: String?
        let average: Double?
        let notional: Double?
        let numberOfTrades: Double?
        let high: Double?
        let low: Double?
        let volume: Double?
        let open: Double?
        let close: Double?
    }

    /// docs - https://iexcloud.io/docs/api/#largest-trades
    public struct LargestTrade: Codable {
        let price: Double?
        let size: Double?
        let time: Double?
        let timeLabel: String?
        let venue: String?
        let venueName: String?
    }

    /// docs - https://iexcloud.io/docs/api/#ohlc
    public struct OHLC: Codable {
        let open: PricePoint?
        let close: PricePoint?
        let high: Double?
        let low: Double?
    }

    /// docs - https://iexcloud.io/docs/api/#previous-day-price
    public struct PreviousDayPrice: Codable {
        let symbol: String?
        let date: String?
        let high: Double?
        let low: Double?
        let volume: Double?
        let open: Double?
        let close: Double?
        let uHigh: Double?
        let uLow: Double?
        let uVolume: Double?
        let uOpen: Double?
        let uClose: Double?
        let changeOverTime: Double?
        let label: String?
        let change: Double?
        let changePercent: Double?
    }

    /// docs - https://iexcloud.io/docs/api/#quote
    public struct Quote: Codable {
        let latestPrice: Double?
        let latestVolume: Double?
        let latestUpdate: Double?
        let latestTime: String?
        let calculationPrice: String?
        let latestSource: String?
        let change: Double?
        let changePercent: Double?
        let volume: Double?
        let open: Double?
        let openTime: Double?
        let close: Double?
        let closeTime: Double?
        let previousClose: Double?
        let previousVolume: Double?
        let high: Double?
        let low: Double?
        let extendedPrice: Double?
        let extendedChange: Double?
        let extendedChangePercent: Double?
        let extendedPriceTime: Double?
        let delayedPrice: Double?
        let delayedPriceTime: Double?
        let oddLotDelayedPrice: Double?
        let oddLotDelayedPriceTime: Double?
        let marketCap: Double?
        let avgTotalVolume: Double?
        let week52High: Double?
        let week52Low: Double?
        let ytdChange: Double?
        let iexRealtimePrice: Double?
        let iexRealtimeSize: Double?
        let iexLastUpdated: Double?
        let iexMarketPercent: Double?
        let iexVolume: Double?
        let iexBidPrice: Double?
        let iexBidSize: Double?
        let iexAskSize: Double?
        let symbol: String?
        let companyName: String?
        let primaryExchange: String?
        let peRatio: Double?
        let lastTradeTime: Double?
        let isUSMarketOpen: Bool?
    }

    /// docs - https://iexcloud.io/docs/api/#volume-by-venue
    public struct VolumeByVenue: Codable {
        let volume: Double?
        let venue: String?
        let venueName: String?
        let date: String?
        let marketPercent: Double?
    }
    
}

extension IEX {
    
    public func book(symbol: String) -> Book? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "book" + "?token=\(apiKey)"
        return getEndpoint(path, as: Book.self)
    }
    
    public func delayedQuote(symbol: String, queryParams: String?) -> DelayedQuote? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "delayed-quote" + "?token=\(apiKey)" & (queryParams ?? "")
        return getEndpoint(path, as: DelayedQuote.self)
    }
    
    /// docs - https://iexcloud.io/docs/api/#extended-hours-quote
    // MARK: Extended Hours Quote = Quote
    
    /// Range.dynamic ignores additional range object from iex for simplicity sake
    public func historicalPrices(symbol: String, range: Range) -> [HistoricalPrice]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "chart" / range.rawValue + "?token=\(apiKey)"
        if range == .dynamic {
            let dynamic = getEndpoint(path, as: HistoricalPricesDynamic.self)
            return dynamic?.data
        } else {
            return getEndpoint(path, as: [HistoricalPrice].self)
        }
    }
    
    public func historicalPrices(symbol: String, date: String) -> [HistoricalPrice]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "chart" / "date" / date + "?token=\(apiKey)"
        return getEndpoint(path, as: [HistoricalPrice].self)
    }
    
    public func intradayPrices(symbol: String, queryParams: String?) -> [IntradayPrice]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "intraday-prices" + "?token=\(apiKey)" & (queryParams ?? "")
        return getEndpoint(path, as: [IntradayPrice].self)
    }
    
    public func largestTrades(symbol: String, params: String?) -> [LargestTrade]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "largest-trades" + "?token=\(apiKey)"
        return getEndpoint(path, as: [LargestTrade].self)
    }
    
    public func ohlc(symbol: String) -> OHLC? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "ohlc" + "?token=\(apiKey)"
        return getEndpoint(path, as: OHLC.self)
    }
    
    // could add market option, its costly.. ~17k messages
    public func previousDayPrice(symbol: String) -> PreviousDayPrice? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "previous" + "?token=\(apiKey)"
        return getEndpoint(path, as: PreviousDayPrice.self)
    }
    
    public func priceOnly(symbol: String) -> Double? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "price" + "?token=\(apiKey)"
        return getEndpoint(path, as: Double.self)
    }
    
    public func quote(symbol: String) -> Quote? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "largest-trades" + "?token=\(apiKey)"
        return getEndpoint(path, as: Quote.self)
    }
    
    public func volumeByVenue(symbol: String) -> [VolumeByVenue]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "volume-by-venue" + "?token=\(apiKey)"
        return getEndpoint(path, as: [VolumeByVenue].self)
    }
}
