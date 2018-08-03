//
//  ViewController.swift
//  WhereIsMyRick
//
//  Created by Denis Bogomolov on 02/08/2018.
//  Copyright © 2018 showmax. All rights reserved.
//

import UIKit
import Result

class ViewController: UIViewController {

    enum State {
        case idle
        case empty
        case data([Character])
        case error(Error)
    }

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!

    let engine = SearchEngine()
    lazy var collectionManager: CollectionViewManager = {
        let collectionManager = CollectionViewManager(collectionView)
        collectionManager.onItemSelect = { [weak self] in
            self?.present(DetailViewController(of: $0), animated: true, completion: nil)
        }
        return collectionManager
    }()
    var state: State = .idle {
        didSet {
            DispatchQueue.main.async {
                self.translate(to: self.state)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        engine.onNewData = { [weak self] data in
            switch data {
            case .success(let chars):
                self?.state =  chars.isEmpty ? .empty : .data(chars)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        state = .idle
    }

    func translate(to state: State) {
        switch state {
        case .idle:
            collectionView.isHidden = true
            errorView.isHidden = true
            emptyView.isHidden = true

        case .empty:
            collectionView.isHidden = true
            errorView.isHidden = true
            emptyView.isHidden = false

        case .error(let error):
            collectionView.isHidden = true
            errorView.isHidden = false
            errorLabel.text = "\(error)"
            emptyView.isHidden = true

        case .data(let chars):
            collectionView.isHidden = false
            collectionManager.data = chars
            errorView.isHidden = true
            emptyView.isHidden = true
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        engine.finishSearch()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        engine.search(for: searchText)
    }
}
