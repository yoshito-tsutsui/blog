package classes {
	import flash.display.Sprite;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.cameras.DebugCamera3D;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.WireframeMaterial;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.render.BasicRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	import flash.events.Event;
	
	public class Sentkun3D extends Sprite {
		
		private var _scene:Scene3D;
		private var _viewport:Viewport3D;
		private var _render:BasicRenderEngine;
		private var _camera:DebugCamera3D;
		private var _bitmapmaterial:BitmapMaterial;
		private var _planes:Array;
		private var _planeNum:Number = 10;
		
		public function Sentkun3D() {
			addEventListener( Event.ADDED_TO_STAGE , init );
		}
		
		private function init(e:Event):void{
			
			_scene = new Scene3D();
			
			_viewport = new Viewport3D( stage.stageWidth , stage.stageHeight);
			
			addChild(_viewport);
			
			_camera = new DebugCamera3D( _viewport );
			_camera.focus = 300;
			_camera.zoom = 1;
			_camera.y = 300;
			
			_render = new BasicRenderEngine();
			
			_bitmapmaterial = new BitmapMaterial( new Sentkun(0, 0) );
			
			_planes = [];
			var rad:Number = Math.PI * 2 / _planeNum;
			var radius:Number = 500;
			for (var i:int = 0; i < _planeNum; i++) {
				var plane:Plane = new Plane( _bitmapmaterial , 244 , 252 , 4 , 4 );
				plane.material.doubleSided = true;
				plane.x = Math.cos(rad * i) * radius;
				plane.y = 252/2;
				plane.z = Math.sin(rad*i) * radius;
				_scene.addChild( plane );
				_planes.push( plane );
			}
			
			var wireframe:WireframeMaterial = new WireframeMaterial();
			var ground:Plane = new Plane( wireframe , 2000 , 2000  , 10 , 10 );
			ground.material.doubleSided = true;
			ground.pitch( 90 );
			_scene.addChild( ground );
			
			addEventListener( Event.ENTER_FRAME , onEnterFrameHandler ) ;
			stage.addEventListener( Event.RESIZE , onResizeHander );
		}
		
		private function onEnterFrameHandler(e:Event):void {
			/*
			for (var i:int = 0; i < _planeNum; i++) {
				var plane:Plane = _planes[i] as Plane;
				plane.yaw(1);
			}
			*/
			_render.renderScene( _scene , _camera , _viewport );
		}
		
		
		private function onResizeHander(e:Event):void {
			_viewport.viewportWidth = stage.stageWidth;
			_viewport.viewportHeight = stage.stageHeight;
		}
		
		public function cameraChange(type:String) {
			if ( type == "free") {
				_camera.target = null;
			} else {
				_camera.target = DisplayObject3D.ZERO;
			}
		}
		
	}
	
}