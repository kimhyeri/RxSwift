import UIKit
import RxSwift

//Observable class에 just를 사용함.
let observable1 = Observable.just(1)

// let observable2: Observable<Int> array아님
let observable2 = Observable.of(1,2,3)

// let observable3: Observable<[Int]> element 배열 방출
let observable3 = Observable.of([1,2,3])

//let observable4: Observable<Int> 각각의 element 방출
let observable4 = Observable.from([1,2,3,4,5])

// can access - next event
/*
next(1)
next(2)
next(3)
next(4)
next(5)
completed
 */
observable4.subscribe{ event in
    print(event)
}

/*
 1
 2
 3
 4
 5
 */
observable4.subscribe{ event in
    if let element = event.element {
        print(element)
    }
}

// next([1, 2, 3])
observable3.subscribe { event in 
    print(event)
}

// [1, 2, 3]
observable3.subscribe { event in 
    if let element = event.element {
        print(element)
    }
}

observable4.subscribe(onNext: { element in 
    print(element)
})

//disposing1

let subscription4 = observable4.subscribe(onNext: { element in 
    print(element)
})

subscription4.dispose()

// disposing2

let disposeBag = DisposeBag()

Observable.of("A","B","C")
    .subscribe {
        print($0)
}.disposed(by: disposeBag)

// disposing3 
// create Observable
Observable<String>.create { observer in
    observer.onNext("A")
    observer.onCompleted()
    observer.onNext("?") // never call
    return Disposables.create()
    }.subscribe(onNext: {
        print($0)
    }, onError: { 
        print($0)
    }, onCompleted: { 
        print("complete")
    }, onDisposed: { 
        print("dispose")
    }).disposed(by: disposeBag)
