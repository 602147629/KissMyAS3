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
    import sound.*;

    public class FormationSkillP1000HandBuddha extends FormationSkillBase
    {
        private var _aApproachNull:Array;
        private var _aMoveing:Array;
        private static const _LABEL_JUMP_APPROACH:String = "jump_start";
        private static const _LABEL_JUMP_END:String = "jump_end";
        private static const _LABEL_JUMP_LEAVE:String = "end";

        public function FormationSkillP1000HandBuddha(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            super(param1, param2, param3, param4);
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "advance_chara_act");
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_mc);
            setTarget(_aTarget[0]);
            _mc.x = _targetDisplayPos.x;
            _mc.y = _targetDisplayPos.y;
            _aNullMc = [_mc.charaNull, _mc.chara2Null, _mc.chara3Null, _mc.chara4Null, _mc.chara5Null];
            this._aApproachNull = _aNullMc.concat();
            this._aMoveing = _aAttacer.concat();
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            super.phaseApproach();
            return;
        }// end function

        override protected function controlApproach() : void
        {
            super.controlApproach();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_3:* = null;
            super.phaseAction();
            SoundManager.getInstance().playSe(SoundId.SE_SENJYU_GOKOU);
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length)
            {
                
                _loc_3 = _aNullMc[_loc_1];
                if (_loc_3 != null)
                {
                    _loc_3.gotoAndPlay(_ACT_LABEL_START);
                }
                _loc_1++;
            }
            var _loc_2:* = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_FRONT, _targetDisplayPos);
            addEffect(_loc_2);
            _mc.gotoAndPlay(_ACT_LABEL_START);
            _loc_2.mcEffect.gotoAndPlay(_ACT_LABEL_START);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.controlAction();
            if (this._aApproachNull.length > 0)
            {
                this.approachLeaveCheck();
            }
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
                        addEffect(_loc_4, this.cbEffectUpdate);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
                        if (this._aApproachNull.length == 0)
                        {
                            setPhase(_PHASE_LEAVE);
                        }
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
                    SoundManager.getInstance().playSe(SoundId.SE_SENJYU_DAMAGE);
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_SENJYU_DAMAGE);
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

        private function approachLeaveCheck() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_1:* = this._aApproachNull.length - 1;
            while (_loc_1 >= 0)
            {
                
                _loc_2 = this._aApproachNull[_loc_1];
                if (_loc_2 != null)
                {
                    _loc_3 = _loc_2.currentFrameLabel;
                    _loc_4 = new Point(_targetDisplayPos.x + _loc_2.x, _targetDisplayPos.y + _loc_2.y);
                    if (_loc_3 == _LABEL_JUMP_APPROACH)
                    {
                        _loc_5 = this._aMoveing[_loc_1];
                        _loc_6 = _loc_5.characterDisplay as PlayerDisplay;
                        _loc_6.setTargetJump(_loc_4);
                    }
                    if (_loc_3 == _LABEL_JUMP_END)
                    {
                        _loc_7 = this._aMoveing[_loc_1];
                        _loc_8 = _loc_7.characterDisplay as PlayerDisplay;
                        _loc_8.setAnimationPattern(_loc_2);
                    }
                    if (_loc_3 == _LABEL_JUMP_LEAVE)
                    {
                        _loc_9 = this._aMoveing[_loc_1];
                        _loc_10 = _loc_9.characterDisplay as PlayerDisplay;
                        (_loc_9.characterDisplay as PlayerDisplay).setTargetJump(_loc_10.backupPosition);
                        this._aApproachNull.splice(_loc_1, 1);
                        this._aMoveing.splice(_loc_1, 1);
                    }
                }
                _loc_1 = _loc_1 - 1;
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_1000HandBuddha.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            return [SoundId.SE_SENJYU_GOKOU, SoundId.SE_SENJYU_DAMAGE];
        }// end function

    }
}
