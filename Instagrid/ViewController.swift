//
//  ViewController.swift
//  Instagrid
//
//  V3
//
//  Created by Jimmy JERMIDI on 02/11/2023.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    var selectedButton: UIButton?
    
    
    @IBOutlet weak var ImgButton1: UIButton!
    @IBOutlet weak var ImgButton2: UIButton!
    @IBOutlet weak var ImgButton3: UIButton!
    @IBOutlet weak var ImgButton4: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont(name: "ThirstySoftRegular", size: 32)
        }
    }
        
        
    @IBOutlet weak var swipeLabel: UILabel!{
        didSet {
            swipeLabel.font = UIFont(name: "Delm-Medium", size: 25)
        }
    }
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setupChoices()
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipe), name: UIDevice.orientationDidChangeNotification, object: nil)

        
        imagePicker.delegate = self
        
        
    }
    
    
    func showImagePicker(with sourceType: UIImagePickerController.SourceType) {
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                present(imagePicker, animated: true, completion: nil)
            } else {
                print("La source spécifiée n'est pas disponible.")
            }
        }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let originalImage = info[.editedImage] as? UIImage, let button = selectedButton {
            button.setImage(originalImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    private var allOptionsView: [OptionItemView] = []
    
    private func setupChoices(){
        let allLayouts = OptionItemView.Choices.allCases
        
        // Append Option in stackView
        for optionLayout in allLayouts {
            let option = createOptionView(choice: optionLayout)
            allOptionsView.append(option)
            self.stackView.addArrangedSubview(option)
        }
    }
    
    
    private func createOptionView(choice: OptionItemView.Choices) -> OptionItemView {
        let option = OptionItemView(choice: choice, frame: CGRect.zero)
        option.translatesAutoresizingMaskIntoConstraints = false
        option.onTapAction = {
            self.deselectAll()
            option.isSelected = true
            // TODO: Changer le format de la vue centrale 
            self.makeChoice(choice: choice)
        }
        NSLayoutConstraint.activate([
            option.widthAnchor.constraint(equalToConstant: 80),
            option.heightAnchor.constraint(equalToConstant: 80)
        ])
        return option
    }
    
    private func deselectAll() {
        allOptionsView.forEach { option in
            option.deselectOption()
        }
    }
    
    private func makeChoice(choice: OptionItemView.Choices){
        switch choice{
        case .choice1:
            ImgButton1.isHidden = false
            ImgButton2.isHidden = true
            ImgButton3.isHidden = false
            ImgButton4.isHidden = false
            
        case .choice2:
            ImgButton1.isHidden = false
            ImgButton2.isHidden = false
            ImgButton3.isHidden = false
            ImgButton4.isHidden = true
        case .choice3:
            ImgButton1.isHidden = false
            ImgButton2.isHidden = false
            ImgButton3.isHidden = false
            ImgButton4.isHidden = false
        }
        
    }
    
    
    @IBAction func buttonAction1(_ sender: Any) {
        selectedButton = ImgButton1
        showImagePicker(with: .photoLibrary)
    }
    
    
    @IBAction func buttonAction2(_ sender: Any) {
        selectedButton = ImgButton2
        showImagePicker(with: .photoLibrary)
    }
    
    
    
    @IBAction func buttonAction3(_ sender: Any) {
        selectedButton = ImgButton3
        showImagePicker(with: .photoLibrary)
    }
    
    
    @IBAction func buttonAction4(_ sender: Any) {
        selectedButton = ImgButton4
        showImagePicker(with: .photoLibrary)
    }
    
    @objc func setUpSwipe() {
            if UIDevice.current.orientation.isPortrait {
                setRecognizerUp()
                swipeLabel.text = " Swipe up to share "
            } else if UIDevice.current.orientation.isLandscape {
                setRecognizerLeft()
                swipeLabel.text = " Swipe left to share"
            }
        }


    
    
    private func setRecognizerUp(){
        let swipeGestureRecognizerUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerUp.direction = .up
        
        mainView.addGestureRecognizer(swipeGestureRecognizerUp)
    }
    
    
    private func setRecognizerLeft(){
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerLeft.direction = .left
        
        mainView.addGestureRecognizer(swipeGestureRecognizerLeft)
    }
    
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        let renderer = UIGraphicsImageRenderer(size: mainView.bounds.size)
        let image = renderer.image { ctx in
            mainView.drawHierarchy(in: mainView.bounds, afterScreenUpdates: true)
        }
        let item = [image]
        let activityController = UIActivityViewController(activityItems: item, applicationActivities: nil)
        present(activityController, animated: true)
    }
    
}

