//
//  ViewController.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-24.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import UIKit

class FighterListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddFighterViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Fighter List"
        
        self.navigationItem.leftBarButtonItem = addBarButton
        self.navigationItem.rightBarButtonItem = submitBarButton

        fighterListView.tableView.dataSource = self
        fighterListView.tableView.delegate = self
        
        fighterListView.clearButton.addTarget(self, action: #selector(clearAll), for: .touchUpInside)
    }

    override func loadView() {
        self.view = fighterListView
    }

    //MARK: Actions
    
    @objc private func addFighter() {
        let addFighterViewController = AddFighterViewController()
        addFighterViewController.delegate = self
        let navBarController = UINavigationController(rootViewController: addFighterViewController)
        present(navBarController, animated: true, completion: nil)
    }
    
    @objc private func submit() {
        var numberOfAutobots = 0
        var numberOfDecepticons = 0
        
        for transformer in fighters {
            if transformer.robotType == .Autobot {
                numberOfAutobots += 1
            } else {
                numberOfDecepticons += 1
            }
        }
        
        if numberOfAutobots == 0 || numberOfDecepticons == 0 {
            let alertController = UIAlertController(title: "Ooops!", message: "Must have at least 1 robot on each team", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let resultViewController = ResultViewController(fighters: fighters)
        navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    @objc private func clearAll() {
        fighters = []
        fighterListView.tableView.reloadData()
    }
    
    //MARK: Accessors
    
    private lazy var fighterListView: FighterListView = {
        let fighterlistview = FighterListView()
        return fighterlistview
    }()
    
    private lazy var addBarButton: UIBarButtonItem = {
        let addbarbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFighter))
        return addbarbutton
    }()
    
    private lazy var submitBarButton: UIBarButtonItem = {
        let submitbarbutton = UIBarButtonItem(title: "Fight!", style: UIBarButtonItemStyle.plain, target: self, action: #selector(submit))
        return submitbarbutton
    }()
    
    private lazy var fighters: [Transformers] = {
        let fightersarray = [Transformers]()
        return fightersarray
    }()

    //MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fighters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableviewCellIdentifier) else {
            fatalError("The dequeued cell is nil")
        }

        let transformer = fighters[indexPath.row]
        cell.textLabel?.text = "\(transformer.name) - \(transformer.robotType == .Autobot ? "AUTOBOT" : "DECEPTICON")"

        return cell
    }
    
    //MARK: AddFighterViewControllerDelegate
    
    func didAddNewFighter(newFighter: Transformers) {
        fighters.append(newFighter)
        
        fighterListView.tableView.reloadData()
    }
}

