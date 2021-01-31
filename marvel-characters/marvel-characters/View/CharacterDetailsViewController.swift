//
//  CharacterDetailsViewController.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 29/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    // MARK: - Attributes
    private var detailsStringURL: String = ""
    
    // MARK: - Layout Attributes
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    private let characterIcon = UIImageView()
    
    private let characterName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let characterStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fillProportionally
        return sv
    }()
    
    private let characterComics: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let characterSeries: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let characterStories: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let characterEvents: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let characterDescriptionTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.text = "Sobre o personagem:"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let characterDescription: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    fileprivate let moreDetailsButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.layer.backgroundColor = UIColor.black.cgColor
        btn.clipsToBounds = true
        btn.setTitle("+ detalhes".uppercased(), for: .normal)
        return btn
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.systemGray5
        self.title = "detalhes".uppercased()
    }
    
    // MARK: - Setup Functions
    public func setup(character: Character) {
        characterIcon.downloadImageFrom(link: character.thumbnailURL)
        characterName.text = character.name
        characterComics.text = "• \(character.details.comics) quadrinhos."
        characterSeries.text = "• \(character.details.series) séries."
        characterStories.text = "• \(character.details.stories) histórias."
        characterEvents.text = "• \(character.details.events) eventos."
        detailsStringURL = character.details.moreDetailsURL

        if !character.description.isEmpty {
            characterDescription.text = character.description
        } else {
            characterDescription.text = "Não há nenhuma descrição sobre o personagem até o momento :/"
        }
        
        setupConstraints()
        moreDetailsButton.addTarget(self, action: #selector(openDetails), for: .touchUpInside)
    }
    
    @objc private func openDetails() {
        if self.detailsStringURL.isEmpty {
            self.presentAlertDialog(title: "Ops!", message: "Não foi possível abrir a página de detalhes, tente novamente mais tarde.")
        } else if let url = URL(string: self.detailsStringURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    private func setupConstraints() {
        self.view.addSubview(moreDetailsButton)
        moreDetailsButton.anchor(
            left: (self.view.leftAnchor, 20),
            right: (self.view.rightAnchor, 20),
            bottom: (self.view.bottomAnchor, 20),
            height: 60
        )
        
        self.view.addSubview(scrollView)
        scrollView.anchor(
            top: (self.view.topAnchor, 0),
            left: (self.view.leftAnchor, 0),
            right: (self.view.rightAnchor, 0),
            bottom: (moreDetailsButton.topAnchor, 24)
        )
        
        scrollView.addSubview(containerView)
        containerView.anchor(
            top: (scrollView.topAnchor, 0),
            left: (self.view.leftAnchor, 0),
            right: (self.view.rightAnchor, 0),
            bottom: (scrollView.bottomAnchor, 0)
        )
        
        containerView.addSubview(characterIcon)
        characterIcon.anchor(
            top: (containerView.topAnchor, 0),
            left: (containerView.leftAnchor, 0),
            right: (containerView.centerXAnchor, 0),
            height: CGFloat(UIScreen.main.bounds.width) * 0.5
        )
        
        containerView.addSubview(characterName)
        characterName.anchor(
            top: (containerView.topAnchor, 10),
            left: (characterIcon.rightAnchor, 10),
            right: (containerView.rightAnchor, 10)
        )
        
        containerView.addSubview(characterStackView)
        characterStackView.anchor(
            top: (characterName.bottomAnchor, 10),
            left: (characterIcon.rightAnchor, 10),
            right: (containerView.rightAnchor, 10),
            bottom: (characterIcon.bottomAnchor, 0)
        )
        characterStackView.addArrangedSubview(characterComics)
        characterStackView.addArrangedSubview(characterSeries)
        characterStackView.addArrangedSubview(characterStories)
        characterStackView.addArrangedSubview(characterEvents)
        
        containerView.addSubview(characterDescriptionTitle)
        characterDescriptionTitle.anchor(
            top: (characterIcon.bottomAnchor, 20),
            left: (containerView.leftAnchor, 20),
            right: (containerView.rightAnchor, 20)
        )
        
        containerView.addSubview(characterDescription)
        characterDescription.anchor(
            top: (characterDescriptionTitle.bottomAnchor, 10),
            left: (containerView.leftAnchor, 20),
            right: (containerView.rightAnchor, 20),
            bottom: (containerView.bottomAnchor, 0)
        )
    }
    
}
