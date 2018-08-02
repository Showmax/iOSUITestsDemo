//
//  SearchEngine.swift
//  WhereIsMyRick
//
//  Created by Denis Bogomolov on 02/08/2018.
//  Copyright © 2018 showmax. All rights reserved.
//

import Foundation
import Result

class SearchEngine {

    enum Error: Swift.Error {
        case networkError
        case parsingError
        case empty
    }

    typealias Handler = (Result<[Character], Error>) -> Void
    var onNewData: Handler?

    private var currentTask: URLSessionDataTask?
    private var currentQuery: String?
    private let session = URLSession.shared

    func search(for text: String) {
        let queryEmpty = text.isEmpty
        let loadingSameQuery = currentQuery == text && currentTask != nil
        let shouldPerformSearch = !loadingSameQuery && !queryEmpty
        guard shouldPerformSearch else { return }

        finishSearch()
        currentQuery = text
        currentTask = session.dataTask(with: url(for: text)) { [weak self] data, _, error in
            guard let me = self else { return }
            guard (error as NSError?)?.code != NSURLErrorCancelled else { return }
            if let data = data {
                me.onNewData?(me.parse(from: data))
            } else {
                print("Error: \(error)")
                me.onNewData?(.failure(.networkError))
            }
            me.finishSearch()
        }
        currentTask?.resume()
    }

    func finishSearch() {
        currentTask?.cancel()
        currentTask = nil
        currentQuery = nil
    }

    private func url(for query: String) -> URL {
        return URL(string: "https://rickandmortyapi.com/api/character/?name=\(query)")!
    }

    private func parse(from data: Data) -> Result<[Character], Error> {
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return .success(response.results ?? [])
        } catch {
            return .failure(.parsingError)
        }
    }
}
