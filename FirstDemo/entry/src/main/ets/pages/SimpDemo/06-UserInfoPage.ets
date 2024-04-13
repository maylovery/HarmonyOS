class User {
  name: string
  age: number
  address: {
    province: string
    city: string
    area: string
  }
}

@Entry
@Component
struct UserInfoCase {
  @State user: Partial<User>  = {
    name: '老高',
    age: 34,
    address: {
      province: '北京',
      city: '北京',
      area: '昌平'
    }
  }

  build() {
    Row() {
      Column() {
        Text(JSON.stringify(this.user))
        Row({ space: 15 }) {
          Text("姓名：")
          TextInput({ text: this.user.name })
            .layoutWeight(1)
            .onChange(value => {
              this.user.name = value
            })
        }.padding(10)
        Row({ space: 15 }) {
          Text("年龄：")
          TextInput({ text: this.user.age.toString() })
            .layoutWeight(1)
            .onChange(value => {
              this.user.age = parseInt(value)
            })
        }.padding(10)

        Row({ space: 15 }) {
          Text("地址：")
          TextInput({ text: this.user.address?.province })
            .layoutWeight(1)
            .onChange(value => {
              this.user.address = { ...this.user.address, province: value }
            })
          TextInput({ text: this.user.address?.city })
            .layoutWeight(1)
            .onChange(value => {
              this.user.address = { ...this.user.address, city: value }
            })
          TextInput({ text: this.user.address?.area })
            .layoutWeight(1)
            .onChange(value => {
              this.user.address = { ...this.user.address, area: value }
            })
        }.padding(10)


      }
      .width('100%')
    }
    .height('100%')
  }
}