//
//  HttpHelper.swift
//  tickerchart
//
//  Created by Heema Boss on 2/26/18.
//  Copyright © 2018 Heema Boss. All rights reserved.
//

import Alamofire
import Foundation

protocol HttpHelperDelegate {
    func receivedResponse(dictResponse:Any,Tag:Int)
    func receivedErrorWithStatusCode(statusCode:Int)
    func retryResponse(numberOfrequest:Int)
}

class HttpHelper{
    
    var delegate: HttpHelperDelegate?
    
    var header:HTTPHeaders?
    var numberOfrequest = 0
    
    public  func Get(url:String,parameters:Parameters=[:],Tag:Int , headers:HTTPHeaders){
        request(url: url, method: .get, parameters: parameters, tag: Tag,header: headers)
    }
    
    
    private func request(url:String,method:HTTPMethod,parameters:Parameters=[:],tag:Int,header:HTTPHeaders?){
        
        Alamofire.request(url, method: method,parameters: parameters,headers:header)
            .responseJSON { (response) in
                if response.response == nil {
                    self.delegate?.receivedErrorWithStatusCode(statusCode: statusCode.NOT_FOUND)
                    return
                }
                if response.response!.statusCode == statusCode.OK  || response.response!.statusCode == statusCode.CREATED
                    || response.response!.statusCode == statusCode.NO_CONTENT || response.response!.statusCode == statusCode.ACCEPTED{
                    if let JSON = response.result.value {
                        self.delegate?.receivedResponse(dictResponse: JSON,Tag: tag)
                    }
                }else if response.response!.statusCode == statusCode.BAD_GATEWAY || response.response!.statusCode == statusCode.SERVICE_UNAVAILABLE{
                    let when = DispatchTime.now() + Double(0.1 * Double(self.numberOfrequest))
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.delegate?.retryResponse(numberOfrequest: self.numberOfrequest)
                        self.numberOfrequest  = self.numberOfrequest +  1
                    }
                }else{
                    self.delegate?.receivedErrorWithStatusCode(statusCode: response.response!.statusCode)
                }
        }
    }
    
}
enum statusCode {
    
    static let NOT_FOUND = 404
    static let OK = 200
    static let BAD_GATEWAY = 502
    static let SERVICE_UNAVAILABLE = 503
    static let NO_CONTENT = 204
    static let ACCEPTED = 0
    static let CREATED = 0
    
    
}


