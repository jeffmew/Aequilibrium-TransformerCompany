//
//  ResultView.swift
//  TransformerCompany
//
//  Created by Jeff Mew on 2017-11-25.
//  Copyright © 2017 Jeff Mew. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    init(fighters: [Transformers]) {
        self.fighters = fighters
        
        super.init(frame: .zero)
        
        backgroundColor = UIColor.white
        
        addSubview(resultLabel)
        
        setupLabel()
        
        setupConstraints()
    }
    
    @available(*, unavailable)
    init() {
        fatalError()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        let constraints : [NSLayoutConstraint] = [
            resultLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            resultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ]
        
        NSLayoutConstraint.activate(constraints)
        
        super.updateConstraints()
    }
    
    //MARK: Accesssors
    
    private let fighters: [Transformers]!
    
    private var mutualDestruction: Bool = false
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: Helpers
    
    func setupLabel() {
        let sorted = sortTransformers(unsorted: fighters)
        let sortedAutobots = sorted.0
        let sortedDecepticons = sorted.1
        
        var autobotWins = 0
        var decepticonWins = 0
        
        var winningAutobots: [Transformers] = []
        var winningDecepticons: [Transformers] = []
        
        var survivingAutobots: [Transformers] = []
        var survivingDecepticons: [Transformers] = []
        
        let firstSurvivingIndex = min(sortedAutobots.count, sortedDecepticons.count)
        if sortedAutobots.count > sortedDecepticons.count {
            for index in firstSurvivingIndex...sortedAutobots.count - 1 {
                survivingAutobots.append(sortedAutobots[index])
            }
        } else if sortedAutobots.count < sortedDecepticons.count {
            for index in firstSurvivingIndex...sortedDecepticons.count - 1 {
                survivingDecepticons.append(sortedDecepticons[index])
            }
        }
        
        let upperbound = min(sortedAutobots.count, sortedDecepticons.count)
        
        for index in 0...upperbound - 1 {
            if mutualDestruction == true {
                break
            }
            
            if let battleWinner = determineWinner(fighter1: sortedAutobots[index], fighter2: sortedDecepticons[index]) {
                if battleWinner.name == sortedAutobots[index].name && battleWinner.robotType == .Autobot {
                    autobotWins += 1
                    winningAutobots.append(battleWinner)
                } else {
                    decepticonWins += 1
                    winningDecepticons.append(battleWinner)
                }
            }
        }
        
        if mutualDestruction == true {
            resultLabel.text = "All Competitors Destroyed"
            return
        }
        
        resultLabel.text = {
           
            var resultText = "\(upperbound) battle(s)\n"
            
            let winningTransformers: [Transformers]
            let survivingTransformers: [Transformers]
            let losingTransformerWinners: [Transformers]
            let losingTransformerSurvivors:[Transformers]
            
            if autobotWins > decepticonWins {
                winningTransformers = winningAutobots
                survivingTransformers = survivingAutobots
                losingTransformerWinners = winningDecepticons
                losingTransformerSurvivors = survivingDecepticons
            } else if decepticonWins > autobotWins {
                winningTransformers = winningDecepticons
                survivingTransformers = survivingDecepticons
                losingTransformerWinners = winningAutobots
                losingTransformerSurvivors = survivingAutobots
            } else {
                resultText.append("\n\nWe have a tie...")
                return resultText
            }
            
            let winningTransformersString = autobotWins > decepticonWins ? "Autobots" : "Decepticons"
            let losingTransformersString = autobotWins > decepticonWins ? "Decepticons" : "Autobots"
            
            resultText.append("\n\nWinning team (\(winningTransformersString)):")
            
            for index in winningTransformers {
                resultText.append(" \(index.name)")
            }

            for index in survivingTransformers {
                resultText.append(" \(index.name)")
            }
            
            resultText.append("\n\nSurvivors from the losing team (\(losingTransformersString)): ")
            
            for index in losingTransformerWinners {
                resultText.append(" \(index.name)")
            }
            
            for index in losingTransformerSurvivors {
                resultText.append(" \(index.name)")
            }

            return resultText
        }()

    }
    
    func overallRating(transformer: Transformers) -> Int {
        return transformer.strength + transformer.intelligence + transformer.speed + transformer.endurance + transformer.firepower
    }
    
    func determineWinner(fighter1: Transformers, fighter2: Transformers) -> Transformers? {
        if (fighter1.name == Transformers.leaders.optimusprime || fighter1.name == Transformers.leaders.predaking) &&
            (fighter2.name == Transformers.leaders.optimusprime || fighter2.name == Transformers.leaders.predaking) {
            mutualDestruction = true
            return nil
        }
        
        if fighter1.name == Transformers.leaders.optimusprime || fighter1.name == Transformers.leaders.predaking {
            return fighter1
        }
        
        if fighter2.name == Transformers.leaders.optimusprime || fighter2.name == Transformers.leaders.predaking {
            return fighter2
        }
        
        if courageTest(fighter1: fighter1, fighter2: fighter2) == true {
            return fighter1
        }
        
        if courageTest(fighter1: fighter2, fighter2: fighter1) == true {
            return fighter2
        }
        
        if fighter1.skill - fighter2.skill > 2 {
            return fighter1
        }

        if fighter2.skill - fighter1.skill > 2 {
            return fighter2
        }
        
        if overallRating(transformer: fighter1) == overallRating(transformer: fighter2) {
            return nil
        } else if overallRating(transformer: fighter1) > overallRating(transformer: fighter2) {
            return fighter1
        }
        return fighter2
    }
    
    //Tests if fighter1 scares off fighter2
    func courageTest(fighter1: Transformers, fighter2: Transformers) -> Bool {
        if ((fighter1.courage - fighter2.courage) > 3) &&
            ((fighter1.strength - fighter2.strength) > 2) {
            return true
        }
        return false
    }
    
    func sortTransformers(unsorted: [Transformers]) -> ([Transformers], [Transformers]) {
        var autobots: [Transformers] = []
        var decepticons: [Transformers] = []
        
        for transformer in unsorted {
            if transformer.robotType == .Autobot {
                autobots.append(transformer)
                continue
            }
            decepticons.append(transformer)
        }
        
        autobots.sort {$0.rank > $1.rank}
        decepticons.sort {$0.rank > $1.rank}
        
        return (autobots,decepticons)
    }
}

