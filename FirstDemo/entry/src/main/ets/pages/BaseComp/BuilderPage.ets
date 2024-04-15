@Entry
@Component
struct BuilderPage {
  @State message: string = 'Hello World'
  @State formData: CardClass = {
    time: "2023-12-12",
    location: '回龙观',
    type: '漏油'
  }
  build() {
    Column({ space: 10 }) {
      getCellContent({ leftTitle: '异常时间', rightValue: this.formData.time })
      getCellContent({ leftTitle: '异常位置', rightValue: this.formData.location })
      getCellContent({ leftTitle: '异常类型', rightValue: this.formData.type })
      Button("修改数据").onClick(() => {
        this.formData.location = "望京"
      })
      Text("1使用 @Builder 复用逻辑的时候，支持传参可以更灵活的渲染UI; \n 2参数可以使用状态数据，不过建议通过对象的方式传入 @Builder")
        .padding(20)

      Text("1 @Builder function全局定义 ，不可以在组件内定义 \n 2 @Builder getCellContent(...)在组件内定义省略 function关键字")
        .padding(20)
    }
    .width('100%')
  }
}
class CardClass {
  time: string = ""
  location: string = ""
  type: string = ""
}
class CellParams {
  leftTitle: string = ""
  rightValue: string = ""
}

// 全局定义 ，不可以在组件内定义， 在组件内定义省略 function关键字
@Builder function getCellContent($$: CellParams) {
  Row() {
    Row() {
      Text($$.leftTitle)
      Text($$.rightValue)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .padding({ left: 15, right: 15 })
    .borderRadius(8)
    .height(40)
    .backgroundColor(Color.White)
  }
  .padding({ left: 10, right: 10 })
}
