//
//  MealManagerNetwork.swift
//  FetchChallenge_FredyCamas_Spring2024
//
//  Created by Fredy Camas on 1/3/24.
//

import Foundation

enum MealManagerError: Error {
    case clientError
    case serverError
    case decodeError
    case dataError
    case invalidUrl
}

class MealManagerNetwork {

    static let shared = MealManagerNetwork()

    private let baseURL = "https://themealdb.com/api/json/v1/1/"

    func fetchData(category: String, completion: @escaping (Result<[MealLocalData], MealManagerError>) -> Void) {
        let mealURL = "\(baseURL)filter.php?c=\(category)"
        performRequest(urlString: mealURL, completion: completion)
    }

    private func performRequest(urlString: String, completion: @escaping (Result<[MealLocalData], MealManagerError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.clientError))
                print("Error: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError))
                return
            }

            guard let data = data else {
                completion(.failure(.dataError))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(MealDataNetwork.self, from: data)
                let mealLocalData = decodedData.meals.map { MealLocalData(meals: $0) }
                completion(.success(mealLocalData))
            } catch {
                completion(.failure(.decodeError))
            }
        }

        task.resume()
    }
}
