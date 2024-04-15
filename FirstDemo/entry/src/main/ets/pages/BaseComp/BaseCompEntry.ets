import router from '@ohos.router'
@Entry
@Component
struct BaseCompEntry {
  @State message: string = 'Hello World'

  build() {
    List({space: 20}) {
      ListItem() {
        Text("Text")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/01-BaseCompPage" })
          })
      }

      ListItem() {
        Text("图片")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/03-ImageCasePage" })
          })
      }

      ListItem() {
        Text("Com-Row-Flex布局")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/02-FlexComPage" })
          })
      }

      ListItem() {
        Text("倒计时")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/05-TimerPage" })
          })
      }

      ListItem() {
        Text("Builder参数")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/BuilderPage" })
          })
      }
      ListItem() {
        Text("State传值")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/StatePage" })
          })
      }

      ListItem() {
        Text("Provide-Consumer传值")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/StatePage3" })
          })
      }

      ListItem() {
        Text("@Observed-@ObjectLink传值")
          .onClick(() => {
            router.pushUrl({ url: "pages/BaseComp/StatePage4" })
          })
      }

      ListItem() {
        Text("@LocalStoragePage")
          .onClick(() => {
            router.pushUrl({ url: "pages/Storage/LocalStoragePage" })
          })
      }
      ListItem() {
        Text("@AppStoragePage")
          .onClick(() => {
            router.pushUrl({ url: "pages/Storage/AppStoragePage" })
          })
      }



    }.padding(20)
  }
}