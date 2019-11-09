//
//  BookmarksViewController.swift
//  foursquare
//
//  Created by Sam Roman on 11/4/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {
    
    
    var bookmarks = [Bookmark](){
        didSet{
            bookmarkCV.reloadData()
        }
    }
    

    @IBOutlet weak var bookmarkCV: UICollectionView!
    
    
    
    private func loadBookmarks(){
        do {
            bookmarks = try BookmarkPersistenceHelper.manager.getBookmarks()
        }
        catch {
            return
        }
    }
    override func viewDidLoad() {
        bookmarkCV.delegate = self
        bookmarkCV.dataSource = self
        loadBookmarks()
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadBookmarks()
    }


}

extension BookmarksViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookmarkCell", for: indexPath) as! BookmarkCollectionViewCell
        cell.layer.cornerRadius = 10
        cell.collectionName.text = bookmarks[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 194, height: 228)
    }
    
    
}
