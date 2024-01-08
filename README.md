# Todo List

## Create (생성)
- addButton 함수에서 새로운 Todo를 생성하고 UserDefaults에 저장한다. 
- 새로운 Todo가 생성되면 saveTodo 함수가 호출되어 현재의 Todo 배열을 UserDefaults에 저장한다.

## Read (읽기)
- viewWillAppear에서 loadTodo 함수를 호출하여 UserDefaults에서 Todo 데이터를 로드하고 테이블뷰를 갱신한다. 
- 앱이 활성화될 때마다 최신 데이터를 보여준다.

## Update (수정)
- updateTodo 함수를 통해 Todo 데이터를 배열에서 업데이트하고 업데이트된 배열을 UserDefaults에 저장한다.
- 이를 통해 Todo가 완료되었는지 여부를 스위치로 변경할 때마다 데이터가 일관되게 유지된다.

## Delete (삭제)
- deleteTodo 함수를 사용하여 배열에서 Todo를 삭제하고 삭제된 배열을 UserDefaults에 저장한다.
- 테이블뷰에서 셀을 삭제할 때마다 데이터가 일관되게 유지된다.
