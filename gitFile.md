自己不经常用的git命令：

1.git remote add origin https://github.com/name/name_cangku.git 把本地仓库与远程仓库连接起来。

2.git push -u origin master 把仓库区的文件提交到远程仓库里。

3.如何回溯到我们提交的上一个版本，用git reset --hard + 版本号即可。版本号可以用git log来查看，每一次的版本都会产生不一样的版本号。

4.但是,有时候把版本号弄丢了怎么办？git reflog帮你记录了每一次的命令，这样就可以找到版本号了，这样你又可以通过git reset来版本穿梭了。

5.



