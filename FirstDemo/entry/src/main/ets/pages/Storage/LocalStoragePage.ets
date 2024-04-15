
import router from '@ohos.router';
// 两个页面共享一个user对象, 定义模型，创建storage， entry注入，
export class UserInfoClass {
  name: string = ""
  age: number = 0
}
let user: Record<string, UserInfoClass> = {
  "user": {
    name: '老高',
    age: 34
  }
};
export let storage: LocalStorage = new LocalStorage(user)
// 若使用全局的storage， 直接在ability首页 定义 const sharedStorage = new LocalStorage(user)；
// 使用 const shareLocal = LocalStorage.GetShared()
@Entry(storage)
@Component
struct LocalStoragePage {
  @State message: string = 'Hello World'
  // 从storage中取出key-value 值
  @LocalStorageProp("user") myUser: UserInfoClass = new UserInfoClass()

  build() {
    Row() {
      Column({ space: 15 }) {
        Text("姓名：" + this.myUser.name)
        Text("年龄：" + this.myUser.age)
        Button("跳转到另一个页面")
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Storage/LocalStorePage2'
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}