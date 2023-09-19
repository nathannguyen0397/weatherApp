//
//  RestAPIService.swift
//  WeatherApp
//
//  Created by Ngoc Nguyen on 8/31/23.
//

import Foundation
import Combine

enum APIError: Error{
    case invalidResponse(String)
    case badServerResponse
    case invalidURL
}

class RestAPIService{
    func getDataJSONPublisher<T:Codable> (url: URL, type: T.Type, headers: [String: String]? = nil) -> AnyPublisher<T, any Error>{
        //Make request
        var request = URLRequest(url: url)
        if let headers = headers{
            for(key, value) in headers{
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        //Send request
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                guard let httpResponse = response as? HTTPURLResponse else {throw APIError.badServerResponse}
                guard 200...299 ~= httpResponse.statusCode else {throw APIError.invalidResponse("Status code: \(httpResponse.statusCode)")}
//                print("\(String(data: data, encoding: .utf8)!)")
//                do {
//                    let object = try JSONDecoder().decode(T.self, from: data)
//                } catch {
//                    print("Decoding error: \(error)")
//                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


import SwiftUI
struct Testing : View{
    @StateObject var viewModelSearch = ViewModelWeather()
    var body: some View{
        VStack{
        }
        .onAppear(){
            viewModelSearch.fetchCities("San Jose")
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
