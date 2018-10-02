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

import UIKit
import Nuke

class CollectionViewManager: NSObject {

    typealias Handler = (Movie) -> Void

    var onItemSelect: Handler?
    var data: [Movie] = [] {
        didSet {

            collectionView.reloadData()
        }
    }

    let preheater = Nuke.ImagePreheater()
    let collectionView: UICollectionView

    init(_ collection: UICollectionView) {
        collectionView = collection
        collectionView.isPrefetchingEnabled = true
        super.init()
        prepare(collection)
    }

    func prepare(_ collection: UICollectionView) {
        collection.dataSource = self
        collection.delegate = self
        collection.prefetchDataSource = self
        collection.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
        guard let fl = collection.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let spacing: CGFloat = 20
        let width = (UIScreen.main.bounds.width - spacing) / 2
        let height = width + 20
        fl.itemSize = CGSize(width: width, height: height)
        fl.minimumInteritemSpacing = spacing
        fl.minimumLineSpacing = spacing
    }
}

extension CollectionViewManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setup(with: data[indexPath.item])
        return cell
    }
}

extension CollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        onItemSelect?(data[indexPath.item])
    }
}

extension CollectionViewManager: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
            cell.setup(with: data[indexPath.item])
        }
    }
}
