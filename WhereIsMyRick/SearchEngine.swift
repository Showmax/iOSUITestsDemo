// Copyright since 2015 Showmax s.r.o.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
        let escaped = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: "https://rickandmortyapi.com/api/character/?name=\(escaped)")!
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
