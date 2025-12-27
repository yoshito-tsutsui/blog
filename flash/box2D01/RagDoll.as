package classes {
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.*;
	import Box2D.Common.Math.*;
	import classes.box2DMain;
	
	public class RagDoll {
		
		private var m_physScale:Number;
		
		public function RagDoll(m_world:b2World ) {

			m_physScale = box2DMain.m_physScale;
			var bd:b2BodyDef;
			var circ:b2CircleDef = new b2CircleDef();
			var box:b2PolygonDef = new b2PolygonDef();
			var jd:b2RevoluteJointDef = new b2RevoluteJointDef();
			
			var startX:Number = 300 + Math.random() * 20;
			var startY:Number = 20 + Math.random() * 50;
			
			// Head
			circ.radius = 30 / m_physScale;
			circ.density = 1.0;
			circ.friction = 0.4;
			circ.restitution = 0.2;
			bd = new b2BodyDef();
			bd.position.Set(startX/m_physScale , startY/m_physScale);
			var head:b2Body = m_world.CreateDynamicBody(bd);
			head.CreateShape(circ);
			head.SetMassFromShapes();
			
			//body
			box.SetAsBox(16/ m_physScale, 22 / m_physScale);
			box.density = 1.0;
			box.friction = 0.4;
			box.restitution = 0.1;
			bd = new b2BodyDef();
			bd.position.Set(startX / m_physScale, (startY + 50) / m_physScale);
			var body:b2Body = m_world.CreateDynamicBody(bd);
			body.CreateShape(box);
			body.SetMassFromShapes();
			
			//hand
			box.SetAsBox(15 / m_physScale, 7 / m_physScale);
			box.density = 1.0;
			box.friction = 0.4;
			box.restitution = 0.1;
			bd = new b2BodyDef();
			// L
			bd.position.Set((startX - 25) / m_physScale, (startY + 35) / m_physScale);
			var left_hand:b2Body = m_world.CreateDynamicBody(bd);
			left_hand.CreateShape(box);
			left_hand.SetMassFromShapes();
			// R
			bd.position.Set((startX + 25) / m_physScale, (startY + 35) / m_physScale);
			var right_hand:b2Body = m_world.CreateDynamicBody(bd);
			right_hand.CreateShape(box);
			right_hand.SetMassFromShapes();
			
			// Leg
			box.SetAsBox(10 / m_physScale, 15 / m_physScale);
			box.density = 1.0;
			box.friction = 0.4;
			box.restitution = 0.1;
			bd = new b2BodyDef();
			// L
			bd.position.Set((startX - 8) / m_physScale, (startY + 75) / m_physScale);
			var left_leg:b2Body = m_world.CreateDynamicBody(bd);
			left_leg.CreateShape(box);
			left_leg.SetMassFromShapes();
			// R
			bd.position.Set((startX + 8) / m_physScale, (startY + 75) / m_physScale);
			var right_leg:b2Body = m_world.CreateDynamicBody(bd);
			right_leg.CreateShape(box);
			right_leg.SetMassFromShapes();
			
			
			//JOINT
			jd.enableLimit = true;
			
			// Head to body
			jd.lowerAngle = -40 /  (180 / Math.PI);
			jd.upperAngle = 40 /  (180 / Math.PI);
			jd.Initialize(body,head,new b2Vec2(startX / m_physScale, (startY +30)/ m_physScale));
			m_world.CreateJoint(jd);
			
			// hand to body
			// L
			jd.lowerAngle = -85 / (180/Math.PI);
			jd.upperAngle = 130 / (180/Math.PI);
			jd.Initialize(body, left_hand, new b2Vec2((startX - 10) / m_physScale, (startY + 35) / m_physScale));
			m_world.CreateJoint(jd);
			// R
			jd.lowerAngle = -130 / (180/Math.PI);
			jd.upperAngle = 85 / (180/Math.PI);
			jd.Initialize(body, right_hand, new b2Vec2((startX + 10) / m_physScale, (startY + 35) / m_physScale));
			m_world.CreateJoint(jd);
			
			// hand to leg
			// L
			jd.lowerAngle = -25 / (180/Math.PI);
			jd.upperAngle = 45 / (180/Math.PI);
			jd.Initialize(body, left_leg, new b2Vec2((startX - 8) / m_physScale, (startY + 75) / m_physScale));
			m_world.CreateJoint(jd);
			// R
			jd.lowerAngle = -45 / (180/Math.PI);
			jd.upperAngle = 25 / (180/Math.PI);
			jd.Initialize(body, right_leg, new b2Vec2((startX + 8) / m_physScale, (startY + 75) / m_physScale));
			m_world.CreateJoint(jd);
			
		}
		
	}
	
}