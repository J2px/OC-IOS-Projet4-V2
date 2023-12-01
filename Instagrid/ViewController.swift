//
//  ViewController.swift
//  Instagrid
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
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //controlGesture(button: ImgButton1)
        //controlGesture(button: ImgButton2)
        //controlGesture(button: ImgButton3)
        //controlGesture(button: ImgButton4)
        controlChoices()
        
        imagePicker.delegate = self
        
        
    }
    
    
    /*@objc func imageButtonTapped(_ sender: UITapGestureRecognizer) {
        selectedButton = sender.view as? UIButton
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }*/
    
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
            /*if let croppedImage = resizeAndCropImage(originalImage, toSize: button.bounds.size) {
             
             }*/
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    //Remplacer par l'IBAction avec touc up inside
    private func controlGesture(button : UIButton){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped(_:)))
        button.addGestureRecognizer(tapGesture)
    }*/
    
    
    private func controlChoices(){
        let allLayouts = OptionItemView.Choices.allCases
        var allOptions = [createOption()]
        
        // Append Option in stackView
        for optionLayout in allLayouts {
            let option = createOption()
            option.choice = optionLayout
            self.stackView.addArrangedSubview(option)
            allOptions.append(option)
            
            
        }
    }
    
    
    private func createOption() -> OptionItemView {
        let option = OptionItemView(frame: CGRect.zero)
        option.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            option.widthAnchor.constraint(equalToConstant: 80),
            option.heightAnchor.constraint(equalToConstant: 80)
        ])
        return option
    }
    
    private func makeChoice(choice: OptionItemView.Choices){
        switch choice{
        case .choice1:
            ImgButton2.isHidden = true
            
        case .choice2:
            ImgButton4.isHidden = true
        case .choice3:
            ImgButton2.isHidden = false
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
    
    
}

