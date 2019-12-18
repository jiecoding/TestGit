自己不经常用的git命令：

1.git remote add origin https://github.com/name/name_cangku.git 把本地仓库与远程仓库连接起来。

2.git push -u origin master 把仓库区的文件提交到远程仓库里。

3.如何回溯到我们提交的上一个版本，用git reset --hard + 版本号即可。版本号可以用git log来查看，每一次的版本都会产生不一样的版本号。

4.但是,有时候把版本号弄丢了怎么办？git reflog帮你记录了每一次的命令，这样就可以找到版本号了，这样你又可以通过git reset来版本穿梭了。

撤销：

5.场景1：在工作区时，你修改了一个东西，你想撤销修改，git checkout -- file。廖雪峰老师指出撤销修改就回到和版本库一模一样的状态，即用版本库里的版本替换工作区的版本。

6.场景2：你修改了一个内容，并且已经git add到暂存区了。想撤销怎么办？回溯版本，git reset --hard + 版本号,再git checkout -- file,替换工作区的版本。

7.场景3：你修改了一个内容，并且已经git commit到了master。跟场景2一样，版本回溯，再进行撤销。


删除

8.如果你git add一个文件到暂存区，然后在工作区又把文件删除了，Git会知道你删除了文件。如果你要把版本库里的文件删除，git rm 并且git commit -m "xxx".

如果你误删了工作区的文件，怎么办？使用撤销命令，git checkout --就可以。这再次证明了撤销命令其实就是用版本库里的版本替换工作区的版本，无论工作区是修改还是删除，都可以“一键还原”。

9.



参考整理联系：http://www.cocoachina.com/articles/68616


问题1： 如果我加到暂存区，但是没有commit，这个时候没有提交记录的id怎么撤销？


