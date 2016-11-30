//
//  ProfileViewController.swift
//  Selfigram
//
//  Created by Alejandra Anderson on 2016-11-08.
//  Copyright © 2016 Alejandra Anderson. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ProfileImageView: UIImageView!
   
    
    @IBAction func cameraButtonPressed(_ sender: AnyObject) {
        
        // 1: Create an ImagePickerController
        let pickerController = UIImagePickerController()
        
        // 2: Self in this line refers to this View Controller
        //    Setting the Delegate Property means you want to receive a message
        //    from pickerController when a specific event is triggered.
        pickerController.delegate = self
        
        if TARGET_OS_SIMULATOR == 1 {
            // 3. We check if we are running on a Simulator
            //    If so, we pick a photo from the simulator’s Photo Library
            // We need to do this because the simulator does not have a camera
            pickerController.sourceType = .photoLibrary
        } else {
            // 4. We check if we are running on an iPhone or iPad (ie: not a simulator)
            //    If so, we open up the pickerController's Camera (Front Camera, for selfies!)
            pickerController.sourceType = .camera
            pickerController.cameraDevice = .front
            pickerController.cameraCaptureMode = .photo
        }
        
        // Preset the pickerController on screen
        self.present(pickerController, animated: true, completion: nil)


        print("Camera Button Pressed")
    }
    
    
    
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            // setting the compression quality to 90%
//            if let imageData = UIImageJPEGRepresentation(image, 0.9),
//                let imageFile = PFFile(data: imageData),
//                let user = PFUser.current(){
//                
//                //2. We create a Post object from the image
//                let post = Post(image: imageFile, user: user, comment: "A Selfie")
//                
//                post.saveInBackground(block: { (success, error) -> Void in
//                    if success {
//                        print("Post successfully saved in Parse")
//                        
//                        //3. Add post to our posts array, chose index 0 so that it will be added
//                        //   to the top of your table instead of at the bottom (default behaviour)
//                        self.posts.insert(post, at: 0)
//                        
//                        //4. Now that we have added a post, updating our table
//                        //   We are just inserting our new Post instead of reloading our whole tableView
//                        //   Both method would work, however, this gives us a cool animation for free
//                        
//                        let indexPath = IndexPath(row: 0, section: 0)
//                        self.tableView.insertRows(at: [indexPath], with: .automatic)
//                    }
//                })
//            }
//        }
//        
//        //4. We remember to dismiss the Image Picker from our screen.
//        dismiss(animated: true, completion: nil)
//        
//        //5. Now that we have added a post, reload our table
//        tableView.reloadData()
//        
//    }
//    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 1. When the delegate method is returned, it passes along a dictionary called info.
        //    This dictionary contains multiple things that maybe useful to us.
        //    We are getting an image from the UIImagePickerControllerOriginalImage key in that dictionary
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // setting the compression quality to 90%
            if let imageData = UIImageJPEGRepresentation(image, 0.9),
                let imageFile = PFFile(data: imageData),
                let user = PFUser.current(){
                
                // avatarImage is a new column in our User table
                user["avatarImage"] = imageFile
                user.saveInBackground(block: { (success, error) -> Void in
                    if success {
                        // set our profileImageView to be the image we have picked
                        let image = UIImage(data: imageData)
                        self.ProfileImageView.image = image
                    }
                })
                
            }
            
        }
        
        //3. We remember to dismiss the Image Picker from our screen.
        dismiss(animated: true, completion: nil)
        
    }
    
   
    //@IBOutlet weak var profileImageView: UIImageView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       usernameLabel.text = "Alejandra"
       // super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let user = PFUser.current(){
            usernameLabel.text = user.username
            
            if let imageFile = user["avatarImage"] as? PFFile {
                
                imageFile.getDataInBackground(block: { (data, error) -> Void in
                    if let imageData = data {
                      self.ProfileImageView.image = UIImage(data: imageData)
                    }
                })
            }
        }
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
