//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Alan Hsu on 2019-08-07.
//  Copyright © 2019 Alan Hsu. All rights reserved.
//

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var characterObservation: NSKeyValueObservation?
    
    var viewModel: CharacterCellViewModel? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        guard let viewModel = viewModel else { return }
        if let imageURL = viewModel.imageURL {
            let imageData = try! Data(contentsOf: imageURL, options: .mappedIfSafe)
            characterImageView.image = UIImage(data: imageData)
        }
        
        nameLabel.text = viewModel.name
        
        let status = CharacterManager.sharedInstance.status(of: viewModel.character)
        statusLabel.text = "Status: " + status
    }
}
