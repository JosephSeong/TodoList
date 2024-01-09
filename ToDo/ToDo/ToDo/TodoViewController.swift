//
//  TodoViewController.swift
//  ToDo
//
//  Created by Joseph on 12/20/23.
//

import UIKit

class TodoViewController: UIViewController {

    // 할 일 리스트 배열
    var todos: [Todo] = [Todo(id: 0, title: "TIL", isCompleted: false)]

    @IBOutlet weak var TodoTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 테이블뷰의 델리게이트와 데이터 소스 설정
        TodoTable.delegate = self
        TodoTable.dataSource = self

        // UserDefaults에서 Todos 불러오기
        loadTodo()
        TodoTable.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // UserDefaults에서 Todos 불러오기 (업데이트가 있을 경우)
        loadTodo()
        TodoTable.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)


    }


    @IBAction func addButton(_ sender: Any) {
        var textField = UITextField()

        let alert = UIAlertController(title: "할 일 추가하기", message: "", preferredStyle: .alert)

        let cancel = UIAlertAction(title: "취소", style: .default) { (cancel) in }

        let save = UIAlertAction(title: "추가", style: .default) { (save) in
            // 입력된 텍스트로 새로운 할 일 생성
            guard let newTitle = textField.text, !newTitle.isEmpty else { return }
            let newTodo = Todo(id: self.todos.count, title: newTitle, isCompleted: false)

            // 생성한 할 일을 배열에 추가하고 테이블뷰 갱신
            self.todos.append(newTodo)
            self.TodoTable.reloadData()

            // UserDefaults에 저장
            self.saveTodo()
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

    // Todos를 UserDefaults에 저장하는 함수
    func saveTodo() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(todos) {
            UserDefaults.standard.set(encodedData, forKey: "todos")
        }
    }

    // UserDefaults에서 Todos를 불러오는 함수
    func loadTodo() {
        if let savedData = UserDefaults.standard.data(forKey: "todos"),
           let loadedTodos = try? JSONDecoder().decode([Todo].self, from: savedData) {
            todos = loadedTodos
        }
    }

    // 셀을 탭하면 수정할 수 있는 알림창 표시
    @objc func cellTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view as? TodoTableViewCell,
           let indexPath = TodoTable.indexPath(for: cell) {
            let todoToUpdate = todos[indexPath.row]

            var textField = UITextField()

            let alert = UIAlertController(title: "할 일 수정하기", message: "", preferredStyle: .alert)

            let cancel = UIAlertAction(title: "취소", style: .default) { (cancel) in }

            let save = UIAlertAction(title: "수정", style: .default) { (save) in
                // 입력된 텍스트로 할 일 수정
                guard let updatedTitle = textField.text, !updatedTitle.isEmpty else { return }

                // 수정된 할 일을 배열에 업데이트하고 테이블뷰 갱신
                self.todos[indexPath.row].title = updatedTitle
                self.TodoTable.reloadRows(at: [indexPath], with: .fade)

                // UserDefaults에 저장
                self.saveTodo()
            }

            alert.addTextField { (text) in
                textField = text
                textField.text = todoToUpdate.title
            }

            // 액션 추가
            alert.addAction(cancel)
            alert.addAction(save)

            // 알림창 표시
            present(alert, animated: true, completion: nil)
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todocell", for: indexPath) as! TodoTableViewCell
        cell.setTask(todos[indexPath.row])

        // 추가: 셀을 탭하면 수정할 수 있는 알림창 표시
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        cell.addGestureRecognizer(tapGesture)


        return cell
    }

    // 테이블뷰 셀 스와이프 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 선택된 셀의 할 일 삭제 및 테이블뷰 갱신
            todos.remove(at: indexPath.row)
            TodoTable.deleteRows(at: [indexPath], with: .fade)

            // UserDefaults에서 삭제
            saveTodo()
        }
    }
}
