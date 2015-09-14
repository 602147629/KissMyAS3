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

    public class FormationSkillTest extends FormationSkillBase
    {
        private var _effAfterImage:EffectAfterImage;

        public function FormationSkillTest(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            super(param1, param2, param3, param4);
            _aAttacer = param2.concat();
            for each (_loc_5 in _aAttacer)
            {
                
                _loc_5.characterDisplay.backupParent();
            }
            for each (_loc_6 in _aTarget)
            {
                
                _loc_6.characterDisplay.backupParent();
            }
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "FormationSkill");
            _aNullMc = [_mc.chara1Null, _mc.chara2Null, _mc.chara3Null];
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_mc);
            var _loc_7:* = param3[0];
            var _loc_8:* = param3[0].characterDisplay.pos;
            _mc.x = _loc_8.x;
            _mc.y = _loc_8.y;
            this._effAfterImage = new EffectAfterImage(param1.getLayer(LayerBattle.BACK_EFFECT), param1.getLayer(LayerBattle.CHARACTER), 0.7);
            _effectManager.addEffect(this._effAfterImage);
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            this._effAfterImage = null;
            super.release();
            return;
        }// end function

        override protected function phaseApproach() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            super.phaseApproach();
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length && _loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aNullMc[_loc_1];
                _loc_3 = _aAttacer[_loc_1];
                _loc_4 = _loc_3.playerDisplay;
                _loc_4.setAnimation(PlayerDisplay.LABEL_SIDE_DASH);
                _loc_4.setTargetPoint(_loc_2.localToGlobal(new Point()), 1);
                _loc_1++;
            }
            return;
        }// end function

        override protected function controlApproach() : void
        {
            super.controlApproach();
            return;
        }// end function

        override protected function phaseAction() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            super.phaseAction();
            this._effAfterImage.bDraw = false;
            _loc_1 = 0;
            while (_loc_1 < _aNullMc.length && _loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = _loc_2.playerDisplay;
                _loc_3.setAnimationPattern(_aNullMc[_loc_1]);
                _loc_3.setCharacterAnimation("start");
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < _aNullMc.length && _loc_1 < _aAttacer.length)
            {
                
                _loc_4 = _aNullMc[_loc_1];
                _loc_2 = _aAttacer[_loc_1];
                _loc_2.playerDisplay.pos = new Point();
                _loc_4.addChild(_loc_2.playerDisplay.layer);
                _loc_1++;
            }
            for each (_loc_5 in _aTarget)
            {
                
                _loc_6 = _loc_5.characterDisplay;
                _mc.monsNull.addChild(_loc_6.layer);
                _loc_6.pos = new Point();
            }
            _mc.gotoAndPlay("start");
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.controlAction();
            if (_mc.currentFrame == 21 || _mc.currentFrame == 22 || _mc.currentFrame == 23)
            {
                SoundManager.getInstance().playSe(SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK);
            }
            if (bValidateMain)
            {
                if (_mc.currentLabel == "attack")
                {
                }
                if (_mc.currentLabel == "damage")
                {
                    for each (_loc_1 in _aTarget)
                    {
                        
                        playDamage(_loc_1);
                    }
                    _loc_2 = new EffectShake(_battleManager.battleScreen, 5, 5, 0.7);
                    _effectManager.addEffect(_loc_2);
                }
                if (_mc.currentLabel == "end")
                {
                    setPhase(_PHASE_LEAVE);
                }
            }
            return;
        }// end function

        override protected function phaseLeave() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._effAfterImage.bDraw = true;
            var _loc_1:* = 0;
            while (_loc_1 < _aNullMc.length && _loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aNullMc[_loc_1];
                _loc_3 = _aAttacer[_loc_1];
                _loc_4 = _loc_3.playerDisplay;
                _loc_4.setTargetJump(_loc_2.globalToLocal(_loc_4.backupPosition));
                _loc_4.setReverse(true);
                _loc_1++;
            }
            return;
        }// end function

        override protected function controlLeave() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            _loc_1 = 0;
            while (_loc_1 < _aNullMc.length && _loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = _loc_2.playerDisplay;
                if (_loc_3.bMoveing)
                {
                    return;
                }
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < _aNullMc.length && _loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1];
                _loc_3 = _loc_2.playerDisplay;
                _loc_3.returnParent();
                _loc_3.setReverse(false);
                _loc_1++;
            }
            for each (_loc_4 in _aTarget)
            {
                
                _loc_4.characterDisplay.returnParent();
            }
            setPhase(_PHASE_END);
            return;
        }// end function

        override protected function phaseEnd() : void
        {
            super.phaseEnd();
            _effectManager.releaseEffect(this._effAfterImage);
            this._effAfterImage = null;
            return;
        }// end function

        override protected function controlEnd() : void
        {
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_1.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_RS3_SWORD_LONG_SWORD_NORMAL_ATTACK];
            return _loc_1;
        }// end function

    }
}
