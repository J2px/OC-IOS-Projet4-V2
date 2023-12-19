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
    
    // MARK: - Private vars
    private let imagePicker = UIImagePickerController()
    private var selectedButton: UIButton?
    private var allOptionsView: [OptionItemView] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgButton1: UIButton!
    @IBOutlet weak var imgButton2: UIButton!
    @IBOutlet weak var imgButton3: UIButton!
    @IBOutlet weak var imgButton4: UIButton!
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
    
    enum Orientation {
        case portrait, landscape, inside
    }
    
    @IBOutlet weak var viewPicture: UIStackView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChoices()
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipe), name: UIDevice.orientationDidChangeNotification, object: nil)
        imagePicker.delegate = self
    }
    
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
            self.deselectAllOptions()
            option.isSelected = true
            self.makeChoice(choice: choice)
        }
        NSLayoutConstraint.activate([
            option.widthAnchor.constraint(equalToConstant: 80),
            option.heightAnchor.constraint(equalToConstant: 80)
        ])
        return option
    }
    
    private func deselectAllOptions() {
        allOptionsView.forEach { option in
            option.deselectOption()
        }
    }
    
    private func makeChoice(choice: OptionItemView.Choices){
        switch choice{
        case .choice1:
            imgButton1.isHidden = false
            imgButton2.isHidden = true
            imgButton3.isHidden = false
            imgButton4.isHidden = false
        case .choice2:
            imgButton1.isHidden = false
            imgButton2.isHidden = false
            imgButton3.isHidden = false
            imgButton4.isHidden = true
        case .choice3:
            imgButton1.isHidden = false
            imgButton2.isHidden = false
            imgButton3.isHidden = false
            imgButton4.isHidden = false
        }
    }
    
    // MARK: - IBActions
    @IBAction func buttonAction1(_ sender: Any) {
        selectedButton = imgButton1
        showImagePicker(with: .photoLibrary)
    }
    
    @IBAction func buttonAction2(_ sender: Any) {
        selectedButton = imgButton2
        showImagePicker(with: .photoLibrary)
    }
    
    @IBAction func buttonAction3(_ sender: Any) {
        selectedButton = imgButton3
        showImagePicker(with: .photoLibrary)
    }
    
    @IBAction func buttonAction4(_ sender: Any) {
        selectedButton = imgButton4
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
        var orientation = getOrientation()
        moveView(orientation: orientation)
        let renderer = UIGraphicsImageRenderer(size: mainView.bounds.size)
        let image = renderer.image { ctx in
            mainView.drawHierarchy(in: mainView.bounds, afterScreenUpdates: true)
        }
        let item = [image]
        let activityController = UIActivityViewController(activityItems: item, applicationActivities: nil)
        present(activityController, animated: true)
        
        activityController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.moveView(orientation: .inside)
            } else {
                self.moveView(orientation: .inside)
            }
        }
    }
    
    private func getOrientation() -> Orientation {
        var orientation: Orientation
            
            if UIDevice.current.orientation.isPortrait {
                orientation = .portrait
            } else if UIDevice.current.orientation.isLandscape {
                orientation = .landscape
            } else {
                orientation = .inside
            }
            
            return orientation
    }
    
    private func moveView(orientation: Orientation){
        switch orientation {
        case .portrait:
            UIView.animate(withDuration: 0.5) {
                self.viewPicture.transform = CGAffineTransform(translationX: 0, y: -self.viewPicture.frame.height*2)
            }
        case .landscape:
            UIView.animate(withDuration: 0.5) {
                self.viewPicture.transform = CGAffineTransform(translationX: -self.viewPicture.frame.height*2, y: 0)
            
            }
        case .inside:
            UIView.animate(withDuration: 0.5) {
                self.viewPicture.transform = .identity
            }
        }
        
    }
    
    
    // MARK: - Picker
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
}

