package classes {
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.Joints.*;
	import classes.RagDoll;
	import classes.Floors;
	import General.Input;
	import flash.display.StageAlign;
	
	public class box2DMain extends MovieClip {
		
		public var m_world:b2World;
		public var m_iterations:int = 10;
		public static var m_physScale:Number = 30;
		public var m_timeStep:Number = 1.0/30.0;
		public static var m_stageWidth:Number;
		public static var m_stageHeight:Number;
		public var m_mouseJoint:b2MouseJoint;
		// world mouse position
		static public var mouseXWorldPhys:Number;
		static public var mouseYWorldPhys:Number;
		static public var mouseXWorld:Number;
		static public var mouseYWorld:Number;
		// Sprite to draw in to
		public var m_sprite:Sprite;
		public var m_input:Input;
		
		public function box2DMain() {
			stage.scaleMode = "noScale";
			stage.align = StageAlign.TOP_LEFT;
			
			m_stageWidth = stage.stageWidth;
			m_stageHeight = stage.stageHeight;
			m_sprite = new Sprite();
			addChild(m_sprite);
			m_input = new Input(m_sprite);
			
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
			
			//キャラクタ1作成
			var Rag01:RagDoll = new RagDoll(m_world);
			//キャラクタ2作成
			var Rag02:RagDoll = new RagDoll(m_world);
			//キャラクタJOINT
			var distanceJD:b2DistanceJointDef = new b2DistanceJointDef();//まずb2DistanceJointDefを生成
			distanceJD.Initialize(Rag01.left_leg,Rag02.head,Rag01.left_leg.GetPosition(),Rag02.head.GetPosition());//オブジェクトを2つ指定して、固定する位置を指定する。GetPosition()でオブジェクトの中心位置を取得できる。   
			var m_distanceJ:b2DistanceJoint = m_world.CreateJoint(distanceJD) as b2DistanceJoint;//m_worldに登録する  
			m_distanceJ.m_length = 3;
			
			//枠（天井、床など）作成
			new Floors(m_world);
			
			
			setDebug();
		}
		
		public function Update(e:Event):void{
			
			m_world.Step(m_timeStep, m_iterations);
			UpdateMouseWorld();
			MouseDrag();
			Input.update();
			
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

		//======================
		// Update mouseWorld
		//======================
		public function UpdateMouseWorld():void {
			
			mouseXWorldPhys = (Input.mouseX)/m_physScale; 
			mouseYWorldPhys = (Input.mouseY)/m_physScale; 

			mouseXWorld = (Input.mouseX); 
			mouseYWorld = (Input.mouseY);
			
			//trace("X -- " + mouseXWorldPhys + " - " + mouseXWorld);
			//trace("Y -- " + mouseYWorldPhys + " - " + mouseYWorld);
		}
		
		//======================
		// Mouse Drag 
		//======================
		public function MouseDrag():void{
			// mouse press
			if (Input.mouseDown && !m_mouseJoint){
				
				var body:b2Body = GetBodyAtMouse();
				
				if (body)
				{
					var md:b2MouseJointDef = new b2MouseJointDef();
					md.body1 = m_world.m_groundBody;
					md.body2 = body;
					md.target.Set(mouseXWorldPhys, mouseYWorldPhys);
					md.maxForce = 300.0 * body.m_mass;
					md.timeStep = m_timeStep;
					m_mouseJoint = m_world.CreateJoint(md) as b2MouseJoint;
					body.WakeUp();
				}
			}
			
			
			// mouse release
			if (!Input.mouseDown){
				if (m_mouseJoint)
				{
					m_world.DestroyJoint(m_mouseJoint);
					m_mouseJoint = null;
				}
			}
			
			
			// mouse move
			if (m_mouseJoint)
			{
				var p2:b2Vec2 = new b2Vec2(mouseXWorldPhys, mouseYWorldPhys);
				m_mouseJoint.SetTarget(p2);
			}
		}
		
		//======================
		// GetBodyAtMouse
		//======================
		private var mousePVec:b2Vec2 = new b2Vec2();
		public function GetBodyAtMouse(includeStatic:Boolean=false):b2Body{
			// Make a small box.
			mousePVec.Set(mouseXWorldPhys, mouseYWorldPhys);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.Set(mouseXWorldPhys - 0.001, mouseYWorldPhys - 0.001);
			aabb.upperBound.Set(mouseXWorldPhys + 0.001, mouseYWorldPhys + 0.001);
			
			// Query the world for overlapping shapes.
			var k_maxCount:int = 10;
			var shapes:Array = new Array();
			var count:int = m_world.Query(aabb, shapes, k_maxCount);
			var body:b2Body = null;
			for (var i:int = 0; i < count; ++i)
			{
				if (shapes[i].m_body.IsStatic() == false || includeStatic)
				{
					var tShape:b2Shape = shapes[i] as b2Shape;
					var inside:Boolean = tShape.TestPoint(tShape.m_body.GetXForm(), mousePVec);
					if (inside)
					{
						body = tShape.m_body;
						break;
					}
				}
			}
			return body;
		}
		
	}
	
}