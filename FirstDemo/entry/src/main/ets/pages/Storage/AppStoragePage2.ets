import router from '@ohos.router'
import promptAction from '@ohos.promptAction'

// 初始化磁盘
PersistentStorage.PersistProp("user_token", '')

@Entry
@Component
struct AppStoragePage2 {
  @StorageProp("user_token") token: string = ''

  @Watch('update') @StorageLink("user_token") linkToken: string = ''
  onPageShow() {
    promptAction.showToast({
      message:  AppStorage.Get<string>("user_token") || '无token'
    })
  }
  update() {
    promptAction.showToast({ message: 'token修改了' })
  }
  build() {
    Row() {
      Column() {
        Text(this.linkToken)
        Button("修改token")
          .onClick(() => {
            AppStorage.Set("user_token", 'cdcdscd')
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}