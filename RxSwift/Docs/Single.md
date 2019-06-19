# Single

- Single은 Obvservable의 한 형태이지만, Observable처럼 존재하지 않는 곳에서부터 무한대까지의 임이의 연속된 값들을 배출하는 것과는 달리, 항상 한 가지 값 또는 오류 알림 둘 중 하나만 배출한다.
- Single을 구독할 때는 Observable을 구독할 때 사용하는 세 개의 메서드(onNext, onError, 그리고 onCompleted) 대신 다음의 두 메서드만 사용할 수 있다.
    - onSuccess - Single은 자신이 배출하는 하나의 값을 이 메서드를 통해 전달한다
    - onError - Single은 항목을 배출할 수 없을 때 이 메서드를 통해 Throwable 객체를 전달한다
    - Single은 이 메서드 중 하나만 그리고, 한 번만 호출한다. 메서드가 호출되면 Single의 생명주기는 끝나고 구독도 종료된다.

## Composition via Single Operators


