@Entry
@Component
struct BuilderParamPage {
  @State message: string = 'Hello World'

  @Builder getCardContent() {
    Row() {
      Text("插槽内容-父组件生成")
    }
  }
  build() {
    Row() {
      Column() {
        Text('这是父组件')
        BuilderParamChild({content: this.getCardContent})
        Text('这是父组件-结尾')
        Divider().height(20)
        Text("BuilderParams类似于 Vue中的插槽 \n1子组件中定义一个用BuilderParam修饰的函数 \n2父组件需要给子组件传入一个用Builder修饰的函数来赋值给子组件 \n 3子组件要在想要显示插槽的地方来调用传入的方法")

        BuilderParamChild() {
          Text("尾随闭包样式")
        }


      }.backgroundColor(Color.Gray)
      .width('100%')
    }
    .height('100%')
  }
}

@Component
struct BuilderParamChild {
   @BuilderParam content: ()=>void
   build() {
     Column () {
       Text("子组件-Text")
       Divider()
       if(this.content) {
         this.content()
       }
     }.backgroundColor(Color.Pink)
   }
}