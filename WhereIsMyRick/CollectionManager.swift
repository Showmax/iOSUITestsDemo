//
//  CollectionManager.swift
//  WhereIsMyRick
//
//  Created by Denis Bogomolov on 02/08/2018.
//  Copyright © 2018 showmax. All rights reserved.
//

import UIKit

class CollectionViewManager: NSObject {

    typealias Handler = (Character) -> Void

    var onItemSelect: Handler?
    var data: [Character] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    let collectionView: UICollectionView

    init(_ collection: UICollectionView) {
        collectionView = collection
        super.init()
        prepare(collection)
    }

    func prepare(_ collection: UICollectionView) {
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "CharacterCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell
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
