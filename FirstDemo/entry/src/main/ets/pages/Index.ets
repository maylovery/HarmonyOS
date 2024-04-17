import router from '@ohos.router'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State disable: boolean = false
  @State values: string[] = ["1", "2", "3"]
  build() {
    List({space: 20}) {

      ListItem() {
        Text("基础组件")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/BaseCompEntry" })
          })
      }

      ListItem() {
        Text("登陆界面")
          .onClick(() => {
            router.pushUrl({ url: "pages/SimpDemo/04-LoginDemoPage" })
          })
      }

      ListItem() {
        Text("知乎案例")
          .onClick(() => {
            router.pushUrl({ url: "pages/SimpDemo/ZhiHuReplyPage" })
          })
      }

      ListItem() {
        Text("商品列表-图片-文字")
          .onClick(() => {
            router.pushUrl({ url: "pages/SimpDemo/GoodListPage" })
          })
      }
      ListItem() {
        Text("网络请求NetRequestDemo")
          .onClick(() => {
            router.pushUrl({ url: "pages/NetWork/NetRequestDemo" })
          })
      }

      ListItem() {
        Text("美团选择菜品")
          .onClick(() => {
            router.pushUrl({ url: "pages/MeiTuan/MeiTuanEntryPage" })
          })
      }

    }.padding(20)
  }
}