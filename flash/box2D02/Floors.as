package classes {
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import classes.box2DMain;
	
	public class Floors {
		
		private var m_physScale:Number;
		private var m_stageWidth:Number;
		private var m_stageHeight:Number;
		
		public function Floors(m_world:b2World ) {

			m_physScale = box2DMain.m_physScale;
			m_stageWidth = box2DMain.m_stageWidth;
			m_stageHeight = box2DMain.m_stageHeight;
			
			//枠作成
			//床
			var boxSd01:b2PolygonDef = new b2PolygonDef();
			boxSd01.density = 100;
			boxSd01.friction = 1;
			boxSd01.restitution = 1;
			boxSd01.SetAsBox(m_stageWidth/m_physScale,10/m_physScale);
			var boxBdDef01:b2BodyDef = new b2BodyDef();
			boxBdDef01.position.Set(0/m_physScale , (m_stageHeight -5)/m_physScale);
			var boxBd01:b2Body = m_world.CreateStaticBody(boxBdDef01);
			boxBd01.CreateShape(boxSd01);
			boxBd01.SetMassFromShapes();
			
			//天井
			var boxSd02:b2PolygonDef = new b2PolygonDef();
			boxSd02.SetAsBox(m_stageWidth/m_physScale,10/m_physScale);
			var boxBdDef02:b2BodyDef = new b2BodyDef();
			boxBdDef02.position.Set(0/m_physScale , 0/m_physScale);
			var boxBd02:b2Body = m_world.CreateStaticBody(boxBdDef02);
			boxBd02.CreateShape(boxSd02);
			boxBd02.SetMassFromShapes();
			
			//左
			var boxSd03:b2PolygonDef = new b2PolygonDef();
			boxSd03.restitution = 2;
			boxSd03.SetAsBox(10/m_physScale,m_stageHeight/m_physScale);
			var boxBdDef03:b2BodyDef = new b2BodyDef();
			boxBdDef03.position.Set(0/m_physScale , 0/m_physScale);
			var boxBd03:b2Body = m_world.CreateStaticBody(boxBdDef03);
			boxBd03.CreateShape(boxSd03);
			boxBd03.SetMassFromShapes();
			
			//右
			var boxSd04:b2PolygonDef = new b2PolygonDef();
			boxSd04.restitution = 2;
			boxSd04.SetAsBox(10/m_physScale,m_stageHeight/m_physScale);
			var boxBdDef04:b2BodyDef = new b2BodyDef();
			boxBdDef04.position.Set((m_stageWidth -5)/m_physScale , 0/m_physScale);
			var boxBd04:b2Body = m_world.CreateStaticBody(boxBdDef04);
			boxBd04.CreateShape(boxSd04);
			boxBd04.SetMassFromShapes();
			
		}
		
	}
	
}