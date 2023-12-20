//
//  OptionItemView.swift
//  Instagrid
//
//  Created by Jimmy JERMIDI on 09/11/2023.
//

import UIKit

class OptionItemView: UIView {
    
    private var choiceImg: UIImageView!
    private var selectedView: UIImageView!
    private var actionButton: UIButton!
    
    enum Choices: CaseIterable {
        case choice1, choice2, choice3
    }
    
    var isSelected: Bool = false {
        didSet {
            selectedView.isHidden = !isSelected
        }
    }
    
    var choice: Choices = .choice1 {
        didSet {
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
    
    var onTapAction: (() -> Void)?
    
    init(choice: Choices, frame: CGRect) {
        super.init(frame: frame)
        initOptionImageView()
        initSelectedImageView()
        initAction()
        defer {
            // Call the didSet
            self.choice = choice
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func initOptionImageView() {
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
        self.isSelected = false
    }
    
    private func initAction() {
        actionButton = UIButton()
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(actionButton)
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        actionButton.addTarget(self, action: #selector(onAction), for: .touchUpInside)
    }
    
    // MARK: - Public
    @objc public func onAction() {
        onTapAction?()
    }
    
    @objc public func selectOption() {
        self.isSelected = true
    }
    
    @objc public func deselectOption() {
        self.isSelected = false
    }
}
