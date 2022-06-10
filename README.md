# AWS-Configure-Registrer-Script

## 명령어 한개로 프로필과 리전 설정을 한 번에 할 수 있다.

- OS : Linux Ubuntu
- (MacOS에서 테스트 못해봐서 안되면 이슈 남겨주세요)
- 사전 설치 패키지 : `pass`, `aws-cli`

## 목차

1. [Install pass package](#install-pass-package)
   * [Ubuntu](#ubuntu)
   * [MacOS](#macos)
1. [Get GPG](#get-gpg)
   * [gpg 생성](#gpg-생성)
   * [gpg key 확인](#gpg-key-확인)
1. [Set pass](#set-pass)
   * [pass init](#pass-init)
   * [pass insert](#pass-insert)
     * [pass는 디렉토리 형식으로 저장됩니다](#pass는-디렉토리-형식으로-저장됩니다)
     * [secret-access-key도 위와 같이 등록](#secret-access-key도-위와-같이-등록)
     * [pass에 aws keys 등록 완료](#pass에-aws-keys-등록-완료)
1. [aws profile 등록](#aws-profile-등록)
1. [Set Command](#set-command)
   * [Set for Ubuntu](#set-for-ubuntu)
   * [Set for MacOS](#set-for-macos)
1. [Trouble shooting](#trouble-shooting)
   * [How to trouble shooting for InvalidClientTokenId error](#how-to-trouble-shooting-for-invalidclienttokenid-error)
1. [사용화면](#사용화면)


# Install pass package
## Ubuntu
```sh
$ sudo apt install pass -y
```

## MacOS
```sh
$ brew install --cask adur1990/tap/passformacos
```

# Get GPG

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

# Set pass

## pass init
```sh
$ pass init 상단에서 확인한 key
pass init 123FD1238CF11234
```

## pass insert

### pass는 디렉토리 형식으로 저장됩니다
```sh
$ pass insert aws/<username>/aws-access-key-id
mkdir: '/home/jaemin/.password-store/aws/jaemin' 디렉터리를 생성함
Enter password for aws/jaemin/aws-access-key-id: 여기에 엑세스 키 붙여넣고 엔터
Retype password for aws/jaemin/aws-access-key-id: 한번 더 똑같이 엑세스 키 넣고 엔터
```

### secret-access-key도 위와 같이 등록
```sh
$ pass insert aws/<username>/aws-secret-access-key
Enter password for aws/jaemin/aws-secret-access-key: 여기에 시크릿 키 붙여넣고 엔터
Retype password for aws/jaemin/aws-secret-access-key: 한번 더 똑같이 시크릿 키 넣고 엔터
```

### pass에 aws keys 등록 완료
![스크린샷, 2022-05-28 23-36-14](https://user-images.githubusercontent.com/99124279/170830050-521fcf19-1ff2-45eb-b5fb-7b1fec95f71b.png)

# aws profile 등록
```sh
$ aws configure --profile <Your Name>

aws configure --profile jaemin
... 아무키나 입력하여 생성만 해두기
```
![스크린샷, 2022-05-28 23-22-46](https://user-images.githubusercontent.com/99124279/170829518-905ceb03-31d4-4a99-a10e-b0797c6777de.png)

# Set Command

## Set for Ubuntu
```sh
$ git clone git@github.com:Jaeminst/AWS-Configure-Register-Script.git
$ cd ./AWS-Configure-Register-Script
$ printf "\naws-login() {\n source $(pwd)/AWS-login.sh\n}" >> ~/.bashrc
$ source ~/.bashrc
```

## Set for MacOS
```sh
$ git clone git@github.com:Jaeminst/AWS-Configure-Register-Script.git
$ cd ./AWS-Configure-Register-Script
$ printf "\naws-login() {\n source $(pwd)/AWS-login.sh\n}" >> ~/.zshrc
$ source ~/.zshrc
```

# Trouble Shooting

## How to trouble shooting for InvalidClientTokenId error
Error: An error occurred (InvalidClientTokenId) when calling the GetLoginProfile operation: The security token included in the request is invalid.
  * AWS의 사용자와 로그인하려는 프로필의 Token이 다릅니다.
  * 먼저, AWS에서 사용자를 생성 후 새로운 키를 발급 받습니다. 
![스크린샷, 2022-06-10 16-19-58](https://user-images.githubusercontent.com/99124279/173012222-35592cee-e409-41a3-9ae8-832e7fc715a4.png)

  * pass에 업데이트 해줍니다.

> **For example**
> ```
> 
> $ pass edit aws/jaemin/aws-access-key-id 
> 
> [main fe8005e] Edit password for aws/jaemin/aws-access-key-id using editor.
> 1 file changed, 0 insertions(+), 0 deletions(-)
> rewrite aws/jaemin/aws-access-key-id.gpg (100%)
> 
> $ pass edit aws/jaemin/aws-secret-access-key
> 
> [main ab1bd1d] Edit password for aws/jaemin/aws-secret-access-key using editor.
> 1 file changed, 0 insertions(+), 0 deletions(-)
> rewrite aws/jaemin/aws-secret-access-key.gpg (100%)
> 
> ```

# 사용화면
![스크린샷, 2022-06-10 15-54-48](https://user-images.githubusercontent.com/99124279/173008157-2b0e870e-eec0-42e8-8d70-bf7aeb91b9b8.png)
