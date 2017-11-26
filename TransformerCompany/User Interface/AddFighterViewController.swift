//
//  AddFighterViewController.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-24.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import UIKit

protocol AddFighterViewControllerDelegate: class {
    
    func didAddNewFighter(newFighter: Transformers)
}

class AddFighterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Fighter"
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = cancelBarButton
        self.navigationItem.rightBarButtonItem = submitBarButton
        
        addFighterView.typePicker.delegate = self
        addFighterView.typePicker.delegate = self
        
        addFighterView.strengthStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        addFighterView.intelligenceStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        addFighterView.speedStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        addFighterView.enduranceStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        addFighterView.rankStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        addFighterView.courageStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        addFighterView.firePowerStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        addFighterView.skillStepper.stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
    }
    
    override func loadView() {
        view = addFighterView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: Actions
    
    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func submit() {
        guard let name = addFighterView.nameTextField.text, name != "" else {
            return
        }
        
        newFighter.name = name
        
        delegate?.didAddNewFighter(newFighter: newFighter)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func stepperValueChanged(sender: UIStepper!)
    {
        if let stepper = sender {
            switch stepper.tag {
            case StepperTags.Strength.rawValue:
                newFighter.strength = Int(sender.value)
            case StepperTags.Intelligence.rawValue:
                newFighter.intelligence = Int(sender.value)
            case StepperTags.Speed.rawValue:
                newFighter.speed = Int(sender.value)
            case StepperTags.Endurance.rawValue:
                newFighter.endurance = Int(sender.value)
            case StepperTags.Rank.rawValue:
                newFighter.rank = Int(sender.value)
            case StepperTags.Courage.rawValue:
                newFighter.courage = Int(sender.value)
            case StepperTags.FirePower.rawValue:
                newFighter.firepower = Int(sender.value)
            case StepperTags.Skill.rawValue:
                newFighter.skill = Int(sender.value)
            default:
                break
            }
        }
    }
    
    //MARK: Accessors
    
    weak var delegate: AddFighterViewControllerDelegate?
    
    private lazy var cancelBarButton: UIBarButtonItem = {
        let cancelbarbutton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        return cancelbarbutton
    }()
    
    private lazy var submitBarButton: UIBarButtonItem = {
        let submitbarbutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submit))
        return submitbarbutton
    }()
    
    private lazy var addFighterView: AddFighterView = {
        let addfighterview = AddFighterView()
        return addfighterview
    }()
    
    private lazy var newFighter: Transformers = {
        let newfighter = Transformers()
        return newfighter
    }()
    
    private lazy var pickerData: [String] = {
        let pickerdata = ["AutoBot", "Decepticon"]
        return pickerdata
    }()
    
    //MARK: UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //MARK: UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newFighter.robotType = row == 0 ? .Autobot : .Decepticon
    }
}

