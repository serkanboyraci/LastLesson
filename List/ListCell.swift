//
//  TableViewCell.swift
//  LastLesson
//
//  Created by Ali serkan Boyracı  on 30.01.2023.
//

import UIKit
import Kingfisher

class ListCell: UITableViewCell {
    
    
  
    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameValueLabel: UILabel!
    @IBOutlet private weak var genderTitleLabel: UILabel!
    @IBOutlet private weak var genderValueLabel: UIView!
    @IBOutlet private weak var statusTitleLabel: UILabel!
    @IBOutlet private weak var statusVelueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func configure(with model: ListCellModel) {
        contentImageView.kf.setImage(with: URL.init(string: model.imageURL))
        nameValueLabel.text = model.name
        genderValueLabel.text = model.gender
        statusValueLabel.text = model.status
    }
}

private extension ListCell {
    
    private func setupUI() {
        nameTitleLabel.text = "Name"
        genderTitleLabel.text = "Gender"
        statusTitleLabel.text = "Status"
    }
}

struct ListCellModel {
    let imageURL: String
    let name: String
    let status: String
    let gender: String
}
