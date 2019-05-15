## Disposing
- When we are done with a sequence and we want to release all of the resources allocated to compute the upcoming elements, we can call dispose on a subscription.  
시퀀스를 완료하고 다음 요소를 계산하기 위해 할당 된 모든 리소스를 해제하고자 할 때 subscription에 대해 dispose를 호출할 수 있다.

- example with the interval operator
```
let scheduler = SerialDispatchQueueScheduler(qos: .default)
let subscription = Observable<Int>.interval(.milliseconds(300),     scheduler: scheduler)
    .subscribe { event in
    print(event)
}

Thread.sleep(forTimeInterval: 2.0)

subscription.dispose()
```

- print
```
0
1
2
3
4
5
```
- 위와 같이 수동으로 dispose를 호출하는것 보다 DisposeBag, takeUntil연산자로 처리하는게 더 좋다.

## Dispose Bags
> Dispose bags are used to return ARC like behavior to RX.

- When a DisposeBag is deallocated, it will call dispose on each of the added disposables.  
DisposeBag가 할당 해제되면 추가 된 각 disposables에서 dispose를 호출한다.

- It does not have a dispose method and therefore does not allow calling explicit dispose on purpose. If immediate cleanup is required, we can just create a new bag.  
dispose 메서드가 없어 명시적으로 dispose 메서드를 호출 할 수 없다. 즉각적인 정리가 필요한 경우 새 bag을 만들 수 있습니다.

```
self.disposeBag = DisposeBag()
```
- This will clear old references and cause disposal of resources.

- If that explicit manual disposal is still wanted, use CompositeDisposable. It has the wanted behavior but once that dispose method is called, it will immediately dispose any newly added disposable.  
명시적인 수동 처리가 여전히 필요한 경우에는 CompositeDisposable을 사용하십시오. 그것은 원하는 동작을 가지지 만 일단 dispose 메소드가 호출되면 새로 추가 된 일회용품을 즉시 처리합니다.


## Take until
- Additional way to automatically dispose subscription on dealloc is to use takeUntil operator.  
dealloc에 ​​대한 subscription을 자동으로 처리하는 추가적인 방법은 takeUntil 연산자를 사용하는 것이다.

```
sequence
    .takeUntil(self.rx.deallocated)
    .subscribe {
        print($0)
    }
```

