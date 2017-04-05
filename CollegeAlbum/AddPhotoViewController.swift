//
//  AddPhotoViewController.swift
//  CollegeAlbum
//
//  Created by Jake Wojtas on 3/12/17.
//  Copyright © 2017 Jake Wojtas. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var photoButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var collegeImageView: UIImageView!
    @IBOutlet weak var addButton: UIButton! //Also Update button
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var subtextTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var imagePicker = UIImagePickerController()
    var memory : Memory? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        deleteButton.isHidden = true
        
        if memory != nil {
            print("We have liftoff")
            deleteButton.isHidden = false
            collegeImageView.image = UIImage(data: memory?.image as! Data)
            dateTextField.text = memory!.date
            subtextTextField.text = memory!.subtext
            
            addButton.setTitle("Update", for: .normal)
        } else {
            
        }
        
    }
    
    @IBAction func photoButton(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        collegeImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        /*
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        */
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        
        if memory != nil {
            memory!.date = dateTextField.text
            memory!.subtext = subtextTextField.text
            memory!.image = UIImagePNGRepresentation(collegeImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let memory = Memory(context: context)
            
            memory.date = dateTextField.text
            memory.subtext = subtextTextField.text
            memory.image = UIImagePNGRepresentation(collegeImageView.image!) as NSData?
        }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Message", message: "Are you sure you want to delete this photo?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
            (alert:UIAlertAction!) in
            //****//
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(self.memory!)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.navigationController!.popViewController(animated: true)

        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
