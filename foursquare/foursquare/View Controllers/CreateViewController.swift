//
//  CreateViewController.swift
//  foursquare
//
//  Created by Sam Roman on 11/9/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    
    var bookmarks = [Bookmark]()
    
    var selectedVenue: Venue?

    @IBOutlet weak var createTextField: UITextField!
    
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var createCV: UICollectionView!

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    
        
        
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        guard createTextField.text != "" && selectedVenue != nil else { return }
        
        createNewBookMark()
        dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func createNewBookMark(){
        do {
            let new = Bookmark(image: nil , name: createTextField.text ?? "", venues: [selectedVenue!])
            self.bookmarks.append(new)
            let updated = bookmarks
            try BookmarkPersistenceHelper.manager.saveBookmark(newArray: updated)
            
        } catch {
            return
        }
    }
    
    private func loadBookmarks(){
        do {
            let bm = try BookmarkPersistenceHelper.manager.getBookmarks()
            bookmarks = bm
        } catch {
            return
        }
    }
    
    
    
    override func viewDidLoad() {
        createCV.delegate = self
        createCV.dataSource = self
        loadBookmarks()
        super.viewDidLoad()
    }

    
    

}


extension CreateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = createCV.dequeueReusableCell(withReuseIdentifier: "createCell", for: indexPath) as! CreateCollectionViewCell
        let bookmark = bookmarks[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.collectionName.text = bookmark.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 184, height: 185)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bookmarks[indexPath.row].venues!.append(selectedVenue!)
        do {
            try BookmarkPersistenceHelper.manager.saveBookmark(newArray: bookmarks)
            self.dismiss(animated: true, completion: nil)
            navigationController?.popToRootViewController(animated: true)
        } catch {
            return
        }
        
    }
}
