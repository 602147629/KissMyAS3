package formationSkill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import layer.*;
    import player.*;
    import resource.*;
    import sound.*;

    public class FormationSkillPJackknife extends FormationSkillBase
    {
        private const _APPROACH_WAIT_FRAME:int = 4;
        private var _mc2:MovieClip;
        private var _jumpApproach:PlayerDisplay;
        private var _bEndApproach:Boolean;
        private var _waitCount:int;

        public function FormationSkillPJackknife(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            super(param1, param2, param3, param4);
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            this._mc2 = ResourceManager.getInstance().createMovieClip(getResource(), "advance_grand_chara_act");
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_mc);
            _layer.getLayer(LayerBattle.CHARACTER).addChild(this._mc2);
            setTarget(_aTarget[0]);
            this._mc2.x = _targetDisplayPos.x;
            this._mc2.y = _targetDisplayPos.y;
            _aNullMc = [_mc.charaNull, _mc.chara2Null, this._mc2.charaNull];
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._mc2 && this._mc2.parent != null)
            {
                this._mc2.parent.removeChild(this._mc2);
            }
            this._mc2 = null;
            this._jumpApproach = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            return;
        }// end function

        override public function setWeapon() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length)
            {
                
                _loc_2 = _aAttacer[_loc_1] as BattleActionPlayer;
                _loc_3 = _aNullMc[_loc_1];
                _loc_4 = _loc_2.playerDisplay.info;
                if (_loc_4.weaponType == CommonConstant.CHARACTER_WEAPONTYPE_SWORD)
                {
                    _loc_5 = _loc_3.getChildByName("weaponNull") as MovieClip;
                    _loc_6 = FormationManager.getInstance().getWeaponClassName(_loc_4.weaponType);
                    _loc_7 = createWeapon(_loc_6);
                    _loc_7.gotoAndStop(1);
                    _loc_5.addChild(_loc_7);
                    _aWeaponMc.push(_loc_7);
                }
                _loc_1++;
            }
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            var _loc_3:* = null;
            SoundManager.getInstance().playSe(SoundId.SE_JUMP2);
            super.phaseApproach();
            this._bEndApproach = false;
            var _loc_1:* = _aNullMc[(_aNullMc.length - 1)];
            var _loc_2:* = _aAttacer[(_aNullMc.length - 1)];
            if (_loc_2.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_3 = new Point(_targetDisplayPos.x + _loc_1.x, _targetDisplayPos.y + _loc_1.y);
                this._jumpApproach = _loc_2.characterDisplay as PlayerDisplay;
                this._jumpApproach.setTargetJump(_loc_3);
            }
            return;
        }// end function

        override protected function controlApproach() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._bEndApproach)
            {
                super.controlApproach();
            }
            else
            {
                var _loc_6:* = this;
                var _loc_7:* = this._waitCount + 1;
                _loc_6._waitCount = _loc_7;
                if (this._waitCount == this._APPROACH_WAIT_FRAME)
                {
                    this._bEndApproach = true;
                    _loc_1 = 0;
                    while (_loc_1 < (_aNullMc.length - 1))
                    {
                        
                        _loc_2 = _aAttacer[_loc_1];
                        _loc_3 = _aNullMc[_loc_1];
                        if (_loc_2.type == CharacterDisplayBase.TYPE_PLAYER)
                        {
                            _loc_4 = new Point(_targetDisplayPos.x + _loc_3.x, _targetDisplayPos.y + _loc_3.y);
                            _loc_5 = _loc_2.characterDisplay as PlayerDisplay;
                            _loc_5.setAnimSideDash();
                            _loc_5.setTargetPoint(_loc_4, 0.3);
                        }
                        _loc_1++;
                    }
                }
            }
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseAction();
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = _aNullMc[_loc_1];
                if (_loc_2 != null && _loc_3 != null)
                {
                    _loc_4 = _loc_2.characterDisplay as PlayerDisplay;
                    _loc_4.setAnimationPattern(_loc_3);
                    _loc_3.gotoAndPlay(_ACT_LABEL_START);
                }
                _loc_1++;
            }
            _mc.gotoAndPlay(_ACT_LABEL_START);
            this._mc2.gotoAndPlay(_ACT_LABEL_START);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            super.controlAction();
            if (bValidateMain)
            {
                switch(_mc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_1 = _aTarget[0];
                        _loc_2 = _loc_1.characterDisplay;
                        _loc_3 = _loc_2.getEffectNullMatrix();
                        _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_2.pos.add(new Point(_loc_3.tx, _loc_3.ty)));
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_GRAND, _loc_2.pos.add(new Point(_loc_3.tx, _loc_3.ty)));
                        addEffect(_loc_4, this.cbEffectUpdate);
                        addEffect(_loc_5, this.cbGrandEffectUpdate);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        setPhase(_PHASE_LEAVE);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        override protected function phaseLeave() : void
        {
            super.phaseLeave();
            setLeave();
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

        protected function cbEffectUpdate(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_XX);
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    _loc_3 = _aTarget[0];
                    playDamage(_loc_3);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        protected function cbGrandEffectUpdate(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_JACKKNIFE);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_Jackknife.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            return [SoundId.SE_JACKKNIFE, SoundId.SE_XX, SoundId.SE_JUMP2];
        }// end function

    }
}
