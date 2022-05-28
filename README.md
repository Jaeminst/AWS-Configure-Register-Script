# AWS-Configure-Registrer-Script

## 명령어 한개로 프로필과 리전 설정을 한 번에 할 수 있다.

- OS : Linux Ubuntu, MacOS
- 사전 설치 패키지 : `pass`

# Install
## Ubuntu
```sh
$ sudo apt install pass -y
```

## MacOS
```sh
$ brew install --cask adur1990/tap/passformacos
```

## gpg 생성
```sh
$ gpg --full-generate-key

gpg (GnuPG) 2.2.4; Copyright (C) 2017 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1

RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits

Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 0
Key does not expire at all

Is this correct? (y/N) y

GnuPG needs to construct a user ID to identify your key.

Real name: Jaemin Lee
Email address: woals1245@gmail.com
Comment:
You selected this USER-ID:
    "Jaemin Lee <woals1245@gmail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
```

## gpg key 확인

```sh
$ gpg --list-secret-keys --keyid-format LONG
```
![스크린샷, 2022-05-28 23-06-22](https://user-images.githubusercontent.com/99124279/170828912-6104544a-3379-4cdb-86c1-861bff0e13eb.png)

## pass init
```sh
$ pass init 상단에서 확인한 key
pass init 123FD1238CF11234
```

## pass는 디렉토리 형식으로 저장됩니다.
```sh
$ pass insert aws/<username>/aws-access-key-id
mkdir: '/home/jaemin/.password-store/aws/jaemin' 디렉터리를 생성함
Enter password for aws/jaemin/aws-access-key-id: 여기에 엑세스 키 붙여넣고 엔터
Retype password for aws/jaemin/aws-access-key-id: 한번 더 똑같이 엑세스 키 넣고 엔터
```

## secret-access-key도 위와 같이 등록
```sh
$ pass insert aws/<username>/aws-secret-access-key
Enter password for aws/jaemin/aws-secret-access-key: 여기에 시크릿 키 붙여넣고 엔터
Retype password for aws/jaemin/aws-secret-access-key: 한번 더 똑같이 시크릿 키 넣고 엔터
```

## pass에 aws keys 등록 완료
![스크린샷, 2022-05-28 23-36-14](https://user-images.githubusercontent.com/99124279/170830050-521fcf19-1ff2-45eb-b5fb-7b1fec95f71b.png)

## aws profile 등록
```sh
$ aws configure --profile <Your Name>

aws configure --profile jaemin
... 아무키나 입력하여 생성만 해두기
```
![스크린샷, 2022-05-28 23-22-46](https://user-images.githubusercontent.com/99124279/170829518-905ceb03-31d4-4a99-a10e-b0797c6777de.png)

## Command 등록 (Ubuntu)
```sh
$ git clone git@github.com:Jaeminst/AWS-Configure-Register-Script.git
$ cd ./AWS-Configure-Register-Script
$ printf "\naws-login() {\n source $(pwd)/AWS-login.sh\n}" >> ~/.bashrc
$ source ~/.bashrc
```

## Command 등록 (MacOS)
```sh
$ git clone git@github.com:Jaeminst/AWS-Configure-Register-Script.git
$ cd ./AWS-Configure-Register-Script
$ sudo cp AWS-login.sh /usr/bin/aws-login
```

## 사용화면
![스크린샷, 2022-05-28 23-34-57](https://user-images.githubusercontent.com/99124279/170829980-06ff0ac5-de7c-49b2-b29c-10c0ba08f172.png)
