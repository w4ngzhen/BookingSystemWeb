## 基于JavaWeb的餐厅预订系统
## 项目介绍
- 本餐厅预订系统，是本人的在校自学java servlet相关所做的一个实践。
- 做得很粗糙，因为才学习java web，所以在代码中有很多地方的都没有达到规范，有点生搬硬凑之嫌疑。
- 希望每一位看了我源代码的大牛能够提出您宝贵的意见。

### 功能介绍
##### 主要功能：
- 添加预定：通过时间并查询数据库筛选所选时间可用的桌子添加预订信息
- 2017.5.21更新：可查看每一个桌子的时间条详情进行可选时间段预定
- 添加临时顾客：针对临时进店的未预约客人，我们可以在能够进行就餐的时间段添加就餐
- 调换座位：对于所有的预约均可以调换可用座位
- 就餐：到店的已预约点击试用该功能进入就餐环节
- 结账：正在就餐的信息使用该功能结账
- 取消订单：对于所有预约均可以取消
##### 额外功能：
- 添加桌子：为系统新增桌子
- 移除桌子：移除系统中的桌子（仅限当前没有预约或正在就餐的桌子）

### 运用知识
- 数据库基本查询
- JavaWeb三层框架的分离（个人认为是伪分离，希望大牛提出宝贵修改意见）
#### 代码缺点：
- 没有真正运用到mvc模式
- 没有将servlet转发、重定向等进行封装，几乎是为每一个功能写了一个servlet，导致servlet过多

### 准备
- 数据库本人已经导出，当前根目录下的bookingsystem.sql就是。
- 导入到自己的数据库中的首先要在自己的数据库创建同名的数据库，并且设定编码为utf8_unicode_ci,再选择导入数据库。
- 数据库配置文件在config包中，配置查看。
- 其他无需额外准备，所有的需要的配置以及包本人均打包在WEB-INF中了

### 搭建环境
IntelliJ IDEA  +  MySQL

### 使用方法

1. git clone 'https://github.com/meesdd/BookingSystemWeb.git'
2. 使用IntelliJ IDEA导入打开
3. 部署Tomcat并启动

### 项目功能截图
#### 欢迎页：
<img src="https://cdn.jsdelivr.net/gh/w4ngzhen/BookingSystemWeb/description_images/1.png" width="50%" height="50%"/>

#### 主页面：
<img src="https://cdn.jsdelivr.net/gh/w4ngzhen/BookingSystemWeb/description_images/2.png" width="50%" height="50%"/>
#### 预定筛选、临时就餐界面：
<img src="https://cdn.jsdelivr.net/gh/w4ngzhen/BookingSystemWeb/description_images/3.png" width="50%" height="50%"/>
#### 预约界面：
<img src="https://cdn.jsdelivr.net/gh/w4ngzhen/BookingSystemWeb/description_images/4.png" width="50%" height="50%"/>

#### 餐桌管理界面：
<img src="https://cdn.jsdelivr.net/gh/w4ngzhen/BookingSystemWeb/description_images/5.png" width="50%" height="50%"/>

#### 新增的更具桌子详情预定
<img src="https://cdn.jsdelivr.net/gh/w4ngzhen/BookingSystemWeb/description_images/6.png" width="50%" height="50%"/>

