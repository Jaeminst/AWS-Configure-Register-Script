#!/bin/bash
printf "\n[Profiles List] \n$(aws configure list-profiles)\n\n"

read -p "Profile: " user_name
## read -p "Region: " select_region

PS3='Please Select one: '

printf "\n"
printf "[Select Region]\n"
select select_region in "미국 동부 (버지니아 북부) us-east-1" "아시아 태평양 (서울) ap-northeast-2" "User input Region"
do
  case $select_region in
  "미국 동부 (버지니아 북부) us-east-1")
       select_region="us-east-1"
       break;;
  "아시아 태평양 (서울) ap-northeast-2")
       select_region="ap-northeast-2"
       break;;
  "User input Region")
       read -p ": " read_region
       select_region=$read_region
       break;;
  *)
       echo "Invalid input. select number"
       ;;
  esac
  REPLY=
done

## Profile 검사 통과 if문 작성할 것
## 필요 없음 aws configure --profile $user_name
## 패키지 없음 ecs-cli configure profile default --profile-name $user_name


printf "\ninstall: aws configure --profile <Your Name>\n\n"

aws configure set default.region $select_region
## aws configure set region $select_region --profile default
aws configure set region $select_region --profile $user_name

## Profile 검사 통과
unset AWS_PROFILE
export AWS_PROFILE=$user_name
## unset AWS_DEFAULT_PROFILE
## export AWS_DEFAULT_PROFILE=$user_name
printf "AWS-login: $user_name\n region: $(aws configure get region --profile $user_name)\n$(aws iam get-login-profile --user-name $user_name)\n\n"

printf "[Selection Profile] \n$(aws configure list)\n\n"

## pass에 등록안되어 있으면 설치 확인 및 설치 의사 select문 작성할 것
## pass 확인 후 엑세스 키, 시크릿 키 입력 받는 if문 작성할 것
## read -sp "AWS_ACCESS_KEY: " access_key_init
## read -sp "AWS_SECRET_ACCESS_KEY: " secret_key_init

## Key 검사 통과 if문 작성할 것, pass 유무 체크 후 export 다르게 할 것
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
export AWS_ACCESS_KEY_ID=$(pass aws/$user_name/aws-access-key-id)
export AWS_SECRET_ACCESS_KEY=$(pass aws/$user_name/aws-secret-access-key)
echo "Succeses read Keys"
#EOF