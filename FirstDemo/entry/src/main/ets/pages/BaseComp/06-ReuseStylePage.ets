@Entry
@Component
// 重复利用UI @Styles 和Extend
struct ReuseStylePage {
  @State message: string = 'Hello World'

  // 文件内样式
  @Styles
  pressStyle() {
    .width(200)
    .height(80)
    .borderRadius(40)
    .backgroundColor(Color.Pink)
  }

  @Styles
  disableStyle() {
    .backgroundColor(Color.Red)
  }
  @Styles
  inputFocusStyle() {
    .border({
      color: Color.Red,
      width: 1
    })
  }

  @Styles
  inputNormalStyle (){
    .border({
      color: Color.Red,
      width: 0
    })
  }

  build() {
    Column({space: 20}) {
      Text("样式1")
        .textStyle1()
        .textAlign(TextAlign.Center)
      Text("重复样式1")
        .textStyle1()
        .textAlign(TextAlign.Center)
      Divider()
      // 下面是 @Extend 修饰
      Column({ space: 20 }) {
        Text("测试2")
          .text2Style()
        Button("按钮")
          .btnStyle()
        TextInput()
          .inputStyle()
      }
      // 下面是.stateStyle 设置
      Divider()
      Column({ space: 20 }) {
        Row() {
          TextInput()
            .height(40)
            .stateStyles({
              focused: this.inputFocusStyle,
              normal: this.inputNormalStyle
            })
        }.padding({left: 10, right: 10})

        Row() {
          TextInput()
            .height(40)
            .stateStyles({
              focused: this.inputFocusStyle,
              normal: this.inputNormalStyle
            })
        }.padding({left: 10, right: 10})
      }


    }
    .width('100%')
    .margin({top: 50})
  }
}

@Styles function textStyle1() {
  .width(100)
  .height(50)
  .backgroundColor(Color.Pink)
  .borderRadius(25)
  .align(Alignment.Center)
}

@Extend(Text) function textInputAll (callback?: () => void) {
  .width(100)
  .height(50)
  .backgroundColor(Color.Pink)
  .borderRadius(25)
  .textAlign(TextAlign.Center)
  .fontColor(Color.White)
  .onClick(() => {
    callback && callback()
  })
}

@Extend(Text) function text2Style () {
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
  .textAlign(TextAlign.Center)
  .fontSize(20)
}
@Extend(Button) function btnStyle () {
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
  .fontSize(20)
}
//
@Extend(TextInput) function inputStyle () {
  .width(120)
  .height(60)
  .borderRadius(30)
  .backgroundColor(Color.Pink)
  .textAlign(TextAlign.Center)
  .fontSize(20)
}