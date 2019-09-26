#!/bin/bash
if [ -n "$1" ]; then
    echo "更新分支为：$1"
    current=$1
else
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
fi

# 遍历当前文件夹
for dir in $(ls .)
do
# -d $dir 是否是目录
    if [ -d "${dir}" ]
    then
        echo "更新: ${dir}"
        # 进入目录 并且执行 pull 操作
        cd $dir
        # 移除分支缓存
        echo "移除本地缓存远程分支信息..."
        git fetch -p
        echo "移除完成"
         # 判断是否有已修改未提交的文件
        STR1="nothing to commit, working tree clean"
        out=$(git status)
        result=$(echo $out | grep "$STR1")
        # 获取当前目录git分支
        TARGET_FILE_TMP=$(sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/\//\//g')
        echo "当前分支: ${TARGET_FILE_TMP}" 

        if [[ "$result" != "" ]]
        then
            echo "${dir} 全部更改已提交"
        else
            # 有需要提交的文件
            echo "${dir} 存在已修改未提交文件 1_提交已修改文件_不提交到远程分支 2_结束手动操作 3_提交已修改文件并且提交到远程分支"
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
            git checkout $current
            git pull
        fi
    fi
    cd ..
done
echo "完成所有子项目${current}分支更新"