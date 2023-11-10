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
    
    
    enum Choice {
        case choice1, choice2, choice3
    }
    
    /*var choice: Choice = .choice1 {
        didSet {
            setChoice(choice)
        }
    }*/
    
    
    
    override init(frame: CGRect) {
        <#code#>
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   /* private func setChoice(_ choice: Choice){
        switch choice {
        case .choice1:
        case .choice2:
        case .choice3:
        }
        
    }*/
    
    private func isSelected(selectedView : UIImageView) {
        selectedView.isHidden = false
    }
    
    
}
