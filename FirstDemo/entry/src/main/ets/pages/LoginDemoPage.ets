import promptAction from '@ohos.promptAction'
@Entry
@Component
struct LoginCase {
  // arkTS
  account: string = "" // 公有面量
  password: string = '' // 只能在当前组件使用
  login() {
    if(this.account === 'admin' && this.password === '123456') {
      promptAction.showToast({ message: '登录成功' })
    }else {
      promptAction.showToast({ message: '用户名或者密码错误' })
    }
  }
  getBtnEnable(): boolean {
    if(this.account !== "" && this.password !== "") {
      return true
    }
    return false
  }

  build() {
    Row() {
      Column({ space: 20 }) {
        TextInput({
          placeholder: '请输入用户名'
        }).height(40)
          .width('80%')
          .onChange(value => {
            this.account = value
          })
        TextInput({
          placeholder: '请输入密码',
        }).height(40)
          .type(InputType.Password)
          .width('80%')
          .onChange(value => {
            this.password = value
          })
        Button("登录")
          .width('80%')
          .onClick(() => {
            // AlertDialog.show({ message: "登录成功" })
            this.login()
          })
          .enabled(this.getBtnEnable())
      }
      .width('100%')
    }
    .height('100%')
  }
}