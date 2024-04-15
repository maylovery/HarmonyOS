@Entry
@Component
struct StatePage {
  @State pnum: number = 0
  build() {
    Row() {
      Column() {
        Text(this.pnum.toString())
        Button("+1")
          .onClick(() => {
            this.pnum++
          })

        Divider()
        StateChild({ num: this.pnum })
      }
      .width('100%')
    }
    .height('100%')
  }
}
// state-prop 正向传值，state-link 逆向传值
@Component struct StateChild {
  @Prop num: number
  build() {
    Column() {
      Text("子组件")
      Text(this.num.toString())
      Button("修改子组件Prop")
        .onClick(() => {
          this.num++
        })
    }//.height(60)
    .width('100%')
    .backgroundColor(Color.Pink)
  }
}