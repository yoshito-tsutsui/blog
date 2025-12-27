package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class teraco_osiete extends Sprite
	{
		public function teraco_osiete() {
			ok_wakattaYo1();
			ok_wakattaYo2();
		}
		
		public function ok_wakattaYo1():void {
			//var car:Car = new Car();
			//っとするところを抽象的に
			//var car:IMachine と変数宣言してみる。
			var car:IMachine = new Car();
			
			//そのままcarをaddChildするとIMachineはDisplayObjectでは
			//ないので怒られる。なんでキャストする。
			addChild(DisplayObject(car));
			
			//上記２つと同様。
			var carlogo:IMachine = new CarLogo();
			addChild(DisplayObject(carlogo));
		}
		
		public function ok_wakattaYo2():void {
			//Car(Sprite)とCarLogo(TextField)をインスタンス化して、配列にぶっこむ。
			var machines:Array = [];
			var car:Car = new Car();
			var carlogo:CarLogo = new CarLogo();
			machines.push(car);
			machines.push(carlogo);
			
			//配列の中身をfor eachでまわす時、受け取る変数をIMachineと定義する。
			//IMachineにはdrawが定義されているので問題なくdrawできる。
			//※抽象クラスを使うことによりSpriteを継承しているCarでもTextFieldを継承しているCarLogoでも
			// 変数に格納できる。
			for each (var obj:IMachine in machines) {
				trace(obj);//１ループ目[object Car]　, ２ループ目[object Car]
				obj.draw();
			}
		}
	}
}

import flash.display.Sprite;
import flash.text.TextField;
import machine1.IMachine;

/**
 * 抽象クラス「IMachine」を実装 (implements)したCarクラス
 */
class Car extends Sprite implements IMachine {
	public function draw():void {}
}

/**
 * 抽象クラス「IMachine」を実装 (implements)したCarLogoクラス
 */
class CarLogo extends TextField implements IMachine {
	public function draw():void {}
}

/**
 * 抽象クラス「IMachine」
 * 抽象メソッド「draw」のシグネチャを定義
 */
interface IMachine {
	function draw():void;
}