//
//  NewEmojiTableViewController.swift
//  EmojiTableView
//
//  Created by Adele Fatkullina on 21.12.2020.
//

//cmd A ctrl I
import UIKit

class NewEmojiTableViewController: UITableViewController {
    //для передачи на другой вью
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var emojiTeFi: UITextField!
    @IBOutlet weak var nameTeFi: UITextField!
    @IBOutlet weak var descriptionTeFi: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        updateUI()
    }
    
    // MARK: - Table view data source
    //because static
    /*   override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     // #warning Incomplete implementation, return the number of rows
     return 0
     }
     */
    private func updateSaveButtonState() {
        let emojiText = emojiTeFi.text ?? ""
        let nameText = nameTeFi.text ?? ""
        let descriptionText = descriptionTeFi.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    private func updateUI() {
        emojiTeFi.text = emoji.emoji
        nameTeFi.text = emoji.name
        descriptionTeFi.text = emoji.description
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    //срабатывает перед тем как использовать сегвэй (перед перемещением со 2 экрана на первый)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let emoji = emojiTeFi.text ?? ""
        let name = nameTeFi.text ?? ""
        let description = descriptionTeFi.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
    }
    
}
