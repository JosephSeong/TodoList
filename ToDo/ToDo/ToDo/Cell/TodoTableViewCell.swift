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
        // todo 객체가 존재하는지 확인
        guard var todo else { return }

        // todo 객체의 완료 상태를 갱신
        todo.isCompleted = doneSwitch.isOn


        if doneSwitch.isOn {
            textLabel?.text = nil
            textLabel?.attributedText = todo.title.strikeThrough()
        } else {
            textLabel?.attributedText = nil
            textLabel?.text = todo.title
        }

        print(#function)
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
