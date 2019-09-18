#!/bin/bash
echo "选择需要更新的分支 1_develop 2_master"
read branch
branch_develop=develop
branch_master=master
# 判断或者 || 或者 -o 并且 && 或者 -a
if [ "${branch}" = "${branch_develop}" -o "${branch}" = "1" ]
then
    current=develop
    echo "开始更新 develop... "
elif [ "${branch}" = "2" -o "${branch}" = "${branch_master}" ]
then
    current=master
    echo "开始更新 master... "
else
    echo "输入错误,停止"
    exit 2
fi
# 执行更新所有子项目操作
# 返回
basepath=$(cd `dirname $0`; pwd)
echo $basepath
cd /Users/admin/soft/develop/ios
# 执行更新所有子项目
./SubProjects.sh ${current}
# sh fileName.sh "project_pull.sh"
# 执行pod install
# pod install
cd $basepath
# 移除分支缓存
echo "移除主项目本地缓存远程分支信息..."
git fetch -p
# 获取当前目录git分支
TARGET_FILE_TMP=$(sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/\//\//g')
echo "当前分支: ${TARGET_FILE_TMP}"  
STR1="nothing to commit, working tree clean"
out=$(git status)
result=$(echo $out | grep "$STR1")
if [[ "$result" != "" ]]
then
    echo "主项目全部更改已提交"
else
    echo "主项目存在已修改未提交文件 1_提交已修改文件_不提交到远程分支 2_结束手动操作 3_提交已修改文件并且提交到远程分支"
    read choose
    if [ "${choose}" = "1" ]
    then
        git add .
        echo "输入您的commit文字"
        read commitStr
        git commit -m "$commitStr"
        echo "已经 commit"
    elif [ "${choose}" = "2" ]
    then
        echo "手动提交，退出脚本"
        exit 2
    elif [ "${choose}" = "3" ]
    then
        git add .
        echo "输入您的commit文字"
        read commitStr
        git commit -m "$commitStr"
        echo "已经 commit"
        git pull origin $TARGET_FILE_TMP
        git push origin $TARGET_FILE_TMP
    else
        echo "输入错误，退出脚本"
        exit 2 
    fi
fi      
if [ "${TARGET_FILE_TMP}" = "$current" ]
then
    git pull
else
# 判断是否有已修改未提交的文件
    git checkout $current
    git pull
fi
pod install
echo "完成更新"