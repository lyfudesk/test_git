#!/bin/sh
echo  "\033[31m 红色字 \033[0m" 
echo  "\033[31m 正在获取最新git仓库内容 \033[0m"
echo  "\033[31m 获取分支为 \033[0m\c"
 echo $1
 echo "是否继续执行?(y/n)"

 read choice
if [ "$choice" = "n" ] || [ "$choice" = "y" ];then
   if [ "$choice" = "n" ];then
      echo "程序退出"
      exit 1
   else [ "$choice" = "y" ]
      echo 'go on'
   fi
else 
   echo '退出'
   exit 1 
fi
echo  "\033[31m 正在fetch.. \033[0m\c"
git fetch 
sleep 1
##切换到研发分支
echo  "\033[31m 正在检索分支.. \033[0m\c"
echo $1
git checkout $1
sleep 1
##覆盖本地分支为远程最近分支
echo  "\033[31m 正在正在覆盖分支.. \033[0m\c"
echo $1
git reset origin/$1  --hard

##切换到week分支
git checkout week

##覆盖本地分支为远程最新分支
echo  "\033[31m 正在正在覆盖分支.. \033[0m\c"
echo week
git reset origin/week --hard

##merge研发分支
git merge $1
##判断是否产生冲突
if [ $? -eq 0 ];then
  echo " ________________________"
  echo "|                        |"
  echo "|      成功              |"
  echo "|      成功              |"
  echo "|      成功              |"
  echo "|________________________|"

else
  echo " ________________________"
  echo "|                        |"
  echo "|      merge失败         |"
  echo "|      出现冲突          |"
  echo "|   请手动解决冲突       |"
  echo "|________________________|"
fi
