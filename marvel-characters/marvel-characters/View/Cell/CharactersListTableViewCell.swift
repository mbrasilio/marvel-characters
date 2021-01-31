//
//  CharactersListTableViewCell.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 28/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import UIKit

class CharactersListTableViewCell: UITableViewCell {
    // MARK: - Attributes
    public static let cellIdentifier = "CharactersListTableViewCell"
    public static let cellHeight: CGFloat = 80
    public static let cellSpacing: CGFloat = 10
    
    // MARK: - Layout Attributes
    private let cell: UIView = {
        let vw = UIView()
        vw.backgroundColor = UIColor.black
        return vw
    }()
    
    private let characterIcon = UIImageView()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let characterName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    public func setupCell(character: Character) {
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        self.characterIcon.downloadImageFrom(link: character.thumbnailURL)
        self.characterName.text = character.name.uppercased()
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.addSubview(cell)
        cell.anchor(
            top: (self.topAnchor, CharactersListTableViewCell.cellSpacing),
            left: (self.leftAnchor, 20),
            right: (self.rightAnchor, 20),
            bottom: (self.bottomAnchor, 0),
            height: CharactersListTableViewCell.cellHeight
        )
        
        cell.addSubview(characterIcon)
        characterIcon.backgroundColor = UIColor.red
        characterIcon.anchor(
            top: (cell.topAnchor, 0),
            left: (cell.leftAnchor, 0),
            bottom: (cell.bottomAnchor, 0),
            width: 90
        )
        
        cell.addSubview(characterName)
        characterName.anchor(
            centerY: (cell.centerYAnchor, 0),
            left: (characterIcon.rightAnchor, 10),
            right: (cell.rightAnchor, 10)
        )
    }
    
}
