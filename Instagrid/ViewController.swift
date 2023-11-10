//
//  ViewController.swift
//  Instagrid
//
//  Created by Jimmy JERMIDI on 02/11/2023.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    var selectedButton: UIButton?
    
    
    @IBOutlet weak var ImgButton1: UIButton!
    @IBOutlet weak var ImgButton2: UIButton!
    @IBOutlet weak var ImgButton3: UIButton!
    @IBOutlet weak var ImgButton4: UIButton!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped(_:)))
        ImgButton1.addGestureRecognizer(tapGesture1)

                let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped(_:)))
        ImgButton2.addGestureRecognizer(tapGesture2)

                let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped(_:)))
        ImgButton3.addGestureRecognizer(tapGesture3)

                let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(imageButtonTapped(_:)))
        ImgButton4.addGestureRecognizer(tapGesture4)
           }
    
    
    @objc func imageButtonTapped(_ sender: UITapGestureRecognizer) {
            selectedButton = sender.view as? UIButton
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let originalImage = info[.editedImage] as? UIImage, let button = selectedButton {
            button.setImage(originalImage, for: .normal)
            /*if let croppedImage = resizeAndCropImage(originalImage, toSize: button.bounds.size) {
                
            }*/
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

