//
//  FighterListView.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-24.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import UIKit

let TableviewCellIdentifier = "Cell"

class FighterListView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        
        addSubview(tableView)
        addSubview(clearButton)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        var constraints : [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor),
            
            clearButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            clearButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            clearButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            clearButton.heightAnchor.constraint(equalToConstant: 40),
            ]
        
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        trailingConstraint.priority = .defaultLow
        constraints.append(trailingConstraint)
        
        NSLayoutConstraint.activate(constraints)
        
        super.updateConstraints()
    }
    
    //MARK: Accesssors
    
    private(set) lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: TableviewCellIdentifier)
        tableview.allowsSelection = false
        tableview.alwaysBounceVertical = false
        return tableview
    }()
    
    private(set) lazy var clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Clear All", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
}
