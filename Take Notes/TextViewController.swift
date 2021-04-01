//
//  TextViewController.swift
//  Take Notes
//
//  Created by Caio Fernandes on 31/03/21.
//

import UIKit
import CoreData

class TextViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var context: NSManagedObjectContext!
    
    @IBAction func saveText(_ sender: Any) {
        saveNote()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveNote() {
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Notes", into: context)
        
        newNote.setValue(textView.text, forKey: "text")
        newNote.setValue(Date(), forKey: "date")
        
        do {
            try context.save()
        } catch let error as Error {
            print("Error: \(error.localizedDescription)")
        }
    }

}
