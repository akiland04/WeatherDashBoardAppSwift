//
//  HttpService.swift
//  WeatherDashboardTemplate
//
//  Created by Akilan Dananjayan on 2026-06-22.
//

import Foundation

class HttpService {
    func get<T: Decodable>(url: String) async throws -> T{
        guard let url = URL(string: url) else{
            throw WeatherMapError.invalidURL(url)
        }
        
        let data: Data
        let response: URLResponse
        
        do{
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw WeatherMapError.networkError(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherMapError.invalidResponse(statusCode: -1)
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            if(httpResponse.statusCode == 404) {
                throw WeatherMapError.missingData(message: "Data not found")
            }
            throw WeatherMapError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        do{
            print(data)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw WeatherMapError.decodingError(error)
        }
    }
}
