package classes {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class Main extends Sprite {
		
		private var _sentkun3D:Sentkun3D;
		private var _cameraBtn:CameraBtn;
		
		public function Main() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}
		
		private function init():void{
			_sentkun3D = new Sentkun3D();
			addChild(_sentkun3D);
			
			_cameraBtn = new CameraBtn();
			addChild(_cameraBtn);
			_cameraBtn.addEventListener( _cameraBtn.CAMERA_CHANGE , cameraChange );
		}
		
		private function cameraChange(e:Event):void {
			if ( _cameraBtn.cameraType == "free") {
				_sentkun3D.cameraChange( "free" ) ;
			} else {
				_sentkun3D.cameraChange( "target" ) ;
			}
		}
		
	}
	
}