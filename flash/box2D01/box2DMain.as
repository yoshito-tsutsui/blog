package classes {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import classes.RagDoll;
	
	public class box2DMain extends MovieClip {
		
		public var m_world:b2World;
		public var m_iterations:int = 10;
		public static var m_physScale:Number = 30;
		public var m_timeStep:Number = 1.0/30.0;
		
		public function box2DMain() {
			
			// Add event for main loop
			addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
			
			// Creat world AABB
			var worldAABB:b2AABB = new b2AABB();
			worldAABB.lowerBound.Set(-100.0, -100.0);
			worldAABB.upperBound.Set(100.0, 100.0);
			
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
			
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			
			// Construct a world object
			m_world = new b2World(worldAABB, gravity, doSleep);
			
			new RagDoll(m_world);
			
			
			//床作成
			var floorSd:b2PolygonDef = new b2PolygonDef();
			floorSd.SetAsBox(stage.stageWidth/m_physScale,10/m_physScale);
			var floorBdDef:b2BodyDef = new b2BodyDef();
			floorBdDef.position.Set(0/m_physScale , (stage.stageHeight -10 )/m_physScale);
			var floorBd:b2Body = m_world.CreateStaticBody(floorBdDef);
			floorBd.CreateShape(floorSd);
			floorBd.SetMassFromShapes();
			
			
			setDebug();
		}
		
		public function Update(e:Event):void{
			
			m_world.Step(m_timeStep, m_iterations);
			
			
		}
		
        public function setDebug():void {   
  
            var dbgDraw:b2DebugDraw = new b2DebugDraw();//デバッグオブジェクトを生成   
            var dbgSprite:Sprite = new Sprite();//デバッグ用オブジェクトの表示用sprite   
            addChild(dbgSprite);//表示用スプライトを表示   
            dbgDraw.m_sprite = dbgSprite;//これはお決まり。   
            dbgDraw.m_drawScale = m_physScale;//ここでm_physScaleと違う値を入れると思わぬ表示になってしまう。   
            dbgDraw.m_fillAlpha = 0.5;//デバッグ用オブジェクトの透明度。表示されるオブジェクト全体に設定される。   
            dbgDraw.m_lineThickness = 0;//デバッグ用オブジェクトのライン。   
            dbgDraw.m_drawFlags = 0xFFFFFFFF;//デバッグ用オブジェクトの色指定。   
            m_world.SetDebugDraw(dbgDraw);//Box2Dのworldに追加。   
  
        }

	}
	
}