import UIKit
import RxSwift

// PublishSubject
let subject = PublishSubject<String>()
subject.onNext("Issue number 1")
// there are not subscriber

subject.subscribe({ event in 
    print(event)
})
//connect subscribe

subject.onNext("Issue number 2")
//print(Issue number 2)

//subject.dispose()

//subject.onCompleted()

subject.onNext("Issue number 3")
// ignored becasue of dispose
// emit value also subscribe


// BehaviorSubject
let subject1 = BehaviorSubject(value: "Initial Value")

//subject1.onNext("Last Value")

subject1.subscribe({ event in
    print(event)
})

subject1.onNext("Issue number 1")

let subject2 = ReplaySubject<String>.create(bufferSize: 2)

subject2.onNext("Issue 1")
subject2.onNext("Issue 2")
subject2.onNext("Issue 3")

subject2.subscribe({
    print($0)
})
//"Issue 2""Issue 3"

