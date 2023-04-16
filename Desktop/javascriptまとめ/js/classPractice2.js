class Member {
 name = '南無権兵衛';
 age = 0;
}

let m = new Member();
console.log(m); //結果:Member{name:'南無権兵衛',age:0}
console.log(`私の名前は${m.name}、${m.age}歳です。`);
  //結果:私の名前は南無権兵衛、0歳です。