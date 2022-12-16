myWaitBar模块含有三个关键函数，大致用法是：

使用 my_bar = initBar("blabla", 0.5) 传入“进度条文本”和每次更新进度条的步长（步长太短更新频率太高效率会很低下），获取进度天对象 my_bar
使用 my_bar = renewBar(my_bar, [a, b], [A, B]) 更新进度条，其中 a,b 分别是内外迭代指针，A,B 分别是内外迭代指针的终止边界
使用 closeBar(my_bar) 关闭进度条窗口

说白了是自己用的一个小玩意儿，放在这里只是为了让其他人也能跑通我的LDPC代码


