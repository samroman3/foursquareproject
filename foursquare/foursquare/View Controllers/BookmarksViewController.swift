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
    
    
    @IBAction func addNewBookMark(_ sender: UIButton) {
        let alertvc = UIAlertController(title: "Add New Collection", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive) { (action) in
            guard alertvc.textFields![0].text != "" else {return}
            do {
                let new = Bookmark(image: nil , name: alertvc.textFields?[0].text ?? "", venues: [Venue]())
                self.bookmarks.append(new)
                let updated = self.bookmarks
                try BookmarkPersistenceHelper.manager.saveBookmark(newArray: updated)
                self.loadBookmarks()
                self.bookmarkCV.reloadData()
                
            } catch {
                return
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertvc.addTextField { (return) in
            
        }
        alertvc.addAction(ok)
        alertvc.addAction(cancel)
        present(alertvc,animated: true)
    }
    
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let venue = bookmarks[indexPath.row].venues
        let listVC = storyboard?.instantiateViewController(identifier: "listVC") as! ListViewController
        listVC.items = venue ?? [Venue]()
        present(listVC,animated: true)
    }
    
}
