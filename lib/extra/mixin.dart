void main() {
  Fish().move();
  Duck().swim();
  Duck().fly();
}

class Animal {
  void move() {
    print('changed position');
  }
}

class Fish extends Animal {
  @override
  void move() {
    super.move();
    print('by swimming');
  }
}

class Bird extends Animal {
  @override
  void move() {
    super.move();
    print('by flying');
  }
}

mixin CanSwim{
  void swim(){
    print('Changing position by Swimming');
  }
}

mixin CanFly{
  void fly(){
    print('Changing position by fly');
  }
}
class Duck extends Animal with CanFly,CanSwim {


}

class Airplane with CanFly{

}