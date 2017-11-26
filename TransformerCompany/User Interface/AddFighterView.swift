//
//  AddFighterView.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-24.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import UIKit

enum StepperTags: Int {
    case Strength
    case Intelligence
    case Speed
    case Endurance
    case Rank
    case Courage
    case FirePower
    case Skill
}

class AddFighterView: UIView {
    
    init(fighter: Transformers) {
        super.init(frame: .zero)
        
        nameTextField.text = fighter.name
        strengthStepper.stepperValue(value: fighter.strength)
        intelligenceStepper.stepperValue(value: fighter.intelligence)
        speedStepper.stepperValue(value: fighter.speed)
        enduranceStepper.stepperValue(value: fighter.endurance)
        rankStepper.stepperValue(value: fighter.rank)
        courageStepper.stepperValue(value: fighter.courage)
        firePowerStepper.stepperValue(value: fighter.firepower)
        skillStepper.stepperValue(value: fighter.skill)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightGray
        
        addSubview(scrollView)
        scrollView.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(nameLabel)
        rootStackView.addArrangedSubview(nameTextField)
        rootStackView.addArrangedSubview(robotTypeLabel)
        rootStackView.addArrangedSubview(typePicker)
        rootStackView.addArrangedSubview(strengthStepper)
        rootStackView.addArrangedSubview(intelligenceStepper)
        rootStackView.addArrangedSubview(speedStepper)
        rootStackView.addArrangedSubview(enduranceStepper)
        rootStackView.addArrangedSubview(rankStepper)
        rootStackView.addArrangedSubview(courageStepper)
        rootStackView.addArrangedSubview(firePowerStepper)
        rootStackView.addArrangedSubview(skillStepper)
        
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let constraints : [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            typePicker.heightAnchor.constraint(equalToConstant: 40),
            
            nameTextField.heightAnchor.constraint(equalToConstant: 32),
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        super.updateConstraints()
    }
    
    //MARK: Accesssors
    
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        scrollview.alwaysBounceVertical = false
        scrollview.isScrollEnabled = true
        return scrollview
    }()
    
    private lazy var rootStackView: UIStackView = {
        let rootstackview = UIStackView()
        rootstackview.translatesAutoresizingMaskIntoConstraints = false
        rootstackview.alignment = .fill
        rootstackview.spacing = 10
        rootstackview.axis = .vertical
        rootstackview.layoutMargins = UIEdgeInsetsMake(24, 24, 24, 24)
        rootstackview.isLayoutMarginsRelativeArrangement = true
        return rootstackview
    }()
    
    private lazy var nameLabel: UILabel = {
        let namelabel = UILabel()
        namelabel.text = Transformers.stats.name
        return namelabel
    }()
    
    public private(set) lazy var nameTextField: UITextField = {
        let nametextfield = UITextField()
        nametextfield.translatesAutoresizingMaskIntoConstraints = false
        nametextfield.layer.cornerRadius = 2
        nametextfield.backgroundColor = UIColor.white
        nametextfield.borderStyle = .roundedRect
        nametextfield.autocorrectionType = .no
        return nametextfield
    }()
    
    private lazy var robotTypeLabel: UILabel = {
        let robottypelabel = UILabel()
        robottypelabel.text = Transformers.stats.robotType
        return robottypelabel
    }()

    private(set) lazy var typePicker: UIPickerView = {
        let typepicker = UIPickerView()
        typepicker.rowSize(forComponent: 15)
        return typepicker
    }()
    
    private(set) lazy var strengthStepper: TCStepper = {
        let strengthStepper = TCStepper(infoText: Transformers.stats.strength)
        strengthStepper.stepper.tag = StepperTags.Strength.rawValue
        return strengthStepper
    }()

    private(set) lazy var intelligenceStepper: TCStepper = {
        let intelligencestepper = TCStepper(infoText: Transformers.stats.intelligence)
        intelligencestepper.stepper.tag = StepperTags.Intelligence.rawValue
        return intelligencestepper
    }()

    private(set) lazy var speedStepper: TCStepper = {
        let speedstepper = TCStepper(infoText: Transformers.stats.speed)
        speedstepper.stepper.tag = StepperTags.Speed.rawValue
        return speedstepper
    }()

    private(set) lazy var enduranceStepper: TCStepper = {
        let endurancestepper = TCStepper(infoText: Transformers.stats.endurance)
        endurancestepper.stepper.tag = StepperTags.Endurance.rawValue
        return endurancestepper
    }()

    private(set) lazy var rankStepper: TCStepper = {
        let rankstepper = TCStepper(infoText: Transformers.stats.rank)
        rankstepper.stepper.tag = StepperTags.Rank.rawValue
        return rankstepper
    }()

    private(set) lazy var courageStepper: TCStepper = {
        let couragestepper = TCStepper(infoText: Transformers.stats.courage)
        couragestepper.stepper.tag = StepperTags.Courage.rawValue
        return couragestepper
    }()

    private(set) lazy var firePowerStepper: TCStepper = {
        let firePowerStepper = TCStepper(infoText: Transformers.stats.firepower)
        firePowerStepper.stepper.tag = StepperTags.FirePower.rawValue
        return firePowerStepper
    }()

    private(set) lazy var skillStepper: TCStepper = {
        let skillstepper = TCStepper(infoText: Transformers.stats.skill)
        skillstepper.stepper.tag = StepperTags.Skill.rawValue
        return skillstepper
    }()
}

