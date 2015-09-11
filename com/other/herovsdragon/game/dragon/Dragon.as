package herovsdragon.game.dragon
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import com.dango_itimi.box2d.material.*;
    import flash.display.*;
    import flash.geom.*;
    import herovsdragon.game.dragon.act.*;
    import herovsdragon.game.dragon.view.*;
    import herovsdragon.game.se.*;

    public class Dragon extends Object
    {
        private var runFunction:Function;
        private var viewLayer:Sprite;
        private var actor:Actor;
        private var chunk:Chunk;
        private var firstPositionX:Number;
        private var firstPositionY:Number;
        private var neutralPlayerHalfHeight:uint;
        private const ADJUST:int = 6;
        private var neutralActor:NeutralActor;
        private var advanceActor:AdvanceActor;
        private var retreatActor:RetreatActor;
        private var shadow:Shadow;
        private var stompActor:StompActor;
        private var attackReadyActor:AttackReadyActor;
        private var attackFireActor:AttackFireActor;
        private var attackBlusterActor:AttackBlusterActor;
        private var slowCount:uint = 0;
        private var stopFrameCount:uint = 0;
        private var downActor:DownActor;
        private var clawAttackActor:ClawAttackActor;
        private static var box2dScale:uint;
        private static var soundEffectMap:SoundEffectMap;
        private static const SHIFT_FROM_DAMAGE_TO_ATTACK:uint = 2;
        private static const SLOW_COUNT_MAX:uint = 3;
        private static const STOP_FRAME_COUNT_MAX:uint = 1;

        public function Dragon()
        {
            return;
        }// end function

        public function initialize(param1:Chunk) : void
        {
            this.chunk = param1;
            var _loc_2:* = param1._body.GetPosition();
            this.firstPositionX = _loc_2.x;
            this.firstPositionY = _loc_2.y;
            this.setChunkProperty();
            this.setActor();
            this.neutralActor.initializeAct();
            this.actor = this.neutralActor;
            this.draw();
            this.runFunction = this.runForNormal;
            return;
        }// end function

        private function setChunkProperty() : void
        {
            this.chunk._body.SetSleepingAllowed(false);
            return;
        }// end function

        private function setActor() : void
        {
            this.viewLayer = new Sprite();
            this.shadow = new Shadow();
            this.viewLayer.addChild(this.shadow);
            this.neutralActor = new NeutralActor();
            this.setActorCmn(this.neutralActor, Neutral);
            this.advanceActor = new AdvanceActor();
            this.setActorCmn(this.advanceActor, Advance);
            this.retreatActor = new RetreatActor();
            this.setActorCmn(this.retreatActor, Retreat);
            this.stompActor = new StompActor();
            this.setActorCmn(this.stompActor, Stomp);
            this.attackReadyActor = new AttackReadyActor();
            this.setActorCmn(this.attackReadyActor, AttackReady);
            this.attackBlusterActor = new AttackBlusterActor();
            this.setActorCmn(this.attackBlusterActor, AttackBluster);
            this.attackFireActor = new AttackFireActor();
            this.setActorCmn(this.attackFireActor, AttackFire);
            this.downActor = new DownActor();
            this.setActorCmn(this.downActor, Down);
            this.clawAttackActor = new ClawAttackActor();
            this.setActorCmn(this.clawAttackActor, ClawAttack);
            this.neutralPlayerHalfHeight = Math.floor(this.neutralActor._view.height / 2);
            return;
        }// end function

        private function setActorCmn(param1:Actor, param2:Class) : void
        {
            param1.setChunk(this.chunk);
            var _loc_3:* = new param2;
            param1.setView(_loc_3);
            this.viewLayer.addChild(_loc_3);
            return;
        }// end function

        public function initialiseAfterGameOver() : void
        {
            this.chunk._body.SetPosition(new b2Vec2(this.firstPositionX, this.firstPositionY));
            this.chunk._body.SetLinearVelocity(new b2Vec2(0, 0));
            this.stopFrameCount = 0;
            this.slowCount = 0;
            this.runFunction = this.runForNormal;
            this.actor.destroyAct();
            this.neutralActor.initializeAct();
            this.actor = this.neutralActor;
            this.draw();
            return;
        }// end function

        public function addChild(param1:Sprite) : void
        {
            param1.addChild(this.viewLayer);
            return;
        }// end function

        public function run() : void
        {
            this.runFunction();
            return;
        }// end function

        private function runForNormal() : void
        {
            this.actor.run();
            return;
        }// end function

        private function runForSlow() : void
        {
            if (this.stopFrameCount == STOP_FRAME_COUNT_MAX)
            {
                this.chunk._body.SetLinearVelocity(new b2Vec2());
            }
            if (this.stopFrameCount > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.stopFrameCount - 1;
                _loc_1.stopFrameCount = _loc_2;
                return;
            }
            this.actor.run();
            if (this.slowCount > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.slowCount - 1;
                _loc_1.slowCount = _loc_2;
                this.stopFrameCount = STOP_FRAME_COUNT_MAX;
            }
            else
            {
                this.runFunction = this.runForNormal;
            }
            return;
        }// end function

        public function draw() : void
        {
            var _loc_1:* = this.chunk._body.GetPosition();
            this.viewLayer.x = Math.floor(_loc_1.x * box2dScale);
            this.viewLayer.y = Math.floor(_loc_1.y * box2dScale + this.neutralPlayerHalfHeight) + this.ADJUST;
            return;
        }// end function

        public function damage() : void
        {
            var _loc_1:* = this.chunk._body.GetPosition();
            this.chunk._body.SetPosition(new b2Vec2(_loc_1.x + 2 / box2dScale, _loc_1.y));
            this.slowCount = SLOW_COUNT_MAX;
            this.stopFrameCount = STOP_FRAME_COUNT_MAX;
            this.runFunction = this.runForSlow;
            return;
        }// end function

        private function changeActor(param1:Actor) : void
        {
            this.actor.destroyAct();
            param1.initializeAct();
            this.actor = param1;
            return;
        }// end function

        public function changeActorToNeutral() : void
        {
            this.changeActor(this.neutralActor);
            return;
        }// end function

        private function changeActorToAdvance() : void
        {
            this.changeActor(this.advanceActor);
            return;
        }// end function

        private function changeActorToRetreat() : void
        {
            this.changeActor(this.retreatActor);
            return;
        }// end function

        private function changeActorToStomp() : void
        {
            soundEffectMap.playForBluster();
            this.changeActor(this.stompActor);
            return;
        }// end function

        private function changeActorToAttackReady() : void
        {
            this.changeActor(this.attackReadyActor);
            return;
        }// end function

        private function changeActorToAttackBluster() : void
        {
            soundEffectMap.playForBluster();
            this.changeActor(this.attackBlusterActor);
            return;
        }// end function

        private function changeActorToAttackFire() : void
        {
            this.changeActor(this.attackFireActor);
            return;
        }// end function

        public function changeActorToDown() : void
        {
            this.changeActor(this.downActor);
            return;
        }// end function

        private function changeActorToClawAttack() : void
        {
            soundEffectMap.playForBluster();
            this.changeActor(this.clawAttackActor);
            return;
        }// end function

        public function decideNextAct() : void
        {
            if (this.actor is NeutralActor)
            {
                this.decideNextActForNeutral();
            }
            else if (this.actor is AdvanceActor)
            {
                this.decideNextActForAdvance();
            }
            else if (this.actor is RetreatActor)
            {
                this.decideNextActForRetreat();
            }
            else if (this.actor is StompActor)
            {
                this.decideNextActForStomp();
            }
            else if (this.actor is AttackReadyActor)
            {
                this.decideNextActForAttackReady();
            }
            else if (this.actor is AttackBlusterActor)
            {
                this.decideNextActForAttackBluster();
            }
            else if (this.actor is AttackFireActor)
            {
                this.decideNextActForAttackFire();
            }
            else if (this.actor is ClawAttackActor)
            {
                this.decideNextActForClawAttack();
            }
            return;
        }// end function

        private function decideNextActForNeutral() : void
        {
            if (this.actor.reservedAttackIsStomp())
            {
                this.changeActorToStomp();
            }
            else if (this.actor.reservedAttackIsBreath())
            {
                this.changeActorToAttackReady();
            }
            else if (this.actor.reservedAttackIsClaw())
            {
                this.changeActorToClawAttack();
            }
            else if (this.actor._reservedDirectionOfMovement > 0)
            {
                this.changeActorToAdvance();
            }
            else if (this.actor._reservedDirectionOfMovement < 0)
            {
                this.changeActorToRetreat();
            }
            return;
        }// end function

        private function decideNextActForAdvance() : void
        {
            if (!this.actor.currentFrameIsTotalFrame())
            {
                return;
            }
            if (!this.actor.isReservedMove())
            {
                this.changeActorToNeutral();
            }
            else if (this.actor._reservedDirectionOfMovement > 0)
            {
            }
            else if (this.actor._reservedDirectionOfMovement < 0)
            {
                this.changeActorToRetreat();
            }
            return;
        }// end function

        private function decideNextActForRetreat() : void
        {
            if (!this.actor.currentFrameIsTotalFrame())
            {
                return;
            }
            if (!this.actor.isReservedMove())
            {
                this.changeActorToNeutral();
            }
            else if (this.actor._reservedDirectionOfMovement > 0)
            {
                this.changeActorToAdvance();
            }
            else if (this.actor._reservedDirectionOfMovement < 0)
            {
            }
            return;
        }// end function

        private function decideNextActForStomp() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForAttackReady() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToAttackBluster();
            }
            return;
        }// end function

        private function decideNextActForAttackBluster() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToAttackFire();
            }
            return;
        }// end function

        private function decideNextActForAttackFire() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForClawAttack() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        public function checkHittedAttack(param1:Rectangle) : Boolean
        {
            var _loc_2:* = this.chunk._body.GetPosition();
            var _loc_3:* = new Rectangle(_loc_2.x * box2dScale - this.neutralActor._view.width / 2, _loc_2.y * box2dScale - this.neutralActor._view.height / 2, this.neutralActor._view.width, this.neutralActor._view.height);
            return param1.right > _loc_3.left;
        }// end function

        public function hitTestForClaw(param1:Sprite) : Boolean
        {
            var _loc_2:* = this.clawAttackActor.getAttackHitArea();
            if (!_loc_2)
            {
                return false;
            }
            return _loc_2.hitTestObject(param1);
        }// end function

        public function isAttackedClaw() : Boolean
        {
            return this.actor is ClawAttackActor;
        }// end function

        public function isFired() : Boolean
        {
            if (this.actor is AttackFireActor)
            {
            }
            return this.actor._view.currentFrame == 1;
        }// end function

        public function isStomped() : Boolean
        {
            if (this.actor is StompActor)
            {
            }
            return this.stompActor.isStomped();
        }// end function

        public function isNeutral() : Boolean
        {
            return this.actor is NeutralActor;
        }// end function

        public function isAdvancing() : Boolean
        {
            return this.actor is AdvanceActor;
        }// end function

        public function isRetreating() : Boolean
        {
            return this.actor is RetreatActor;
        }// end function

        public function getChunkPosition() : b2Vec2
        {
            return this.chunk._body.GetPosition();
        }// end function

        public function isShiftedFromDamageToAttack() : Boolean
        {
            return Math.floor(Math.random() * SHIFT_FROM_DAMAGE_TO_ATTACK) == 0;
        }// end function

        public function shiftFromDamageToAttack() : void
        {
            var _loc_1:* = Math.floor(Math.random() * Actor.ATTACK_KIND);
            if (_loc_1 == 0)
            {
                this.changeActorToAttackReady();
            }
            else if (_loc_1 == 1)
            {
                this.changeActorToStomp();
            }
            else
            {
                this.changeActorToClawAttack();
            }
            return;
        }// end function

        public function get _viewLayer() : Sprite
        {
            return this.viewLayer;
        }// end function

        public function getFontPositionX() : Number
        {
            return this.viewLayer.x;
        }// end function

        public function getFontPositionY() : Number
        {
            return this.viewLayer.y - 80;
        }// end function

        public static function initializeStatic(param1:b2World, param2:uint, param3:uint, param4:Number, param5:Sprite, param6:SoundEffectMap) : void
        {
            Dragon.soundEffectMap = param6;
            Dragon.box2dScale = param2;
            Actor.initializeStatic(param1, param2, param3, param4, param5, param6);
            return;
        }// end function

    }
}
