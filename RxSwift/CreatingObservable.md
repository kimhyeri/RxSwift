## Creating your own Observable (observable sequence)
- When an observable is created, it doesn't perform any work simply because it has been created.  
- Observable just defines how the sequence is generated and what parameters are used for element generation.
- Sequence generation starts when subscribe method is called.

```
func searchWikipedia(searchTerm: String) -> Observable<Results> {}
```

```
let searchForMe = searchWikipedia("me")

// 작업이 수행되지 않는다. URL요청 실행 안된다.

let cancel = searchForMe
    // 시퀀스가 생성되고 URL요청이 시작된다.
    .subscribe(onNext: { results in
    print(results)
})
```

### Observable 스퀀스를 만드는 방법은 많음.

####  create함수 사용하기
- Subscribe method it takes one argument, observer, and returns disposable.
- Synchronous

```
func myFrom<E>(_ sequence: [E]) -> Observable<E> {
    return Observable.create { observer in
        for element in sequence {
            observer.on(.next(element))
        }

        observer.on(.completed)
        return Disposables.create()
    }
}

let stringCounter = myFrom(["first", "second"])

print("Started ----")

// first time
stringCounter
    .subscribe(onNext: { n in
        print(n)
    })

print("----")

// again
stringCounter
    .subscribe(onNext: { n in
        print(n)
    })

print("Ended ----")
```
```
Started ----
first
second
----
first
second
Ended ----
```

#### just함수 사용하기
- 하나의 원소를 받고 하나의 원소에 대한 Observable를 반환.
    
```
    func myJust<E>(_ element: E) -> Observable<E> {
        return Observable.create { observer in
            observer.on(.next(element))
            observer.on(.completed)
            return Disposables.create()
        }
    }


    myJust(0)
        .subscribe(onNext: { n in
        print(n)
    })

```
```
0
```
