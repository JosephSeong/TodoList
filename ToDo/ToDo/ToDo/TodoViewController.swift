//
//  TodoViewController.swift
//  ToDo
//
//  Created by Joseph on 12/20/23.
//

import UIKit

class TodoViewController: UIViewController {

    // 할 일 데이터 모델 정의
    struct Todo {
        var title: String
        var isCompleted: Bool
    }

    // 할 일 리스트 배열
    var todos = [Todo]()

    @IBOutlet weak var TodoTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 테이블뷰의 델리게이트와 데이터 소스 설정
        TodoTable.delegate = self
        TodoTable.dataSource = self
    }

    @IBAction func addButton(_ sender: Any) {
        var textField = UITextField()

        let alert = UIAlertController(title: "할 일 추가하기", message: "", preferredStyle: .alert)

        let cancel = UIAlertAction(title: "취소", style: .default) { (cancel) in }

        let save = UIAlertAction(title: "추가", style: .default) { (save) in
            // 입력된 텍스트로 새로운 할 일 생성
            guard let newTitle = textField.text, !newTitle.isEmpty else { return }
            let newTodo = Todo(title: newTitle, isCompleted: false)

            // 생성한 할 일을 배열에 추가하고 테이블뷰 갱신
            self.todos.append(newTodo)
            self.TodoTable.reloadData()
        }

        alert.addTextField { (text) in
            textField = text
            textField.placeholder = "할 일 추가하기"
        }

        // 액션 추가
        alert.addAction(cancel)
        alert.addAction(save)

        // 알림창 표시
        present(alert, animated: true, completion: nil)
    }

    @IBAction func todoComplete(_ sender: Any) {
    }

}

// 테이블뷰 델리게이트 및 데이터 소스 구현
extension TodoViewController: UITableViewDelegate, UITableViewDataSource {

    // 테이블뷰 셀 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    // 테이블뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todocell", for: indexPath)

        // 해당 인덱스에 해당하는 할 일 데이터로 셀 설정
        let todo = todos[indexPath.row]
        cell.textLabel?.text = todo.title

        return cell
    }

    // 테이블뷰 셀 스와이프 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 선택된 셀의 할 일 삭제 및 테이블뷰 갱신
            todos.remove(at: indexPath.row)
            TodoTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
