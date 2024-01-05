//
//  TodoTableViewCell.swift
//  ToDo
//
//  Created by Joseph on 1/5/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {


    @IBOutlet weak var doneSwitch: UISwitch!

    var todo: Todo?

    // 왼료하면 밑줄
    @IBAction func switchChanged(_ sender: Any) {
        guard let todo else { return }
        if doneSwitch.isOn {
            textLabel?.text = nil
            textLabel?.attributedText = todo.title.strikeThrough()
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = todo.title
        }
    }

    func setTask(_ _todo: Todo) {
        todo = _todo
        guard let todo else { return }
        if todo.isCompleted {
            textLabel?.text = nil
            textLabel?.attributedText = todo.title.strikeThrough()
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = todo.title
        }
        doneSwitch.isOn = todo.isCompleted
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
