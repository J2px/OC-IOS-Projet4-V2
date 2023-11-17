//
//  OptionItemView.swift
//  Instagrid
//
//  Created by Jimmy JERMIDI on 09/11/2023.
//

import UIKit

class OptionItemView: UIView {
    
    private var choiceImg1 : UIImageView!
    private var choiceImg2 : UIImageView!
    private var choiceImg3 : UIImageView!
    private var selectedView : UIImageView!
    
    
    enum Choice: CaseIterable {
        case choice1, choice2, choice3
    }
    
    var choice: Choice = .choice1 {
        didSet {
            setChoices(choice)
        }
    }
    
    
    
    override init(frame: CGRect) {
        <#code#>
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setChoices(_ choice: Choice){
        switch choice {
        case .choice1: 
    choiceImg1.image = UIImage(named: "Layout_1")
            initOptionImageView(choice: choiceImg1)
    initSelectedImageView()
    case .choice2:
    choiceImg2.image = UIImage(named: "Layout_2")
            initOptionImageView(choice: choiceImg2)
    initSelectedImageView()
    case .choice3:
    choiceImg3.image = UIImage(named: "Layout_3")
            initOptionImageView(choice: choiceImg3)
    initSelectedImageView()
    }
        
    }
    
    private func initOptionImageView(choice: UIImageView) {
        choice.contentMode = .scaleToFill
        choice.translatesAutoresizingMaskIntoConstraints = false
        addSubview(choice)
        NSLayoutConstraint.activate([
            choice.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            choice.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            choice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            choice.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
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
        isSelected(selectedView: selectedView)
    }
        
    private func isSelected(selectedView : UIImageView) {
        selectedView.isHidden = false
    }
    
    
}
