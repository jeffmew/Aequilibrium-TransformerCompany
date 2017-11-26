//
//  TCStepper.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-24.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import UIKit

class TCStepper: UIView {
    
    init(infoText: String) {
        super.init(frame: .zero)
        
        infoLabel.text = infoText
        
        translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.text = "\(Int(stepper.value))"
        
        addSubview(valueLabel)
        addSubview(stepper)
        addSubview(infoLabel)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let constraints : [NSLayoutConstraint] = [
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -10),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            valueLabel.centerYAnchor.constraint(equalTo: stepper.centerYAnchor),
            
            stepper.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stepper.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        super.updateConstraints()
    }
    
    public func stepperValue(value: Int) {
        stepper.value = Double(value)
    }
    
    //MARK: Actions
    
    @objc func stepperValueChanged(sender: UIStepper!) {
        valueLabel.text = "\(Int(sender.value))"
    }
    
    //MARK: Accessors
    
    private lazy var valueLabel: UILabel = {
        let tclabel = UILabel()
        tclabel.translatesAutoresizingMaskIntoConstraints = false
        return tclabel
    }()
    
    private lazy var infoLabel: UILabel = {
        let infolabel = UILabel()
        infolabel.translatesAutoresizingMaskIntoConstraints = false
        return infolabel
    }()
    
    private(set) lazy var stepper: UIStepper = {
        let tcstepper = UIStepper()
        tcstepper.translatesAutoresizingMaskIntoConstraints = false
        tcstepper.maximumValue = 10
        tcstepper.minimumValue = 1
        tcstepper.tintColor = UIColor.black
        tcstepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        return tcstepper
    }()
}
