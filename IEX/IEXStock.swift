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
    public struct IEXBook: Codable {
        let quote: IEXQuote?
        let bids: [IEXBidAsk]?
        let asks: [IEXBidAsk]?
        let trades: [IEXTrade]?
        let systemEvent: IEXSystemEvent?
    }

    /// docs - https://iexcloud.io/docs/api/#delayed-quote
    public struct IEXDelayedQuote: Codable {
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
    public struct IEXHistoricalPrice: Codable {
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
    public struct IEXHistoricalPricesDynamic: Codable {
        let range: String?
        let data: [IEXHistoricalPrice]?
    }

    /// docs - https://iexcloud.io/docs/api/#intraday-prices
    public struct IEXIntradayPrice: Codable {
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
    public struct IEXLargestTrade: Codable {
        let price: Double?
        let size: Double?
        let time: Double?
        let timeLabel: String?
        let venue: String?
        let venueName: String?
    }

    /// docs - https://iexcloud.io/docs/api/#ohlc
    public struct IEXOHLC: Codable {
        let open: IEXPricePoint?
        let close: IEXPricePoint?
        let high: Double?
        let low: Double?
    }

    /// docs - https://iexcloud.io/docs/api/#previous-day-price
    public struct IEXPreviousDayPrice: Codable {
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
    public struct IEXQuote: Codable {
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
    public struct IEXVolumeByVenue: Codable {
        let volume: Double?
        let venue: String?
        let venueName: String?
        let date: String?
        let marketPercent: Double?
    }
    
}

extension IEX {
    
    public func book(symbol: String) -> IEXBook? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "book" + "?token=\(apiKey)"
        return getEndpoint(path, as: IEXBook.self)
    }
    
    public func delayedQuote(symbol: String, queryParams: String?) -> IEXDelayedQuote? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "delayed-quote" + "?token=\(apiKey)" & (queryParams ?? "")
        return getEndpoint(path, as: IEXDelayedQuote.self)
    }
    
    /// docs - https://iexcloud.io/docs/api/#extended-hours-quote
    // MARK: Extended Hours Quote = Quote
    
    /// Range.dynamic ignores additional range object from iex for simplicity sake
    public func historicalPrices(symbol: String, range: Range) -> [IEXHistoricalPrice]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "chart" / range.rawValue + "?token=\(apiKey)"
        if range == .dynamic {
            let dynamic = getEndpoint(path, as: IEXHistoricalPricesDynamic.self)
            return dynamic?.data
        } else {
            return getEndpoint(path, as: [IEXHistoricalPrice].self)
        }
    }
    
    public func historicalPrices(symbol: String, date: String) -> [IEXHistoricalPrice]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "chart" / "date" / date + "?token=\(apiKey)"
        return getEndpoint(path, as: [IEXHistoricalPrice].self)
    }
    
    public func intradayPrices(symbol: String, queryParams: String?) -> [IEXIntradayPrice]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "intraday-prices" + "?token=\(apiKey)" & (queryParams ?? "")
        return getEndpoint(path, as: [IEXIntradayPrice].self)
    }
    
    public func largestTrades(symbol: String) -> [IEXLargestTrade]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "largest-trades" + "?token=\(apiKey)"
        return getEndpoint(path, as: [IEXLargestTrade].self)
    }
    
    public func ohlc(symbol: String) -> IEXOHLC? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "ohlc" + "?token=\(apiKey)"
        return getEndpoint(path, as: IEXOHLC.self)
    }
    
    // could add market option, its costly.. ~17k messages
    public func previousDayPrice(symbol: String) -> IEXPreviousDayPrice? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "previous" + "?token=\(apiKey)"
        return getEndpoint(path, as: IEXPreviousDayPrice.self)
    }
    
    public func priceOnly(symbol: String) -> Double? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "price" + "?token=\(apiKey)"
        return getEndpoint(path, as: Double.self)
    }
    
    public func quote(symbol: String) -> IEXQuote? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "largest-trades" + "?token=\(apiKey)"
        return getEndpoint(path, as: IEXQuote.self)
    }
    
    public func volumeByVenue(symbol: String) -> [IEXVolumeByVenue]? {
        let path = baseURL.rawValue / version.rawValue / "stock" / symbol / "volume-by-venue" + "?token=\(apiKey)"
        return getEndpoint(path, as: [IEXVolumeByVenue].self)
    }
}
