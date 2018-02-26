//
//  APITickerChart.swift
//  tickerchart
//
//  Created by Heema Boss on 2/26/18.
//  Copyright © 2018 Heema Boss. All rights reserved.
//

import Foundation

open class APITickerChart
{
    static let SERVER_URL = "http://tickerchart.com/interview/"

    static let Company = SERVER_URL + "company-details.json"
    static let Marketwatch = SERVER_URL + "marketwatch.json"
    static let General = SERVER_URL + "general-index.json"

}
