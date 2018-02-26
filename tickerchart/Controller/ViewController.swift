//
//  ViewController.swift
//  tickerchart
//
//  Created by Heema Boss on 2/26/18.
//  Copyright © 2018 Heema Boss. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class ViewController: UIViewController {

    //company
    @IBOutlet weak var Symbol: UILabel!
    @IBOutlet weak var trades_Count: UILabel!
    @IBOutlet weak var Volume: UILabel!
    @IBOutlet weak var company_Name: UILabel!
    @IBOutlet weak var Low: UILabel!
    @IBOutlet weak var High: UILabel!
    @IBOutlet weak var amount: UILabel!
    //company
    
    //general
    @IBOutlet weak var Trades: UILabel!
    @IBOutlet weak var VolumeGn: UILabel!
    @IBOutlet weak var amount1: UILabel!
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var FixedC: UILabel!
    @IBOutlet weak var Losing: UILabel!
    @IBOutlet weak var Winning: UILabel!
    //general
    
    @IBOutlet weak var tableViewMarketwatch: UITableView!
    var http = HttpHelper()
    var company = Company()
    var marketwatch = [Marketwatch()]
    var general = General()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMarketwatch.delegate = self
        tableViewMarketwatch.dataSource = self
        http.delegate = self
        tableViewMarketwatch.register(UINib.init(nibName: "MarketWatchTableViewCell", bundle: nil), forCellReuseIdentifier: "MarketWatchTableViewCell")
            getCompany()
            getCompanyApi()
            getGeneralApi()
        
    }
    
    
    private func getCompanyApi(){
        
        Symbol.text = String(self.company.symbol)
        trades_Count.text = String( company.trades_count)
        company_Name.text = company.company_name
        Low.text = String (company.low)
        High.text = String (company.high)
        Volume.text = String (company.volume)
        amount.text = String (company.amount)
    }
    private func getGeneralApi(){

        Trades.text = String( general.trades)
        VolumeGn.text = String( general.volume)
        amount1.text = String( general.amount)
        Name.text = String( general.name)
        FixedC.text = String( general.companies1.fixed)
        Losing.text = String( general.companies1.losing)
        Winning.text = String( general.companies1.winning)
        
    }
    
   private func getCompany()  {
    let prametrs = ["":""]
    http.Get(url: APITickerChart.Company , parameters: prametrs, Tag: 1, headers: ["":""])
    }
    
    private func getGeneral()  {
        let prametrs = ["":""]
        http.Get(url: APITickerChart.General , parameters: prametrs, Tag: 2, headers: ["":""])
    }
    
    private func getMarketwatch()  {
        let prametrs = ["":""]
        http.Get(url: APITickerChart.Marketwatch , parameters: prametrs, Tag: 3, headers: ["":""])
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return marketwatch.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMarketwatch.dequeueReusableCell(withIdentifier: "MarketWatchTableViewCell", for: indexPath) as! MarketWatchTableViewCell
  cell.Name.text = String(marketwatch[indexPath.row].name)
        cell.Ask_Price.text = String(marketwatch[indexPath.row].ask_price)
        cell.Bid_Price.text = String(marketwatch[indexPath.row].bid_price)
        cell.High_Price.text = String(marketwatch[indexPath.row].high_price)
        cell.Last_Price.text = String(marketwatch[indexPath.row].last_price)
        return cell
    }
}

extension ViewController: HttpHelperDelegate {
    
    func receivedResponse(dictResponse: Any, Tag: Int) {
        
        print(dictResponse)
        if Tag == 1 {
            let dictResponse = dictResponse as! NSDictionary
            company = Company(JSON: dictResponse as! [String: Any])!
            getCompanyApi()

            getGeneral()
            
        }else if Tag == 2 {
        
            let dictResponse = dictResponse as! NSDictionary
             general = General(JSON: dictResponse as! [String: Any])!
            getGeneralApi()

            getMarketwatch()
        
        } else if Tag == 3 {
        let dictResponse = dictResponse as! NSArray
            marketwatch = Mapper<Marketwatch>().mapArray(JSONArray: dictResponse as! [[String : Any]])
            tableViewMarketwatch.reloadData()
            return
           
        }
        tableViewMarketwatch.reloadData()

    }
    
    func receivedErrorWithStatusCode(statusCode: Int) {
        print(statusCode)
    }
    
    func retryResponse(numberOfrequest: Int) {
        
    }
   
}




