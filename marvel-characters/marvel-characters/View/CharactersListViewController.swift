//
//  CharactersListViewController.swift
//  marvel-characters
//
//  Created by Matheus Brasilio on 28/01/21.
//  Copyright © 2021 Matheus Brasilio. All rights reserved.
//

import UIKit

class CharactersListViewController: UIViewController {
    // MARK: Attributes
    let viewModel = CharactersListViewModel()
    var isSearchBarList: Bool = false
    
    // MARK: - Layout Attributes
    fileprivate let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.clear
        tv.showsVerticalScrollIndicator = true
        tv.estimatedRowHeight = CharactersListTableViewCell.cellHeight + CharactersListTableViewCell.cellSpacing
        tv.register(CharactersListTableViewCell.self, forCellReuseIdentifier: CharactersListTableViewCell.cellIdentifier)
        return tv
    }()
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Buscar personagem..."
        sb.isTranslucent = false
        sb.sizeToFit()
        return sb
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        setupConstraints()
        setupViewConfig()
        setupSearchBarKeyboardButton()
        getCharactersList()
    }
    
    // MARK: - Setup Functions
    fileprivate func setupViewConfig() {
        self.view.backgroundColor = UIColor.systemGray5
        self.title = "personagens".uppercased()
    }
    
    fileprivate func setupConstraints() {
        self.view.addSubview(tableView)
        tableView.anchor(
            top: (self.view.topAnchor, 0),
            left: (self.view.leftAnchor, 0),
            right: (self.view.rightAnchor, 0),
            bottom: (self.view.bottomAnchor, 0)
        )
    }
    
    fileprivate func getCharactersList(nameStartsWith: String = "", isASpecificSearch: Bool = false) {
        self.presentLoading()
        viewModel.getCharactersList(nameStartsWith, isASpecificSearch) {
            DispatchQueue.main.async {
                self.removeLoading()
                if self.viewModel.charactersListComplete == nil {
                    self.presentAlertDialog(title: "Ops!", message: "Não foi possível carregar a lista de personagens agora, pedimos desculpa pelo transtorno!")
                } else if self.viewModel.charactersListComplete!.isEmpty {
                    self.presentAlertDialog(title: "Nenhum personagem encontrado", message: "Lembre-se de fazer a pesquisa em inglês =)")
                }
                self.tableView.reloadData()
                self.view.endEditing(true)
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.viewModel.charactersListComplete {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersListTableViewCell.cellIdentifier) as? CharactersListTableViewCell, let list = viewModel.charactersListComplete, indexPath.row < list.count else { return UITableViewCell() }
        cell.setupCell(character: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let list = self.viewModel.charactersListComplete, indexPath.row == list.count - 1, !viewModel.specificVersionLoaded {
            getCharactersList()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchBar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = viewModel.charactersListComplete, indexPath.row < list.count {
            let vc = CharacterDetailsViewController()
            vc.setup(character: list[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate
extension CharactersListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.isSearchBarList = true
            getCharactersList(nameStartsWith: text, isASpecificSearch: true)
        }
        searchBar.endEditing(true)
    }
    
    @objc private func closeButtonAction() {
        if (searchBar.text == nil || searchBar.text!.isEmpty) && isSearchBarList {
            self.isSearchBarList = false
            getCharactersList()
        }
    }
    
    private func setupSearchBarKeyboardButton() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let okBtn = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeButtonAction))
        
        toolbar.setItems([flexSpace, okBtn], animated: false)
        toolbar.sizeToFit()
        
        searchBar.inputAccessoryView = toolbar
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeButtonAction))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}
