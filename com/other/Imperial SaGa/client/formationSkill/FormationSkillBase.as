package formationSkill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import player.*;
    import resource.*;

    public class FormationSkillBase extends Object
    {
        protected const _ACT_LABEL_STOP:String = "stop";
        protected const _ACT_LABEL_START:String = "start";
        protected const _ACT_LABEL_HIT:String = "hit";
        protected const _ACT_LABEL_END:String = "end";
        protected const _ACT_LABEL_BULLET:String = "bullet";
        protected const _ACT_LABEL_DARK_ON:String = "dark_on";
        protected const _ACT_LABEL_DARK_OFF:String = "dark_off";
        protected const _EFFECT_LABEL_START:String = "start";
        protected const _EFFECT_LABEL_DAMAGE:String = "damage";
        protected const _EFFECT_LABEL_DAMAGE_LOOP:String = "damageLoop";
        protected const _EFFECT_LABEL_DAMAGE_LAST:String = "damageLast";
        protected const _EFFECT_LABEL_END:String = "end";
        protected const _EFFECT_MC_HIT:String = "hit_front";
        protected const _EFFECT_MC_GRAND:String = "hit_grand";
        protected const _PHASE_APPROACH:int = 1;
        protected const _PHASE_ACTION:int = 2;
        protected const _PHASE_LEAVE:int = 3;
        protected const _PHASE_END:int = 4;
        protected var _phase:int;
        protected var _mc:MovieClip;
        protected var _aAttacer:Array;
        protected var _aTarget:Array;
        protected var _targetDisplayPos:Point;
        protected var _effectManager:EffectManager;
        protected var _layer:LayerBattle;
        protected var _aNullMc:Array;
        protected var _aWeaponMc:Array;
        private var _aEffect:Array;
        private var _mcLabel:String;
        protected var _battleManager:BattleManager;
        protected var _bSkillEnd:Boolean;
        private var _bValidateMain:Boolean;
        static const _ACT_LABEL_FRONT:String = "action_front";

        public function FormationSkillBase(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            this._bSkillEnd = false;
            this._layer = param1;
            this._aAttacer = param2;
            this._aTarget = param3;
            this._effectManager = param4;
            this._aEffect = [];
            this._aWeaponMc = [];
            this._targetDisplayPos = new Point();
            for each (_loc_5 in this._aAttacer)
            {
                
                _loc_5.characterDisplay.backupParent();
            }
            for each (_loc_6 in this._aTarget)
            {
                
                _loc_6.characterDisplay.backupParent();
            }
            for each (_loc_7 in this._aAttacer)
            {
                
                _loc_7.setActionAttack();
            }
            return;
        }// end function

        public function setBattleManager(param1:BattleManager) : void
        {
            this._battleManager = param1;
            return;
        }// end function

        public function get bSkillEnd() : Boolean
        {
            return this._bSkillEnd;
        }// end function

        protected function get bValidateMain() : Boolean
        {
            return this._bValidateMain;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_1 in this._aAttacer)
            {
                
                _loc_1.disableActionEndWait();
            }
            for each (_loc_2 in this._aEffect)
            {
                
                _loc_4 = _loc_2.effect;
                if (_loc_4 != null)
                {
                    this._effectManager.releaseEffect(_loc_4);
                }
            }
            for each (_loc_3 in _loc_3)
            {
                
                if (_loc_3.parent)
                {
                    _loc_3.parent.removeChild(_loc_3);
                }
            }
            _loc_3 = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            this._aAttacer = null;
            this._aTarget = null;
            this._effectManager = null;
            this._battleManager = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this.controlMainMc();
            this.selectControl(param1);
            this.controlEffect(param1);
            return;
        }// end function

        protected function selectControl(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_APPROACH:
                {
                    this.controlApproach();
                    break;
                }
                case this._PHASE_ACTION:
                {
                    this.controlAction();
                    break;
                }
                case this._PHASE_LEAVE:
                {
                    this.controlLeave();
                    break;
                }
                case this._PHASE_END:
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

        private function controlMainMc() : void
        {
            this._bValidateMain = this._mcLabel != this._mc.currentLabel;
            this._mcLabel = this._mc.currentLabel;
            return;
        }// end function

        public function setWeapon() : void
        {
            return;
        }// end function

        protected function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                this.selectPhase();
            }
            return;
        }// end function

        protected function selectPhase() : void
        {
            switch(this._phase)
            {
                case this._PHASE_APPROACH:
                {
                    this.phaseApproach();
                    break;
                }
                case this._PHASE_ACTION:
                {
                    this.phaseAction();
                    break;
                }
                case this._PHASE_LEAVE:
                {
                    this.phaseLeave();
                    break;
                }
                case this._PHASE_END:
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

        protected function phaseApproach() : void
        {
            return;
        }// end function

        protected function controlApproach() : void
        {
            if (this.bMoveing() == false)
            {
                this.setPhase(this._PHASE_ACTION);
            }
            return;
        }// end function

        protected function phaseAction() : void
        {
            return;
        }// end function

        protected function controlAction() : void
        {
            return;
        }// end function

        protected function phaseLeave() : void
        {
            return;
        }// end function

        protected function controlLeave() : void
        {
            if (this.bMoveing() == false)
            {
                this.setPhase(this._PHASE_END);
            }
            return;
        }// end function

        protected function phaseEnd() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aNullMc.length)
            {
                
                _loc_2 = this._aAttacer[_loc_1];
                if (_loc_2 != null)
                {
                    _loc_2.characterDisplay.returnParent();
                    _loc_2.disableActionEndWait();
                }
                _loc_1++;
            }
            this._bSkillEnd = true;
            return;
        }// end function

        protected function controlEnd() : void
        {
            return;
        }// end function

        protected function setLeave() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aNullMc.length)
            {
                
                _loc_3 = this._aAttacer[_loc_1];
                _loc_4 = this._aNullMc[_loc_1];
                if (_loc_3 != null && _loc_3.type == CharacterDisplayBase.TYPE_PLAYER)
                {
                    _loc_5 = _loc_3.characterDisplay as PlayerDisplay;
                    _loc_6 = new Point(this._mc.x, this._mc.y);
                    _loc_5.pos = _loc_6.add(new Point(_loc_4.x, _loc_4.y));
                    _loc_5.setTargetJump(_loc_5.backupPosition);
                }
                _loc_1++;
            }
            for each (_loc_2 in this._aNullMc)
            {
                
                _loc_2.visible = false;
            }
            return;
        }// end function

        protected function setTarget(param1:BattleActionBase) : void
        {
            var _loc_2:* = param1.characterDisplay;
            var _loc_3:* = _loc_2.getEffectNullMatrix();
            var _loc_4:* = _loc_2.pos.add(new Point(_loc_3.tx, _loc_3.ty));
            this._targetDisplayPos = _loc_4;
            this._mc.x = _loc_4.x;
            this._mc.y = _loc_4.y;
            return;
        }// end function

        protected function bMoveing() : Boolean
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aAttacer)
            {
                
                _loc_2 = _loc_1.characterDisplay as PlayerDisplay;
                if (_loc_2.bMoveing == true)
                {
                    return true;
                }
            }
            return false;
        }// end function

        protected function addEffect(param1:EffectMc, param2:Function = null, param3:Function = null) : void
        {
            var _loc_4:* = {};
            {}.effect = param1;
            _loc_4.cbUpdate = param2;
            _loc_4.controlCallback = param3;
            _loc_4.markedFrame = 0;
            this._aEffect.push(_loc_4);
            this._effectManager.addEffect(param1);
            return;
        }// end function

        private function controlEffect(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this._aEffect)
            {
                
                _loc_3 = _loc_2.effect;
                if (_loc_3.isEnd())
                {
                    this.releaseEffect(_loc_3);
                    this._aEffect.splice(this._aEffect.indexOf(_loc_2), 1);
                    _loc_2 = null;
                    continue;
                }
                if (_loc_2.cbUpdate && _loc_3.mcEffect.currentFrameLabel != null)
                {
                    if (_loc_3.mcEffect.currentFrame != _loc_2.markedFrame)
                    {
                        _loc_2.markedFrame = _loc_3.mcEffect.currentFrame;
                        _loc_2.cbUpdate(_loc_3, _loc_3.mcEffect.currentLabel);
                    }
                }
                if (_loc_2.controlCallback)
                {
                    _loc_2.controlCallback(_loc_3, _loc_3.mcEffect.currentLabel, param1);
                }
                _loc_2.currentLabel = _loc_3.mcEffect.currentLabel;
            }
            return;
        }// end function

        protected function releaseEffect(param1:EffectMc) : void
        {
            this._effectManager.releaseEffect(param1);
            return;
        }// end function

        protected function createWeapon(param1:String) : MovieClip
        {
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.SKILL_PATH + "Weapons.swf", param1);
            return _loc_2;
        }// end function

        protected function playDamage(param1:BattleActionBase) : void
        {
            if (this._battleManager == null)
            {
                return;
            }
            this._battleManager.playDamage(param1.questUniqueId, this.cbDamageHp);
            return;
        }// end function

        private function cbDamageHp(param1:DamageData) : void
        {
            var _loc_2:* = null;
            if (param1.bMiss == false)
            {
                _loc_2 = this._battleManager.getCharacter(param1.questUniqueId);
                _loc_2.characterAction.setActionDamage();
            }
            return;
        }// end function

        protected function getSpeedVector(param1:Point, param2:Point, param3:int) : Point
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            new Point(param2.x - param1.x, param2.y - param1.y).normalize(1);
            var _loc_5:* = new Matrix();
            new Matrix().scale(param3, param3);
            return _loc_5.transformPoint(_loc_4);
        }// end function

        protected function getHitTime(param1:Point, param2:Point, param3:int) : Number
        {
            var _loc_4:* = new Point(param2.x - param1.x, param2.y - param1.y);
            return new Point(param2.x - param1.x, param2.y - param1.y).length / param3;
        }// end function

    }
}
