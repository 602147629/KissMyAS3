package herovsdragon.game.hero
{
    import Box2D.Common.Math.*;
    import Box2D.Dynamics.*;
    import com.dango_itimi.box2d.material.*;
    import com.dango_itimi.events.core.*;
    import com.dango_itimi.events.mouse.*;
    import flash.display.*;
    import herovsdragon.game.hero.act.*;
    import herovsdragon.game.hero.view.*;
    import herovsdragon.game.se.*;
    import herovsdragon.game.ui.font_effect.*;

    public class Hero extends Object
    {
        private var actor:Actor;
        private var chunk:Chunk;
        private var firstPositionX:Number;
        private var firstPositionY:Number;
        private var viewLayer:Sprite;
        private var neutralActor:NeutralActor;
        private var neutralPlayerHalfHeight:uint;
        private const ADJUST:int = 1;
        private var advanceActor:AdvanceActor;
        private var retreatActor:RetreatActor;
        private var shadow:Shadow;
        private var attackActor:AttackActor;
        private var defenseActor:DefenseActor;
        private var damageActor:DamageActor;
        private var defenseSuccessActor:DefenseSuccessActor;
        private var specialAttackActor:AttackActor;
        private var downActor:DownActor;
        private var secondAttackActor:AttackActor;
        private var thirdAttackActor:AttackActor;
        private static var box2dScale:uint;
        private static var soundEffectMap:SoundEffectMap;
        private static var fontEffectViewer:FontEffectViewer;

        public function Hero(param1:Chunk)
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
            this.attackActor = new AttackActor();
            this.setActorCmn(this.attackActor, Attack);
            this.secondAttackActor = new AttackActor();
            this.setActorCmn(this.secondAttackActor, SecondAttack);
            this.thirdAttackActor = new AttackActor();
            this.setActorCmn(this.thirdAttackActor, ThirdAttack);
            this.specialAttackActor = new AttackActor();
            this.setActorCmn(this.specialAttackActor, SpecialAttack);
            this.defenseActor = new DefenseActor();
            this.setActorCmn(this.defenseActor, Defense);
            this.damageActor = new DamageActor();
            this.setActorCmn(this.damageActor, Neutral);
            this.downActor = new DownActor();
            this.setActorCmn(this.downActor, Down);
            this.defenseSuccessActor = new DefenseSuccessActor();
            this.defenseSuccessActor.setChunk(this.chunk);
            this.defenseSuccessActor.setView(this.defenseActor._view);
            this.neutralPlayerHalfHeight = Math.floor(this.neutralActor._view.height / 2);
            Actor.setNeutralWidth(this.neutralActor._view.width);
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
            this.actor.run();
            return;
        }// end function

        public function draw() : void
        {
            var _loc_1:* = this.chunk._body.GetPosition();
            this.viewLayer.x = Math.floor(_loc_1.x * box2dScale);
            this.viewLayer.y = Math.floor(_loc_1.y * box2dScale + this.neutralPlayerHalfHeight) + this.ADJUST;
            return;
        }// end function

        private function changeActor(param1:Actor) : void
        {
            this.actor.destroyAct();
            param1.initializeAct();
            this.actor = param1;
            return;
        }// end function

        private function changeActorToNeutral() : void
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

        private function changeActorToAttack() : void
        {
            soundEffectMap.playForBlade();
            this.changeActor(this.attackActor);
            return;
        }// end function

        private function changeActorToSecondAttack() : void
        {
            soundEffectMap.playForBlade2();
            this.changeActor(this.secondAttackActor);
            return;
        }// end function

        private function changeActorToThirdAttack() : void
        {
            soundEffectMap.playForBlade3();
            this.changeActor(this.thirdAttackActor);
            return;
        }// end function

        private function changeActorToSpecialAttack() : void
        {
            soundEffectMap.playForSpecialAttack();
            fontEffectViewer.addSentenceForGreen("SMAAASH!", this.getFontPositionX(), this.getFontPositionY());
            this.changeActor(this.specialAttackActor);
            return;
        }// end function

        private function changeActorToDefense() : void
        {
            soundEffectMap.playForDefense();
            this.changeActor(this.defenseActor);
            return;
        }// end function

        public function changeActorToDamage() : void
        {
            this.changeActor(this.damageActor);
            return;
        }// end function

        public function changeActorToDefenseSuccess() : void
        {
            this.actor.destroyAct();
            this.defenseSuccessActor.initializeActForContinuedView();
            this.actor = this.defenseSuccessActor;
            return;
        }// end function

        public function changeActorToDown() : void
        {
            this.changeActor(this.downActor);
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
            else if (this.actor == this.attackActor)
            {
                this.decideNextActForAttack();
            }
            else if (this.actor == this.secondAttackActor)
            {
                this.decideNextActForSecondAttack();
            }
            else if (this.actor == this.thirdAttackActor)
            {
                this.decideNextActForThirdAttack();
            }
            else if (this.actor == this.specialAttackActor)
            {
                this.decideNextActForSpecialAttack();
            }
            else if (this.actor is DefenseActor)
            {
                this.decideNextActForDefense();
            }
            else if (this.actor is DamageActor)
            {
                this.decideNextActForDamage();
            }
            else if (this.actor is DefenseSuccessActor)
            {
                this.decideNextActForDefenseSuccess();
            }
            return;
        }// end function

        private function decideNextActForNeutral() : void
        {
            if (this.actor._reservedAttack)
            {
                this.changeActorToAttack();
            }
            else if (this.actor._reservedDefense)
            {
                this.changeActorToDefense();
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
            if (this.actor._reservedAttack)
            {
                this.changeActorToAttack();
            }
            else if (this.actor._reservedDefense)
            {
                this.changeActorToDefense();
            }
            else if (!this.actor.isReservedMove())
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
            if (this.actor._reservedAttack)
            {
                this.changeActorToAttack();
            }
            else if (this.actor._reservedDefense)
            {
                this.changeActorToDefense();
            }
            else if (!this.actor.isReservedMove())
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

        private function decideNextActForAttack() : void
        {
            if (this.attackActor.isChangedNextAttack())
            {
                this.changeActorToSecondAttack();
            }
            else if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForSecondAttack() : void
        {
            if (this.secondAttackActor.isChangedNextAttack())
            {
                this.changeActorToThirdAttack();
            }
            else if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForThirdAttack() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForSpecialAttack() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForDefense() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForDamage() : void
        {
            if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        private function decideNextActForDefenseSuccess() : void
        {
            if (this.actor._reservedAttack)
            {
                this.changeActorToSpecialAttack();
            }
            else if (this.actor.isFinished())
            {
                this.changeActorToNeutral();
            }
            return;
        }// end function

        public function getBladeHitArea() : Sprite
        {
            return this.actor is AttackActor ? ((this.actor as AttackActor).getBladeHitArea()) : (null);
        }// end function

        public function isDefensing() : Boolean
        {
            if (this.actor is DefenseActor)
            {
            }
            return this.defenseActor.isDefensing();
        }// end function

        public function isDefenseSuccessing() : Boolean
        {
            return this.actor is DefenseSuccessActor;
        }// end function

        public function isDamaging() : Boolean
        {
            return this.actor is DamageActor;
        }// end function

        public function isAttacking() : Boolean
        {
            return this.actor == this.attackActor;
        }// end function

        public function isSecondAttacking() : Boolean
        {
            return this.actor == this.secondAttackActor;
        }// end function

        public function isThirdAttacking() : Boolean
        {
            return this.actor == this.thirdAttackActor;
        }// end function

        public function get _viewLayer() : Sprite
        {
            return this.viewLayer;
        }// end function

        public function getView() : MovieClip
        {
            return this.actor._view;
        }// end function

        public function getChunkPositionX() : Number
        {
            return this.chunk._body.GetPosition().x;
        }// end function

        public function getChunkPositionY() : Number
        {
            return this.chunk._body.GetPosition().y;
        }// end function

        public function getFontPositionX() : int
        {
            return this.viewLayer.x;
        }// end function

        public function getFontPositionY() : int
        {
            return this.viewLayer.y - 60;
        }// end function

        public static function initializeStatic(param1:b2World, param2:uint, param3:uint, param4:Number, param5:Sprite, param6:KeyChecker, param7:DragChecker, param8:DragChecker, param9:SoundEffectMap, param10:FontEffectViewer) : void
        {
            Hero.fontEffectViewer = param10;
            Hero.soundEffectMap = param9;
            Hero.box2dScale = param2;
            Actor.initializeStatic(param1, param2, param3, param4, param5, param6, param7, param8, param9);
            return;
        }// end function

    }
}
