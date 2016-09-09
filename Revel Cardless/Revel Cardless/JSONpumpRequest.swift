//
//  JSONpumpRequest.swift
//  Revel Cardless
//
//  Created by Sanjay Shrestha on 9/9/16.
//  Copyright © 2016 Stmarys. All rights reserved.
//

import Foundation

class JSONpumpParser{
    
    func runJSONparser() {
        sendRequest("https://team5-hackathon.revelup.com/resources/Pumps/", parameters: ["api_key":"d5c40495e6c744f79c999722e25764fb","api_secret":"038b36255e114458adc02ca87602c7a8b0219cf8aef2461faa977b4107454be6"], completionHandler: {a,b,c in
            
            let data = a!
            
            do {
                let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    self.readJSONobject(dictionary)
                }
            } catch {
                print("error") //exception handling goes here, "error" for now; need sophisticated exception handling implementation
            }
            
        })

    }
    
    func sendRequest(url: String, parameters: [String: AnyObject], completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionTask {
        let parameterString = parameters.stringFromHttpParameters()
        let requestURL = NSURL(string:"\(url)?\(parameterString)")!
        
        let request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        //print (requestURL.absoluteString)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:completionHandler)
        task.resume()
        
        return task
    }
    
    func readJSONobject(object: [String: AnyObject]) { //break into smaller dictionaries
        //print(object)
        //guard let pumpNumber = object["name"] as? String else { print("error"); return }
        //print(object["objects"]!["created"])
        let newobject = object["objects"] as! [[String: AnyObject]]
        for pumps in newobject {
            print(pumps["name"])
            print(pumps["external_id"])
            print(pumps["number"])
            print("\n")
        }
        //print(newobject[0])
    }
    
}

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}