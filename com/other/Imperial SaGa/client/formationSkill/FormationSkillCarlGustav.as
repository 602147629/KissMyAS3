package formationSkill
{
    import battle.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class FormationSkillCarlGustav extends FormationSkillBase
    {
        protected const _PHASE_CANNON:int = 100;
        private var _PHASE_ACTION_PHASE_CANNON_READY:int = 0;
        private var _PHASE_ACTION_PHASE_CANNON_DASH:int = 1;
        private var _PHASE_ACTION_PHASE_CANNON_JUMP:int = 2;
        private var _PHASE_ACTION_PHASE_CANNON_LOAD:int = 3;
        private var _PHASE_ACTION_PHASE_CANNON_FIRE:int = 4;
        private var _PHASE_ACTION_PHASE_CANNON_LEAVE:int = 5;
        private var _phaseActionPhaseCannon:int;
        private var _PHASE_ACTION_PHASE_BULLET_WAIT:int = 0;
        private var _PHASE_ACTION_PHASE_BULLET_FIRE:int = 1;
        private var _PHASE_ACTION_PHASE_BULLET_IMPACT:int = 2;
        private var _phaseActionPhaseBullet:int;
        private var _mcMain:MovieClip;
        private var _mcCannon:MovieClip;
        private var _mcBullet:MovieClip;
        private var _mcImpactEffect:MovieClip;
        private var _mcImpactedBullet:MovieClip;
        private var _mcImpactedPointNull:MovieClip;
        private var _fireBeforePD:PlayerDisplay;
        private var _fireAfterPD:PlayerDisplay;
        private var _countBullet:int;
        private var _bDamageDisplayed:Boolean;
        private var _effAfterImage:EffectAfterImage;
        private var _bulletFirePos:Point;
        private var _bulletImpactVec:Point;
        private var _bulletImpactRotate:Number;
        private var _bulletRotate:Number;
        private var _bulletTime:Number;
        private var _bulletSpeed:Number;
        private var _bulletIndex:int;
        private static const _CANNON_POS_X:int = 660;
        private static const _CANNON_POS_Y:int = 350;
        private static const _CANNON_JUMP_POS_X:int = -100;
        private static const _CANNON_JUMP_POS_Y:int = 40;
        private static const _CANNON_DASH_TIME:Number = 0.25;
        private static const _BULLET_SPEED:int = 800;
        private static const _BULLET_FLY_HEIGHT:int = 80;
        private static const _BULLET_ROTATE:int = 60;
        private static const _BULLET_START_TIME:Number = 0.1;
        private static const _BULLET_END_TIME:Number = 0.95;

        public function FormationSkillCarlGustav(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            super(param1, param2, param3, param4);
            for each (_loc_5 in _aAttacer)
            {
                
                _loc_5.characterDisplay.backupParent();
            }
            for each (_loc_6 in _aTarget)
            {
                
                _loc_6.characterDisplay.backupParent();
            }
            this._mcMain = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._mcCannon = this._mcMain.housinMc;
            this._mcBullet = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
            this._mcImpactEffect = ResourceManager.getInstance().createMovieClip(getResource(), "hit_front");
            this._mcImpactedBullet = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._mcImpactedPointNull = this._mcImpactedBullet.charaNull;
            this._mcMain.gotoAndStop("start");
            this._mcCannon.gotoAndStop("start");
            this._mcImpactEffect.gotoAndStop("start");
            this._mcBullet.visible = false;
            this._mcImpactEffect.visible = false;
            this._mcImpactedBullet.visible = false;
            this._bulletFirePos = null;
            this._bDamageDisplayed = false;
            _aNullMc = [];
            _mc = this._mcMain;
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._mcMain);
            _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(this._mcBullet);
            _layer.getLayer(LayerBattle.FRONT_EFFECT).addChild(this._mcImpactEffect);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._mcImpactedBullet);
            var _loc_7:* = _aTarget[0] as BattleActionBase;
            if (_aTarget[0] as BattleActionBase == null)
            {
                setPhase(_PHASE_LEAVE);
                return;
            }
            this._mcMain.x = _CANNON_POS_X;
            this._mcMain.y = _CANNON_POS_Y;
            this._mcImpactEffect.x = _loc_7.characterDisplay.pos.x;
            this._mcImpactEffect.y = _loc_7.characterDisplay.pos.y;
            this._mcImpactedBullet.x = _loc_7.characterDisplay.pos.x;
            this._mcImpactedBullet.y = _loc_7.characterDisplay.pos.y;
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            this._effAfterImage = null;
            if (this._mcImpactedBullet && this._mcImpactedBullet.parent)
            {
                this._mcImpactedBullet.parent.removeChild(this._mcImpactedBullet);
            }
            this._mcImpactedBullet = null;
            if (this._mcImpactEffect && this._mcImpactEffect.parent)
            {
                this._mcImpactEffect.parent.removeChild(this._mcImpactEffect);
            }
            this._mcImpactEffect = null;
            if (this._mcBullet && this._mcBullet.parent)
            {
                this._mcBullet.parent.removeChild(this._mcBullet);
            }
            this._mcBullet = null;
            if (this._mcMain && this._mcMain.parent)
            {
                this._mcMain.parent.removeChild(this._mcMain);
            }
            this._mcMain = null;
            _mc = null;
            super.release();
            return;
        }// end function

        override protected function selectControl(param1:Number) : void
        {
            switch(_phase)
            {
                case _PHASE_APPROACH:
                {
                    this.controlApproach();
                    break;
                }
                case this._PHASE_CANNON:
                {
                    this.controlCannon(param1);
                    break;
                }
                case _PHASE_LEAVE:
                {
                    this.controlLeave();
                    break;
                }
                case _PHASE_END:
                {
                    this.controlEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function selectPhase() : void
        {
            switch(_phase)
            {
                case _PHASE_APPROACH:
                {
                    this.phaseApproach();
                    break;
                }
                case this._PHASE_CANNON:
                {
                    this.phaseCannon();
                    break;
                }
                case _PHASE_LEAVE:
                {
                    this.phaseLeave();
                    break;
                }
                case _PHASE_END:
                {
                    this.phaseEnd();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            super.phaseApproach();
            this._mcMain.gotoAndPlay("start");
            return;
        }// end function

        override protected function controlApproach() : void
        {
            if (this._mcMain.currentLabel == "stay1")
            {
                setPhase(this._PHASE_CANNON);
            }
            return;
        }// end function

        protected function phaseCannon() : void
        {
            this._countBullet = _aAttacer.length;
            this._phaseActionPhaseCannon = this._PHASE_ACTION_PHASE_CANNON_READY;
            this._phaseActionPhaseBullet = this._PHASE_ACTION_PHASE_BULLET_WAIT;
            if (this._countBullet <= 0)
            {
                setPhase(_PHASE_LEAVE);
            }
            return;
        }// end function

        protected function controlCannon(param1:Number) : void
        {
            switch(this._phaseActionPhaseCannon)
            {
                case this._PHASE_ACTION_PHASE_CANNON_READY:
                {
                    this.controlCannonReady();
                    break;
                }
                case this._PHASE_ACTION_PHASE_CANNON_DASH:
                {
                    this.controlCannonDash();
                    break;
                }
                case this._PHASE_ACTION_PHASE_CANNON_JUMP:
                {
                    this.controlCannonJump();
                    break;
                }
                case this._PHASE_ACTION_PHASE_CANNON_LOAD:
                {
                    this.controlCannonLoad();
                    break;
                }
                case this._PHASE_ACTION_PHASE_CANNON_FIRE:
                {
                    this.controlCannonFire();
                    break;
                }
                case this._PHASE_ACTION_PHASE_CANNON_LEAVE:
                {
                    this.controlCannonLeave();
                    break;
                }
                default:
                {
                    break;
                }
            }
            switch(this._phaseActionPhaseBullet)
            {
                case this._PHASE_ACTION_PHASE_BULLET_WAIT:
                {
                    this.controlBulletWait();
                    break;
                }
                case this._PHASE_ACTION_PHASE_BULLET_FIRE:
                {
                    this.controlBulletFire(param1);
                    break;
                }
                case this._PHASE_ACTION_PHASE_BULLET_IMPACT:
                {
                    this.controlBulletImpact();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function controlCannonReady() : void
        {
            var _loc_1:* = _aAttacer[(this._countBullet - 1)] as BattleActionPlayer;
            this._fireBeforePD = _loc_1.characterDisplay as PlayerDisplay;
            var _loc_2:* = this._fireBeforePD.pos;
            var _loc_3:* = this._mcMain.pattern12.localToGlobal(new Point());
            _loc_3.x = _loc_3.x + _CANNON_JUMP_POS_X;
            _loc_3.y = _loc_3.y + _CANNON_JUMP_POS_Y;
            this._fireBeforePD.setAnimation(PlayerDisplay.LABEL_SIDE_DASH_MERGE);
            this._fireBeforePD.setTargetPoint(_loc_3, Distance(_loc_2.x, _loc_2.y, _loc_3.x, _loc_3.y) / 100 * _CANNON_DASH_TIME);
            this._fireBeforePD.setReverse(_loc_2.x < _loc_3.x);
            this._phaseActionPhaseCannon = this._PHASE_ACTION_PHASE_CANNON_DASH;
            return;
        }// end function

        private function controlCannonDash() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this._fireBeforePD.bMoveing)
            {
                _loc_1 = (this._mcMain.pattern12 as MovieClip).globalToLocal(this._fireBeforePD.pos);
                this._fireBeforePD.setParent(this._mcMain.pattern12);
                this._fireBeforePD.pos = _loc_1;
                this._fireBeforePD.setTargetJump(new Point());
                _loc_2 = this._fireBeforePD.pos;
                _loc_3 = this._mcMain.pattern12.localToGlobal(new Point());
                this._fireBeforePD.setReverse(_loc_2.x < _loc_3.x);
                SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
                this._phaseActionPhaseCannon = this._PHASE_ACTION_PHASE_CANNON_JUMP;
            }
            return;
        }// end function

        private function controlCannonJump() : void
        {
            if (!this._fireBeforePD.bMoveing)
            {
                this._fireBeforePD.setAnimationPattern(this._mcMain);
                this._phaseActionPhaseCannon = this._PHASE_ACTION_PHASE_CANNON_LOAD;
            }
            return;
        }// end function

        private function controlCannonLoad() : void
        {
            if (this._phaseActionPhaseBullet == this._PHASE_ACTION_PHASE_BULLET_WAIT)
            {
                this._mcMain.gotoAndPlay("shot");
                this._mcCannon.gotoAndPlay("shot");
                var _loc_1:* = this;
                var _loc_2:* = this._countBullet - 1;
                _loc_1._countBullet = _loc_2;
                this._phaseActionPhaseCannon = this._PHASE_ACTION_PHASE_CANNON_FIRE;
            }
            return;
        }// end function

        private function controlCannonFire() : void
        {
            if (this._mcMain.currentLabel == "stay2")
            {
                this._mcMain.gotoAndStop("stay1");
                this._phaseActionPhaseCannon = this._PHASE_ACTION_PHASE_CANNON_READY;
            }
            if (this._countBullet == 0 && this._mcMain.currentLabel == "lastend")
            {
                this._mcMain.gotoAndPlay("endstart");
                this._phaseActionPhaseCannon = this._PHASE_ACTION_PHASE_CANNON_LEAVE;
            }
            return;
        }// end function

        private function controlCannonLeave() : void
        {
            if (this._mcMain.currentLabel == "end")
            {
                if (this._phaseActionPhaseBullet == this._PHASE_ACTION_PHASE_BULLET_WAIT)
                {
                    if (!bMoveing())
                    {
                        setPhase(_PHASE_LEAVE);
                    }
                }
            }
            return;
        }// end function

        private function controlBulletWait() : void
        {
            if (this._mcMain.currentLabel == "bullet")
            {
                this._fireAfterPD = this._fireBeforePD;
                this._fireAfterPD.setParent(this._mcBullet.pattern12);
                this._fireAfterPD.setAnimationPattern(this._mcBullet);
                this._bulletFirePos = (this._mcMain.bulletStartNullMc as MovieClip).localToGlobal(new Point());
                this._bulletRotate = 33;
                this._mcBullet.x = this._bulletFirePos.x;
                this._mcBullet.y = this._bulletFirePos.y;
                this._mcBullet.rotation = this._bulletRotate;
                this._mcBullet.visible = true;
                this._bulletTime = _BULLET_START_TIME;
                this._bulletIndex = this._countBullet;
                this._bulletSpeed = _BULLET_SPEED / Distance(this._mcBullet.x, this._mcBullet.y, this._mcImpactEffect.x, this._mcImpactEffect.y);
                this._bulletImpactVec = new Point(this._mcImpactEffect.x - this._mcBullet.x, this._mcImpactEffect.y - this._mcBullet.y);
                this._bulletImpactRotate = _BULLET_ROTATE - Angle(this._mcImpactEffect.x, this._mcImpactEffect.y, this._mcBullet.x, this._mcBullet.y);
                this._bDamageDisplayed = false;
                this.bulletAction(0);
                SoundManager.getInstance().playSe(SoundId.SE_GUSTAV_FIRE);
                this._phaseActionPhaseBullet = this._PHASE_ACTION_PHASE_BULLET_FIRE;
            }
            return;
        }// end function

        private function controlBulletFire(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._bulletTime < _BULLET_END_TIME)
            {
                this.bulletAction(this._bulletSpeed * param1);
            }
            else
            {
                _loc_2 = new EffectShake(_battleManager.battleScreen, 3, 3, 0.5);
                _effectManager.addEffect(_loc_2);
                this._mcImpactEffect.gotoAndPlay("start");
                this._mcImpactEffect.hahenMc.gotoAndPlay("start");
                this._mcImpactEffect.visible = true;
                this._mcImpactedBullet.gotoAndPlay("start");
                this._mcImpactedBullet.visible = true;
                this._fireAfterPD.setParent(this._mcImpactedPointNull);
                this._fireAfterPD.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
                this._fireAfterPD.setAnimationPattern(this._mcImpactedPointNull);
                this._mcImpactedPointNull.gotoAndPlay("start");
                this._mcBullet.visible = false;
                SoundManager.getInstance().playSe(SoundId.SE_GUSTAV_HIT);
                this._phaseActionPhaseBullet = this._PHASE_ACTION_PHASE_BULLET_IMPACT;
            }
            return;
        }// end function

        private function controlBulletImpact() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this._bDamageDisplayed && this._mcImpactEffect.currentLabel == "damageLast")
            {
                if (this._bulletIndex == 0)
                {
                    playDamage(_aTarget[0]);
                }
                else
                {
                    (_aTarget[0] as BattleActionBase).setActionDamage();
                }
                this._bDamageDisplayed = true;
            }
            if (this._mcImpactedPointNull.currentLabel == "end")
            {
                this._mcImpactEffect.visible = false;
                this._mcImpactedBullet.visible = false;
                _loc_1 = _aAttacer[this._bulletIndex];
                _loc_2 = _loc_1.playerDisplay;
                _loc_3 = _loc_2.backupPosition.clone();
                _loc_2.returnParent();
                _loc_2.setReverse(false);
                _loc_4 = _aTarget[0] as BattleActionBase;
                _loc_2.pos = _loc_4.characterDisplay.pos;
                _loc_2.setTargetJump(_loc_3);
                this._phaseActionPhaseBullet = this._PHASE_ACTION_PHASE_BULLET_WAIT;
            }
            return;
        }// end function

        private function bulletAction(param1:Number) : void
        {
            this._bulletTime = this._bulletTime + param1;
            if (this._bulletTime > _BULLET_END_TIME)
            {
                this._bulletTime = _BULLET_END_TIME;
            }
            var _loc_2:* = this._mcBullet.x * 180;
            var _loc_3:* = this._mcBullet.y * 100;
            this._mcBullet.x = this._bulletFirePos.x + this._bulletImpactVec.x * this._bulletTime;
            this._mcBullet.y = this._bulletFirePos.y + this._bulletImpactVec.y * this._bulletTime;
            this._mcBullet.y = this._mcBullet.y - _BULLET_FLY_HEIGHT * EasingBullet(this._bulletTime);
            var _loc_4:* = this._mcBullet.x * 180;
            var _loc_5:* = this._mcBullet.y * 100;
            this._mcBullet.rotation = this._bulletRotate - this._bulletImpactRotate * EasingOutLate(this._bulletTime);
            return;
        }// end function

        override protected function phaseLeave() : void
        {
            super.phaseLeave();
            return;
        }// end function

        override protected function controlLeave() : void
        {
            super.controlLeave();
            return;
        }// end function

        override protected function phaseEnd() : void
        {
            super.phaseEnd();
            return;
        }// end function

        override protected function controlEnd() : void
        {
            super.controlEnd();
            return;
        }// end function

        private static function DistanceSq(param1:int, param2:int, param3:int, param4:int) : Number
        {
            return Math.pow(param1 - param3, 2) + Math.pow(param2 - param4, 2);
        }// end function

        private static function Distance(param1:int, param2:int, param3:int, param4:int) : Number
        {
            return Math.sqrt(DistanceSq(param1, param2, param3, param4));
        }// end function

        private static function Angle(param1:int, param2:int, param3:int, param4:int) : Number
        {
            return Rad2Deg(Math.atan2(param4 - param2, param3 - param1));
        }// end function

        private static function Rad2Deg(param1:Number) : Number
        {
            return param1 * 180 / Math.PI;
        }// end function

        private static function EasingOutLate(param1:Number) : Number
        {
            return param1 * (2 - param1) * 0.5 + param1 * 0.5;
        }// end function

        private static function EasingBullet(param1:Number) : Number
        {
            param1 = param1 * 2;
            if (param1 < 1)
            {
                param1 = param1 - 1;
                return 1 * (param1 * param1 * param1 + 1);
            }
            param1 = param1 - 1;
            return 1 - param1 * param1;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_CarlGustav.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_JUMP2, SoundId.SE_GUSTAV_FIRE, SoundId.SE_GUSTAV_HIT];
            return _loc_1;
        }// end function

    }
}
