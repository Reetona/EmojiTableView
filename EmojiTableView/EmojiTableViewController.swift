//
//  EmojiTableViewController.swift
//  EmojiTableView
//
//  Created by Adele Fatkullina on 21.12.2020.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var objects = [Emoji(emoji: "🥶", name: "Cold", description: "Awwwwshhhh", isFavourite: false),
                   Emoji(emoji: "🥱", name: "Wannasleep", description: "Hrrrrrraaaawwww", isFavourite: false),
                   Emoji(emoji: "🥴", name: "Drunk", description: "Cmtmemysweety", isFavourite: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.title = "Emoji Reader"
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
      /*  //registration of cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")*/
    }
    
    
//информация из 2 вью для добавления в таблицу
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.emoji
        
 //если ячейка была выделена то редактируем ячейку. Если нет - добавляем
        if let selectedIP = tableView.indexPathForSelectedRow {
            objects[selectedIP.row] = emoji
            tableView.reloadRows(at: [selectedIP], with: .fade)
        } else {
        let newIP = IndexPath(row: objects.count, section: 0)
        objects.append(emoji)
            tableView.insertRows(at: [newIP], with: .fade)
            
        }
    }
    
 //передача данных на 2 вью для редактирования
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        
        let emoji = objects[indexPath.row]
        //добраться до нужного можно только через навигейшен вью
        let navigationVC = segue.destination as! UINavigationController
        let newEmojiVC = navigationVC.topViewController as! NewEmojiTableViewController
        newEmojiVC.emoji = emoji
        newEmojiVC.title = "Edit"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //создали кастомную ячейку
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        /*
        cell.nameLabel.text = object.name
        cell.emojiLabel.text = object.emoji
        cell.descriptionLabel.text = object.description
 */
        // Configure the cell...

        return cell
    }

//стиль кругляшей слева
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
//delete object
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
//moving true
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
//move object
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
 //left swipe
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }

    //delete
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            //action is all
            completion(true)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "trash.circle")
        return action
    }
    
    //makefavourite
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPink : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
    
    
}
