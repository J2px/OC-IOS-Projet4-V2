//
//  OptionItemView.swift
//  Instagrid
//
//  Created by Jimmy JERMIDI on 09/11/2023.
//

import UIKit

class OptionItemView: UIView {
    
    var choiceImg: UIImageView!
    var selectedView: UIImageView!
    
    
    enum Choices: CaseIterable {
        case choice1, choice2, choice3
    }
    
    var choice: Choices = .choice1 {
        didSet {
            
            guard let choiceImg = choiceImg else {
                            return
                        }

            switch choice {
            case .choice1:
                choiceImg.image = UIImage(named: "Layout 1")
                
            case .choice2:
                choiceImg.image = UIImage(named: "Layout 2")
                
            case .choice3:
                choiceImg.image = UIImage(named: "Layout 3")
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setChoices()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setChoices()
    }
    
    private func setChoices(){
        initSelectedImageView()
        initSelectedImageView()
        
    }
    
    private func initOptionImageView(choice: UIImageView) {
        choiceImg = UIImageView()
        choiceImg.contentMode = .scaleToFill
        choiceImg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(choiceImg)
        NSLayoutConstraint.activate([
            choiceImg.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            choiceImg.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            choiceImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            choiceImg.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    
    private func initSelectedImageView() {
        selectedView = UIImageView()
        selectedView.contentMode = .scaleToFill
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        selectedView.image = UIImage(named: "Selected")
        addSubview(selectedView)
        NSLayoutConstraint.activate([
            selectedView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            selectedView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            selectedView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            selectedView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        //isSelected(selectedView: selectedView)
    }
        
    /*private func isSelected(selectedView : UIImageView) {
        selectedView.isHidden = false
    }*/
    
    
}
