## Observables also known as Sequences

### The key advantage for an observable vs Swift's sequence is that it can also receive elements asynchronously.
- Observable(ObservableType) is equivalent to Sequence  
Observable(ObservableType)는 Sequence와 동일하다.
- ObservableType.subscribe method is equivalent to Sequence.makeIterator method.  
ObservableType.subscribe메소드는 Sequence.makeIterator메소드와 동일하다.
- Observer (callback) needs to be passed to ObservableType.subscribe method to receive sequence elements instead of calling next() on the returned iterator.  
시퀀스 element를 받을려면 ObservableType.subscribe메소드에 Observer를 전달해야한다.

- 시퀀스는 시각화하기 쉽고 간단하고 익숙한 개념이다.

#### next* (error | completed)?
- 시퀀스는 0 개 이상의 요소를 가질 수 있다.
- 오류 또는 완료된 이벤트가 수신되면 시퀀스는 다른 요소를 생성 할 수 없다.

```
enum Event<Element>  {
    case next(Element)      // next element of a sequence
    case error(Swift.Error) // sequence failed with error
    case completed          // sequence terminated successfully
}

class Observable<Element> {
    func subscribe(_ observer: Observer<Element>) -> Disposable
}

protocol ObserverType {
    func on(_ event: Event<Element>)
}
```

- When a sequence sends the completed or error event all internal resources that compute sequence elements will be freed.  
시퀀스가 완료 또는 오류 이벤트를 전송하면 내부 자원(compute sequence elements)이 모두 해제된다.

- To cancel production of sequence elements and free resources immediately, call dispose on the returned subscription.  
시퀀스 elements의 생성을 취소하고 자원을 즉시 해제하려면 dispose를 호출해라.

- Using dispose bags or takeUntil operator is a robust way of making sure resources are cleaned up. We recommend using them in production even if the sequences will terminate in finite time.  
dispose bags 이나 takeUntil 연산자를 사용하면 자원을 정리할 수 있다. 시퀀스가 유한 한 시간 안에 종료 되더라도 프로덕션에서 사용하는 것이 좋다.
