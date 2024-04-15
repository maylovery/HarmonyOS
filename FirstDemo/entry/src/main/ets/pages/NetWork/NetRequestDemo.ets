import http from '@ohos.net.http'
@Entry
@Component
struct NetRequestDemo {
  @State message: string = 'Hello World'
  aboutToAppear() {
    this.getData()
  }
  async getData() {
    let url = "https://zhoushugang.gitee.io/fe2022/takeaway.json"
    let response = await http.createHttp().request(url)
    AlertDialog.show({ message: response.result as string})
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}