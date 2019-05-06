# RxSwift
- http://reactivex.io/

## ReativeX 
> An API for asynchronous programming with observable streams

- Observable
- Operators
- Scheduler
- Subject
- Single

## Observable
- 동기 : 다른 작업을 막고 있음 기다린다
- 비동기 : 다른 작업과 상관없이 진행한다

RxSwift의 목적 : 비동기 작업을 간결하게 쓰고싶다. 

Observable이 리턴된다.
next로 전달한다.

disposable - 취소시킬 수 있음  
disposeBag - dispose를 담는 가방  
dispose = DisposeBag() 초기화 다 제거된다.

### just
just - 바로 전달 해준다. 
무엇을 넣으면 무엇이 그대로 나오는 효과
observable.just("hello")
hello가 그대로 전달된다.

### from
from - 어레이 하나씩 하나씩 내려옴.

### map
map - 붙혀서 전달
위에 있는걸 받아서 밑으로 전달해줌.

### filter
filter - 걸러서 내려가거나 안내려 가거나.
true일때만 내려간다.

### 스트림은 흐름 
.map
.map
.filter

####
- 생성 - create just from 
- 변환 - map
- 필터 - filter
- 결합 
- 오류처리  
