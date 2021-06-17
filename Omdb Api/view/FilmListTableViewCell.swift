//
//  FilmListTableViewCell.swift
//  Omdb Api
//
//  Created by AbdulKadir Akkaş on 16.06.2021.
//

import UIKit

class FilmListTableViewCell: UITableViewCell {
    @IBOutlet weak var filmNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
