class Member {
  constructor(name = '南無権兵衛', age = 0) {
    this.name = name;
    this.age = age;
  }

  show(){
    console.log(`私の名前は${this.name}、${this.age}歳です。`);
  }
}

let m = new Member('佐藤理央', 25);
m.show();