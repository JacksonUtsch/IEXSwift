//
//  Copyright © 2020 Jackson Utsch.
//
//  Licensed under the MIT license.
//

import Foundation

//
// MARK: structures indirectly used to read data from IEX
//

extension IEX {
    
    public struct BidAsk: Codable {
        let price: Double?
        let size: Double?
        let timeStamp: Double?
    }

    public struct Trade: Codable {
        let price: Double?
        let size: Double?
        let tradeId: Double?
        let isISO: Bool?
        let isOddLot: Bool?
        let isOutsideRegularHours: Bool?
        let isSinglePriceCross: Bool?
        let isTradeThroughExempt: Bool?
        let timeStamp: Double?
    }

    public struct SystemEvent: Codable {
        let systemEvent: String?
        let timestamp: Double?
    }

    public struct PricePoint: Codable {
        let price: Double?
        let time: Double?
    }

}

//
// MARK: IEX parameters
//

extension IEX {
    
    public enum Range: String, RawRepresentable {
        case max, ytd, date, dynamic
        case fiveYear = "5y"
        case twoYear = "2y"
        case oneYear = "1y"
        case sixMonth = "6m"
        case threeMonth = "3m"
        case oneMonth = "1m"
        case oneMMonth = "1mm"
        case fiveDay = "5d"
        case fiveMDays = "5dm"
    }
    
}
