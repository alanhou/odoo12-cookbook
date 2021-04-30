# Odoo 12开发者指南（Cookbook）第三版

> ⚠️本书内容未经译者校对，错误较多，建议直接阅读[Odoo 14开发者指南（Cookbook）第四版](https://github.com/iTranslateX/odoo-cookbook)

其实是否翻译这本书我内心是纠结的，毕竟已经有了一套完整的[最好用的免费ERP系统Odoo 12开发手册](https://github.com/iTranslateX/odoo-essentials)，且以我个人的工作的方向而言目前使用 Odoo 的地方真心不多。这几个月有部分读者视我为 Odoo 的专家，我也竭力地解答了大部分问题，但我其实是属于 Odoo 社区的外围人员，对它的了解并不是很深入，也几乎没在相关交流群和论坛中做过任何发言。此外五月我计划中的翻译重点是一套人工智能的书（[Python之 AI人工智能初学者指南](https://alanhou.org/python-beginners-guide-artificial-intelligence/)），挑战还是蛮大的。

但冥冥中这本书的上一版（[最好用的免费ERP系统Odoo 11开发指南](https://alanhou.org/odoo-11-development/)）未完成翻译的挫败感和我深信未来会与 Odoo 有着紧密的交集促始我还是决定开始翻译这本书。不过翻译进度就真的是随缘了^-^

话说新版加了作者，页面数也足足多了300页😂

![](http://upload-images.jianshu.io/upload_images/14565748-837479975d16fbed.jpg)

英文原书：Odoo 12 Development Cookbook - Third Edition *190+ unique recipes to build effective enterprise and business application*s by Parth Gajjar, Alexandre Fayolle, Holger Brunn, Daniel Reis

## 前言

Odoo 是一个集成业务应用的套件。Odoo自带有25个不同的业务应用，涵盖CRM、生产制造、电商、会计等领域。简言之，它是一个覆盖你所有业务需求的多合一的解决方案。

Odoo 对开人员也是一个很棒的软件。有赖于 Odoo 强大的框架，开发人员可以从头开始构建强大的应用。Odoo框架有内置的插件机制。Odoo的内置应用也使用相同框架进行创建，并且其可扩展性有助于开发人员创建插件模块来修改已有应用。

Odoo涉及的领域很广，对于新手很难跟上这一学习曲线。Odoo 12开发者指南第三版提供一个逐步操作的指南来帮助你学习Odoo框架的方方面面，包括所有版本12的最新功能。它独特的设问和解决方案的方法有助于你解决日常Odoo开发中的问题。

## 本书面向的读者

这本书对于新手和有经验的开发人员都很适合。如果你有Python编程语言的基础知识，这本书可以帮助你很容易地习得Odoo框架的专业知识。如是你是一个想要使用Odoo框架开始高效业务应用，并想通过它来学习Odoo框架的实际案例，这本书非常适合你。

## 本书主要内容

[第一章 安装Odoo开发环境](https://github.com/iTranslateX/odoo-cookbook/blob/v12/1.md)：通过介绍Odoo生态系统进行开始。这里你将学习如何为开发环境安装并设置Odoo。你还将学习到如何激活开发工具。

[第二章 管理Odoo服务器实例](https://github.com/iTranslateX/odoo-cookbook/blob/v12/2.md)：有关安装和升级插件。它为你提供组织从GitHub上下载的自定义插件一些有用的小贴士。

[第三章 服务器部署](https://github.com/iTranslateX/odoo-cookbook/blob/v12/3.md)：有关如何为生产环境安装并配置Odoo实例。本章包含NGINX反向代理、SSL配置、启动服务和基本的Docker部署。还包含网站的CDN配置。

[第四章 创建Odoo插件模块](https://github.com/iTranslateX/odoo-cookbook/blob/v12/4.md)：讲解Odoo插件模块的结构并提供从零开始创建一个简单的Odoo模块的逐步操作指南。

[第五章 应用模型](https://github.com/iTranslateX/odoo-cookbook/blob/v12/5.md)：聚焦于Odoo模型结构，并讲解所有字段类型及它们的属性。本章还包含继承和扩展已有模型的不同方式。

[第六章 基本服务端部署](https://github.com/iTranslateX/odoo-cookbook/blob/v12/6.md)：介绍Odoo框架的API，展示增删改查（CRUD）方法以及其它常用方法的使用。本章还讲解如何在Odoo中编写业务逻辑。

[第七章 模块数据](https://github.com/iTranslateX/odoo-cookbook/blob/v12/7.md)：显示如何迁移你的插件模块和内置数据。还讲解编写迁移函数的基本步骤。

[第八章 调试](https://github.com/iTranslateX/odoo-cookbook/blob/v12/8.md)：提供调试Odoo代码的不同策略。本章包含开发者选项和Odoo shell的使用。

[第九章 高级服务端开发技巧](https://github.com/iTranslateX/odoo-cookbook/blob/v12/9.md)：讲解ORM框架更高级的课题。对于开发向导、SQL视图、安装钩子（hook）、on-change方法等非常有用。本章还讲解了如何在数据库中执行原生SQL查询。

[第十章 后端视图](https://github.com/iTranslateX/odoo-cookbook/blob/v12/10.md)：教授如何创建不同的UI视图以及如何从用户界面中触发业务逻辑。它涵盖了所有常用视图，如列表、表单、看板、日历、图形、搜索和透视表视图，还有一些新引入的视图，如cohort和仪表盘。本章还包含修改/继承已有视图的一些指导。

[第十一章 权限安全](https://github.com/iTranslateX/odoo-cookbook/blob/v12/11.md)：涵盖Odoo框架的安全方面。它显示了如何通过创建安全组、访问控制列表和记录级别规则来控制/限制用户对模型的访问。

[第十二章 国际化](https://github.com/iTranslateX/odoo-cookbook/blob/v12/12.md)：显示如何翻译你的插件模块的用户界面，并为管理翻译文件提供了有用的技巧。

[第十三章 自动化、工作流和打印件](https://github.com/iTranslateX/odoo-cookbook/blob/v12/13.md)：描绘了Odoo中实现更好的业务流程可用的不同工作和技巧。它展示如何使用服务端动作、自动化动作和基于时间的调度动作。本章还包含为你的模型创建PDF报告的指南。

[第十四章 网页服务端开发](https://github.com/iTranslateX/odoo-cookbook/blob/v12/14.md)：涵盖Odoo web服务的核心内容。它展示了如何创建自定义URL路径由来在指定URL上提供服务，以及如何对这些URL进行访问控制。

[第十五章 CMS网站开发](https://github.com/iTranslateX/odoo-cookbook/blob/v12/15.md)：讲解如何使用Odoo管理网站。还展示了如何创建和修改美观的网页和QWeb模板。本章还包含如何创建带选项的动态网页构建块。它包含一些管理 SEO、用户表单、UTM追踪、网站地图和获取访客地理信息的独立教程。本章还强调了Odoo中最新的多站点概念。

[第十六章 网页客户端开发](https://github.com/iTranslateX/odoo-cookbook/blob/v12/16.md)：深入到Odoo的JavaScript部分。涵盖了如何创建新字段控件以及对服务端发送RPC调用。还包含如何从零开始创建全新的视图。你还将学习如何创建操作向导。

[第十七章 Odoo的应用内购买](https://github.com/iTranslateX/odoo-cookbook/blob/v12/17.md)：涵盖有关Odoo最新的应用内购买（IAP）概念的所有内容。本章中你学习到如何为IAP创建客户端和服务模块。你还将学习到如何创建IAP账户并从终端用户提取IAP款项。

[第十八章 自动化测试用例](https://github.com/iTranslateX/odoo-cookbook/blob/v12/18.md)：涵盖如何在Odoo中编写和执行自动化测试用例，包含服务端、客户端以及操作向导集成的测试用例。本章还包含设置chrome-headless（无头浏览器模式）来截屏和录制视频来查看出错的客户端的测试用例的示范。

[第十九章 使用Odoo.sh管理、部署和测试](https://github.com/iTranslateX/odoo-cookbook/blob/v12/19.md)：讲解Odoo.sh，一个部署Odoo实例的PaaS平台，包含生产、模拟和开发分支的各方面。也讲解了该平台的不同选项。

[第二十章 Odoo中的远程过程调用（RPC）](https://github.com/iTranslateX/odoo-cookbook/blob/v12/20.md)：涵盖从外部应用连接Odoo实例的不同方式。本章教你如何通过XML-RPC、JSON-RPC和odoorpc库连接和从 Odoo实例访问数据。

[第二十一章 性能优化](https://github.com/iTranslateX/odoo-cookbook/blob/v12/21.md)：讲解用于获取Odoo中性能提升的不同概念和模式。本章包含预提取、ORM缓存和代码性能测试来监测性能问题的概念。

[第二十二章 POS（销售点）](https://github.com/iTranslateX/odoo-cookbook/blob/v12/22.md)：涵盖 POS 应用的自定义。包含用户界面、添加新动作按钮、修改业务流和扩展客户菜单的自定义。

[第二十三章 在Odoo中管理email](https://github.com/iTranslateX/odoo-cookbook/blob/v12/23.md)：讲解如何在Odoo中管理email和聊天工具。通过配置邮件服务器开始，然后讲解Odoo框架的邮件API。本章还涵盖Jinja2和QWeb邮件模板、表单视图、字段记录和活动的聊天工具。

[第二十四章 IoT盒子](https://github.com/iTranslateX/odoo-cookbook/blob/v12/24.md)：给出了最新的IoT盒子硬件的重点讲解。本章涵盖如何配置、访问和调试IoT盒子。不包含一个集成IoT盒子到你的自定义插件的示范。


## 其它相关

[Odoo 12开发者指南补充知识](https://alanhou.org/odoo-12-supplement/)

