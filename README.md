# AWS-Configure-Registrer-Script

# 자격증명 편리하게 하려고 만들었다.
명령어 한개로 프로필과 리전 설정을 한 번에 할 수 있다.

- OS : Linux Ubuntu
- 사전 설치 패키지 : `pass`

> 발견된 버그 ) 
1. export 환경변수 설정 불가. 
-> `~/.bashrc` 에 function aws-login() { source aws-login.sh }로 해결
>
2. default region 변경 불가.

## 사용 설명

프로필 입력을 default로 하면 pass에는 없는 값이므로 환경변수의 access key, secret key 값들은 undefined으로 "" 된다.
따라서 pass에 아래와 같이 key 값을 등록한다.

![](https://images.velog.io/images/jm1225/post/c0ac57c3-05ec-48a8-9c4b-8aad65065767/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7,%202022-03-23%2012-07-39.png)

프로필과 pass 패키지 존재 유무 확인은 시간상 건너띄었다.
필요하다고 느끼면 수정할 계획이다.

___

# export 환경변수 설정불가 문제

bash에서 쉘 스크립트 파일을 실행 시 자식 프로세스가 부모 프로세스에게 return값만 전달한다.
따라서 자식 bash에서 export로 등록하려고 하여도 설정이 되지 않았다.

![](https://images.velog.io/images/jm1225/post/cbd6f36b-ab97-4e82-853c-749288b19f98/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7,%202022-03-23%2011-24-00.png)
___

## 해결 방안

1. 아래 ScreenShot과 같이 기존에 하드링크 걸어두었던 파일을 삭제하고.

![](https://images.velog.io/images/jm1225/post/18810b31-77b5-405a-be1f-b180163c0038/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7,%202022-03-23%2011-25-51.png)

2. 부모 bash안에 func. 함수를 삽입하여 자식 bash를 source로 불러오게 하였다.

![](https://images.velog.io/images/jm1225/post/521cc8b8-9024-41d6-b8e2-bfa566174d88/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7,%202022-03-23%2011-27-17.png)
![](https://images.velog.io/images/jm1225/post/1656d5a3-d9ba-477a-9218-3f8e523f6642/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7,%202022-03-23%2011-27-46.png)
![](https://images.velog.io/images/jm1225/post/e55ae832-f1f9-4e7c-9059-c03e296af70a/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7,%202022-03-23%2011-28-15.png)


