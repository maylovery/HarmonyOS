import {UserInfoClass, storage} from './LocalStoragePage'

@Entry(storage)
@Component
struct LoacalStorePage2 {
  @State message: string = 'Hello World'
  @LocalStorageLink('user') myUser: UserInfoClass = new UserInfoClass()
  build() {
    Row() {
      Column() {
        Column({ space: 15 }) {
          Text("姓名：" + this.myUser.name)
          Text("年龄：" + this.myUser.age)
          Button("改名")
            .onClick(() => {
              this.myUser.name = '大老高'
            })
        }
        .width('100%')
      }
      .width('100%')
    }
    .height('100%')
  }
}