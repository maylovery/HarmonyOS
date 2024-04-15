
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
/*
AppStorage 是应用全局的UI状态存储，是和应用的进程绑定的，由UI框架在应用程序启动时创建，为应用程序UI状态属性提供中央存储。-注意它也是内存数据，不会写入磁盘
第一种用法-使用UI修饰符
● 如果是初始化使用 AppStorage.SetOrCreate(key,value)
● 单向 @StorageProp('user') 组件内可变
● 双向 @StorageLink('user') 全局均可变

第二种用法  使用API方法
● AppStorage.Get<ValueType>(key) 获取数据
● AppStorage.Set<ValueType>(key,value) 覆盖数据
● const link: SubscribedAbstractProperty<ValueType> = AppStorage.Link(key) 覆盖数据
  ○ link.set(value) 修改
  ○ link.get() 获取
 * */


@Entry
@Component
struct AppStoragePage {
  @State message: string = 'Hello World'
  // 在此页面设置
  @StorageProp("user_token") token: string = ''
  @StorageLink("user_token") linkToken: string = ''

  onPageShow() {
    promptAction.showToast({message: AppStorage.Get("user_token") || "无token"})
  }

  build() {
    Row() {
      Column() {
        Text(this.token)
        Button("登录")
          .onClick(() => {
            // AppStorage.SetOrCreate<string>("user_token", "123456")
            // 点击登录之后跳转到子页面
            router.pushUrl({ url: 'pages/Storage/AppStoragePage2' })
          })
        // 修改token， 直接通过link 修改，或者通过 AppStorage.Link("user_token").set 进行修改
        Button("修改token")
          .onClick(() => {
            // this.linkToken = '678910'
            const link = AppStorage.Link("user_token") as SubscribedAbstractProperty<string>
            link.set("abcde")
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

