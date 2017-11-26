//
//  ResultViewController.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-25.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    init(fighters: [Transformers]) {
        self.fighters = fighters
        
        super.init(nibName: nil, bundle: nil)            
    }
    
    @available(*, unavailable)
    init() {
        fatalError()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = resultView
    }
    
    //MARK: Actions
    
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Accessors
    
    private lazy var resultView: ResultView = {
        let resultview = ResultView(fighters: fighters)
        return resultview
    }()
    
    private let fighters: [Transformers]!
}
