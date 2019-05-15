## Observables also known as Sequences

### The key advantage for an observable vs Swift's sequence is that it can also receive elements asynchronously.
- Observable(ObservableType) is equivalent to Sequence  
Observable(ObservableType)는 Sequence와 동일하다.
- ObservableType.subscribe method is equivalent to Sequence.makeIterator method.  
ObservableType.subscribe메소드는 Sequence.makeIterator메소드와 동일하다.
- Observer (callback) needs to be passed to ObservableType.subscribe method to receive sequence elements instead of calling next() on the returned iterator.  
시퀀스 element를 받을려면 ObservableType.subscribe메소드에 Observer를 전달해야한다.

- 시퀀스는 시각화하기 쉽고 간단하고 익숙한 개념이다.
- 시퀀스는 0 개 이상의 요소를 가질 수 있다.
- 오류 또는 완료된 이벤트가 수신되면 시퀀스는 다른 요소를 생성 할 수 없다.
