//
//  SearchByParamClient.swift
//  Hearthstone Beginners Guide
//
//  Created by Schubert David Rodríguez on 17/12/15.
//  Copyright © 2015 Schubert David Rodríguez. All rights reserved.
//

import Foundation


class SearchByParameterClient {
 
    
    static func searchCardsByParameter(parameter: String, query: String?, location: Location,completionHandler: ([Card]?, NSError?) -> Void) -> NSURLSessionDataTask? {
        //Check veracity for hero selection
        guard let parameterQuery:String = parameter else {
            return nil;
        }
        //Check veracity for location selection
        guard let locationQuery:Location = location else {
            return nil;
        }
        //Check veracity for hero selection
        guard let parameterValueQuery:String = query else {
            return nil;
        }
        //Build a URL to connect with the server
        guard let url = NSURL(string: ParameterConstants.HEARTHSTONE_API_URI + Endpoints.HEARTHSTONE_API_CLASS_CARDS.rawValue + parameterQuery + parameterValueQuery +
            //ParameterConstants.HEARTHSTONE_API_PARAMETER_CONNECTOR_AMPERSAND +
            ParameterConstants.HEARTHSTONE_API_PARAMETER_LOCALE_AND + locationQuery.rawValue) else{
            return nil;
        }
        //Add headers for session
        let headers = [ParameterConstants.KEY_HEADER_HEARTHSTONE_API: ParameterConstants.VALUE_HEADER_HEARTSTONE_API]
        //Create a configuration with default data
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration();
        //Add Headers for session configurations (Dictionary pair/value)
        sessionConfiguration.HTTPAdditionalHeaders = headers;
        //Create session with session configiguration
        let session = NSURLSession(configuration: sessionConfiguration);
        //Resume the task to wait for asynchronuos methods
        let sessionTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            let cards = CardUtil.parseCardsBySet(data);
            completionHandler(cards, error);
        }
        
        //Resume the task to waiti for asynchronuos methods
        sessionTask.resume();
        
        return sessionTask;
    }

    
}