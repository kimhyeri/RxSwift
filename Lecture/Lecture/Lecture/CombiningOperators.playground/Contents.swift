import UIKit
import RxSwift

// Combining Operators

let disposeBag = DisposeBag()

// startswith
// insert value 

let numbers = Observable.of(2,3,4)
let observable  = numbers.startWith(1)

observable.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

// concat 
// joining sequence together

let first = Observable.of(1,2,3)
let second = Observable.of(4,5,6)

let observable1 = Observable.concat([first, second])
observable1.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

// merge
// based on alive value 

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let source = Observable.of(left.asObservable(),right.asObservable())
let observable2 = source.merge()
observable2.subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

left.onNext(5)
left.onNext(3)
right.onNext(2)
right.onNext(1)
left.onNext(99)

// combine latest

let left1 = PublishSubject<Int>()
let right1 = PublishSubject<Int>()

let observable3 = Observable.combineLatest(left,right,resultSelector: {
    lastLeft, lastRight in 
    "\(lastLeft) \(lastRight)" 
})

let disposable = observable3.subscribe(onNext: { value in
    print(value)
})

left1.onNext(45)
right1.onNext(1)
left1.onNext(30)
left1.onNext(1)
right1.onNext(1)

// with latest from

let button = PublishSubject<Void>()
let textField = PublishSubject<String>()

let observable4 = button.withLatestFrom(textField)
let disposable1 = observable4.subscribe(onNext: {
    print($0)
})

textField.onNext("Sw")
textField.onNext("Swif")
textField.onNext("Swift")

button.onNext(())
button.onNext(()) // print latest value

// reduce
// get particular value 
// seed : start value 

let source1 = Observable.of(1,2,3)

// #1 
source1.reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

// #2
source1.reduce(0, accumulator: {
    summary, newValue in 
    return summary + newValue
}).subscribe(onNext: {
    print($0)
}).disposed(by: disposeBag)

// scan
// update value 
// based on body condition 

let source2 = Observable.of(1,2,3,4,5,6)

source2.scan(0, accumulator: +)
    .subscribe(onNext : {
        print($0)
    }).disposed(by: disposeBag)


