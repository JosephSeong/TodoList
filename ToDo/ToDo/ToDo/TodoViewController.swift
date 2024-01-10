//
//  TodoViewController.swift
//  ToDo
//
//  Created by Joseph on 12/20/23.
//

import UIKit

class TodoViewController: UIViewController {

    // 할 일 리스트 배열
    //var todos: [Todo] = [Todo(id: 0, title: "TIL", isCompleted: false)]
    var todos: [Todo] = []

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


    // MARK: - 추가
    @IBAction func addButton(_ sender: Any) {
        var textField = UITextField()

        let alert = UIAlertController(title: "할 일 추가하기", message: "", preferredStyle: .alert)

        let cancel = UIAlertAction(title: "취소", style: .default) { (cancel) in }

        let save = UIAlertAction(title: "추가", style: .default) { (save) in
            // 입력된 텍스트로 새로운 할 일 생성
            guard let newTitle = textField.text, !newTitle.isEmpty else { return }
            //let newTodo = Todo(id: self.todos.count, title: newTitle, isCompleted: false)

            // 카테고리 입력 받기
            var categoryTextField = UITextField()
            let categoryAlert = UIAlertController(title: "카테고리 입력", message: "할 일의 카테고리를 입력하세요.", preferredStyle: .alert)
            categoryAlert.addTextField { (textField) in
                categoryTextField = textField
                categoryTextField.placeholder = "카테고리"
            }

            let categorySave = UIAlertAction(title: "확인", style: .default) { (action) in
                guard let category = categoryTextField.text, !category.isEmpty else { return }

                // 입력된 텍스트로 새로운 할 일 및 카테고리 생성
                let newTodo = Todo(id: self.todos.count, title: newTitle, isCompleted: false, category: category)

                // 생성한 할 일을 배열에 추가하고 테이블뷰 갱신
                self.todos.append(newTodo)
                self.TodoTable.reloadData()

                // UserDefaults에 저장
                self.saveTodo()
            }
            categoryAlert.addAction(categorySave)
            self.present(categoryAlert, animated: true, completion: nil)
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

    // UserDefaults에 Todos 저장
    func saveTodo() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(todos) {
            UserDefaults.standard.set(encodedData, forKey: "todos")
        }
    }

//    // UserDefaults에 Todos 저장 (에러처리)
//    func saveTodo() {
//        let encoder = JSONEncoder()
//        do {
//            // 할 일 목록을 JSON 데이터로 인코딩
//            let encodedData = try encoder.encode(todos)
//            // 인코딩된 데이터를 UserDefaults에 저장
//            UserDefaults.standard.set(encodedData, forKey: "todos")
//        } catch {
//            print("todos를 저장하는 중 오류 발생: \(error)")
//        }
//    }

    // UserDefaults에서 Todos 불러오기
    func loadTodo() {
        if let savedData = UserDefaults.standard.data(forKey: "todos"),
           // 가져온 데이터를 Todo 객체의 배열로 디코딩(실패하면 nil)
           let loadedTodos = try? JSONDecoder().decode([Todo].self, from: savedData) {
            // 디코딩된 할 일 목록을 현재의 todos 배열에 할당
            todos = loadedTodos
        }
    }


    // MARK: - 수정
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


// MARK: - extension
extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    // 테이블뷰 셀 개수 반환
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return todos.count
        let category = Array(Set(todos.map { $0.category }))[section]
        return todos.filter { $0.category == category }.count
    }

    // 테이블뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todocell", for: indexPath) as! TodoTableViewCell
        //cell.setTask(todos[indexPath.row])
        let category = Array(Set(todos.map { $0.category }))[indexPath.section]
        let categoryTodos = todos.filter { $0.category == category }
        cell.setTask(categoryTodos[indexPath.row])

        // 셀을 탭하면 수정할 수 있는 알림창 표시
        let tapCell = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
        cell.addGestureRecognizer(tapCell)

        return cell
    }

    // MARK: - 삭제
    // 테이블뷰 셀 스와이프 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            // Section에 대한 카테고리 선택
            let category = Array(Set(todos.map { $0.category }))[indexPath.section]
            // 해당 Section에 속하는 할 일들만 필터링
            let categoryTodos = todos.filter { $0.category == category }

            // 선택된 셀의 할 일 삭제 및 테이블뷰 갱신
            todos.remove(at: indexPath.row)
            TodoTable.deleteRows(at: [indexPath], with: .fade)

            // 새로운 할 일 목록을 todos 배열에 업데이트하고 UserDefaults에 저장
            todos = todos.filter { $0.category != category } + categoryTodos   // todos += categoryTodos (categoryTodos 배열에 속하는 할 일들을 기존의 todos 배열에 추가)
            saveTodo()

            // 디버깅
            print("\(indexPath.row)번 인덱스의 작업이 삭제")
            print("업데이트된 todos 배열: \(todos)")
        }
    }

    // Section의 수를 결정하는 메서드
    func numberOfSections(in tableView: UITableView) -> Int {
        // todos 배열에서 카테고리를 찾아 개수 반환 (Set을 사용하여 todos 배열에서 중복 제거)
        let uniqueCategories = Set(todos.map { $0.category })
        return uniqueCategories.count
    }

    // Section Header에 나타날 글자를 설정하는 메서드
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Array(Set(todos.map { $0.category }))[section]
    }
}
