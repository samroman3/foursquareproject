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
        guard createTextField.text != "" && selectedVenue != nil else { return }
        createNewBookMark()
        
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
    
    
    
    override func viewDidLoad() {
        createCV.delegate = self
        createCV.dataSource = self
        super.viewDidLoad()
    }

    
    

}


extension CreateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = createCV.dequeueReusableCell(withReuseIdentifier: "createCell", for: indexPath)
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
}
