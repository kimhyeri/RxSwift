# Observable

- ReactiveX에서 옵저버는 Observable을 구독한다.
- 옵저버는 Obervable이 배출하는 하나 또는 연속된 아이템에 반응한다. (concurrent operations을 가능하게 함) Observable이 객체를 배출할 때까지 기다릴 필요 없이 어떤 객체가 배출되면 그 시점을 감시하는 관찰자 옵저버를 통해 배출 알림을 받기 때문이다.

![ ](./image/ObservableImage.png)

## Establishing Observers

- 일반적인 메소드 호출 흐름
    - 메소드를 호출한다.
    - 메소드가 리턴한 값을 변수에 저장한다.
    - 결과 값을 가진 변수를 통해 필요한 연산을 처리한다.
    
- 비동기 모델에서의 메소드 호출 흐름
    - 비동기 메소드 호출로 결과를 리턴받고 필요한 동작을 처리하는 메소드를 정의한다.
    - Observable로 비동기 호출을 정의한다.
    - 구독을 통해 옵저버를 Observable객체에 연결시킨다.
    - 필요한 코드를 계속 구현한다. 메소드 호출로 결과가 리턴될 때마다, 옵저버의 메소드는 리턴 값 또는 Observable이 배출한 것을 사용해서 연산을 시작한다.

## onNext, onCompleted, onError
> Subscribe 메소드를 통해 옵저버와 Observable을 연결한다. 

- onNext
    - Observable은 새로운 항목들을 배출할 때마다 이 메소드를 호출한다.
    - 이 메소드는 Observable이 배출하는 항목을 파라미터로 전달 받는다.
    - 0번 이상 호출 될 수 있으며 후에는 onCompleted나 onError중 하나를 마지막으로 호출한다.
- onCompleted
    - 오류가 발생하지 않았다면 Observable은 마지막 onNext를 호출한 후 이 메소드를 호출한다.
- onError
    - Observable은 기대하는 데이터가 생성되지 않았거나 다른 이유로 오류가 발생할 경우 오류를 알리기 위해 이 메소드 호출한다. 이 메소드가 호출되면 onNext나 onCompleted는 더 이상 호출되지 않는다. onError메소드는 오류 정보를 저장하고 있는 객체를 파라미터로 전달 받는다.

```
def myOnNext     = { item -> /* do something useful with item */ };
def myError      = { throwable -> /* react sensibly to a failed call */ };
def myComplete   = { /* clean up after the final response */ };
def myObservable = someMethod(itsParameters);
myObservable.subscribe(myOnNext, myError, myComplete);
// go on about my business
```

## Unsubscribing

- ReactiveX에 Subscriber인터페이스에서 unsubscribe라는 메소드를 제공한다.
    - 구독 중인 Observable중, 옵저버가 더이상 구독을 원하지 않는 경우 이 메소드를 호출해서 구독을 해지할 수 있다.
    - unsubscribe는 연산자 체인을 통해 옵저버가 구독하고 있었던 Observable들이 더 이상 항목들을 배출하지 못하도록 체인 안에 연결된 링크들을 끊어 버린다.
    
## "Hot" and "Cold" Observables

- Hot Observable
    - A “hot” Observable may begin emitting items as soon as it is created, and so any observer who later subscribes to that Observable may start observing the sequence somewhere in the middle. 
    - 생성되자 마자 항목들을 배출하기도 함. 항목들이 배출되는 중간부터 Observable을 구독할 수 있음. 
- Cold Observable
    - A “cold” Observable, on the other hand, waits until an observer subscribes to it before it begins to emit items, and so such an observer is guaranteed to see the whole sequence from the beginning.
    - 옵저버가 구독할 때 까지 항목을 배출하지 않기 떄문에 Observable을 구독하는 옵저버는 Observable이 배출하는 항목 전체를 구독할 수 있음.

## Composition via Observable Operators

> Reactive extensions (ReactiveX) 연산자들은 Observable이 배출하는 연속된 항목을 변환시키고, 결합하고, 조작하는 기능들을 제공한다.

- Creating Observables
    - Create, Defer, Empty/Never/Throw, From, Interval, Just, Range, Repeat, Start, and Timer
- Transforming Observable Items
    - Buffer, FlatMap, GroupBy, Map, Scan, and Window
- Filtering Observables
    - Debounce, Distinct, ElementAt, Filter, First, IgnoreElements, Last, Sample, Skip, SkipLast, Take, and TakeLast
- Combining Observables
    - And/Then/When, CombineLatest, Join, Merge, StartWith, Switch, and Zip
- Error Handling Operators
    - Catch and Retry
- Utility Operators
    - Delay, Do, Materialize/Dematerialize, ObserveOn, Serialize, Subscribe, SubscribeOn, TimeInterval, Timeout, Timestamp, and Using
- Conditional and Boolean Operators
    - All, Amb, Contains, DefaultIfEmpty, SequenceEqual, SkipUntil, SkipWhile, TakeUntil, and TakeWhile
- Mathematical and Aggregate Operators
    - Average, Concat, Count, Max, Min, Reduce, and Sum
- Converting Observables
    - To
- Connectable Observable Operators
    - Connect, Publish, RefCount, and Replay
- Backpressure Operators
    - a variety of operators that enforce particular flow-control policies

## Chaining Operators

- 대부분의 연산자들은 Observable상에서 동작하고 Observable을 리턴한다.
- 이런 접근 방법은 연산자들을 하나의 Observable에 적용하고 또 다음 연산자에 다시 적용할 수 있는 연산자 체인을 제공한다. 
- 연산자 체인에 걸려있는 각각의 연산자들은 이전 연산자가 리턴한 Observable을 변경할 수 있다.
- Observable 연산자 체인은 원본 Observable과는 떨어져서 동작할 수 없으며 순서대로 동작하기 때문에, 이전에 호출된 연산자가 리턴한 Observable을 기반으로 실행된다. 
