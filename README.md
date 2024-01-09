# Todo List

## Create (생성)
- addButton 함수에서 새로운 Todo를 생성하고 UserDefaults에 저장한다. 
- 새로운 Todo가 생성되면 saveTodo 함수가 호출되어 현재의 Todo 배열을 UserDefaults에 저장한다.

## Read (읽기)
- viewWillAppear에서 loadTodo 함수를 호출하여 UserDefaults에서 Todo 데이터를 로드하고 테이블뷰를 갱신한다. 
- 앱이 활성화될 때마다 최신 데이터를 보여준다.

## Update (수정)
- Todocell을 탭하면 수정할 수 있는 알림창을 표시한다.
- 수정을 완료하면 UserDefaults에 저장한다.

## Delete (삭제)
- 테이블뷰에서 셀을 삭제할 때마다 데이터가 일관되게 유지된다.
