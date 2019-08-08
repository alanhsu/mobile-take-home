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
        nameLabel.text = viewModel.name
        let status = CharacterManager.sharedInstance.status(of: viewModel.character)
        let statusColor: UIColor = status == "Dead" ? .red : .black
        statusLabel.text = status
        statusLabel.textColor = statusColor
    }
}
