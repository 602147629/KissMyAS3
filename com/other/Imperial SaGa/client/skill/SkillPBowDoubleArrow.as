package skill
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

    public class SkillPBowDoubleArrow extends SkillPositionBase
    {
        private var _layerArrow:DisplayObjectContainer;
        private var _aNullMc:Array;
        private var _aArrow:Array;
        private var _aCharacter:Array;
        private const _SHOT_SPEED:int = 1500;

        public function SkillPBowDoubleArrow(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            super(param1, param2, param3, param4, param5, getResource());
            this._layerArrow = _layer.getLayer(LayerBattle.FRONT_EFFECT);
            this._aCharacter = [];
            this._aArrow = [];
            this._aNullMc = [];
            this.createMirage();
            setPhase(_PHASE_WAIT);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_2 = 1;
                while (_loc_2 < this._aCharacter.length)
                {
                    
                    _loc_3 = this._aCharacter[_loc_2];
                    if (_loc_3)
                    {
                        _loc_3.release();
                    }
                    _loc_2++;
                }
            }
            this._aCharacter = null;
            for each (_loc_1 in this._aArrow)
            {
                
                _loc_1.release();
            }
            this._aArrow = null;
            this._aNullMc = null;
            this._layerArrow = null;
            super.release();
            return;
        }// end function

        override protected function selectControl(param1:Number) : void
        {
            switch(_phase)
            {
                case _PHASE_WAIT:
                {
                    controlWait();
                    break;
                }
                case _PHASE_ACTION:
                {
                    switch(_skillUser.type)
                    {
                        case CharacterDisplayBase.TYPE_PLAYER:
                        {
                            this.controlPlayerAction(param1);
                            break;
                        }
                        case CharacterDisplayBase.TYPE_ENEMY:
                        {
                            this.controlEnemyAction(param1);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
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
                case _PHASE_WAIT:
                {
                    phaseWait();
                    break;
                }
                case _PHASE_ACTION:
                {
                    this.phaseAction();
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

        override protected function phaseAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            super.phaseAction();
            SoundManager.getInstance().playSe(SoundId.SE_REV_BOW_NIHONUCHI_SHINE);
            if (_skillUser.type != CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_1 = _skillUserDisplay.pos;
                _loc_2 = _skillUserDisplay.getEffectNullMatrix();
                _skillUserBulletPos = new Point(_skillUserDisplay.pos.x + _loc_2.tx, _skillUserDisplay.pos.y + _loc_2.ty);
                _loc_3 = new Point(_skillUserBulletPos.x, _skillUserBulletPos.y + 32);
                _loc_4 = new Point(_skillUserBulletPos.x, _skillUserBulletPos.y - 32);
                _loc_5 = this.createArrow(_loc_3, getSpeedVector(_loc_3, _targetHitFrontPos, this._SHOT_SPEED));
                _loc_5.setHitMake(getHitTime(_loc_3, _targetHitFrontPos, this._SHOT_SPEED));
                this._aArrow.push(_loc_5);
                _loc_6 = this.createArrow(_loc_4, getSpeedVector(_loc_4, _targetHitFrontPos, this._SHOT_SPEED));
                _loc_5.setHitMake(getHitTime(_loc_4, _targetHitFrontPos, this._SHOT_SPEED));
                this._aArrow.push(_loc_6);
                SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
            }
            return;
        }// end function

        private function controlPlayerAction(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            for each (_loc_2 in this._aNullMc)
            {
                
                if (_loc_2.currentFrameLabel == _ACT_LABEL_BULLET)
                {
                    _loc_3 = _loc_2.bulletStartNullMc;
                    _loc_4 = _skillUserDisplay.pos;
                    _loc_5 = new Point(_loc_4.x + _loc_2.x + _loc_3.x, _loc_4.y + _loc_2.y + _loc_3.y);
                    _loc_6 = this.createArrow(_loc_5, getSpeedVector(_loc_5, _targetHitFrontPos, this._SHOT_SPEED));
                    _loc_6.setHitMake(getHitTime(_loc_5, _targetHitFrontPos, this._SHOT_SPEED));
                    this._aArrow.push(_loc_6);
                    SoundManager.getInstance().playSe(SoundId.SE_RS3_BOW_BOW);
                }
            }
            this.controlArrow(param1);
            return;
        }// end function

        private function controlArrow(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_2 in this._aArrow)
            {
                
                _loc_2.control(param1);
                if (_loc_2.bHit)
                {
                    _loc_2.release();
                    this._aArrow.splice(this._aArrow.indexOf(_loc_2), 1);
                    if (this._aArrow.length == 0)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                        playDamage(_target);
                        _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_4, this.cbSetEffectPhase);
                    }
                }
            }
            return;
        }// end function

        private function controlArrowEnemy(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_2 in this._aArrow)
            {
                
                _loc_2.control(param1);
                if (_loc_2.bHit)
                {
                    for each (_loc_3 in this._aArrow)
                    {
                        
                        _loc_3.release();
                    }
                    this._aArrow.length = 0;
                    if (this._aArrow.length == 0)
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                        playDamage(_target);
                        _loc_5 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                        addEffect(_loc_5, this.cbSetEffectPhase);
                    }
                }
            }
            return;
        }// end function

        private function controlEnemyAction(param1:Number) : void
        {
            var _loc_2:* = null;
            if (_bValidateMain)
            {
                if (_baseMc.currentLabel == _ACT_LABEL_END)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_ARROW_HIT);
                    playDamageAll();
                    _loc_2 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _targetHitFrontPos, _bReverse);
                    addEffect(_loc_2, this.cbSetEffectPhase);
                }
            }
            this.controlArrowEnemy(param1);
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_END:
                {
                    setPhase(_PHASE_END);
                }
                default:
                {
                    break;
                }
            }
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

        private function createArrow(param1:Point, param2:Point) : SkillPartsArrow
        {
            var _loc_3:* = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
            var _loc_4:* = new SkillPartsArrow(this._layerArrow, _loc_3, param1, param2);
            return new SkillPartsArrow(this._layerArrow, _loc_3, param1, param2);
        }// end function

        override protected function setAnimationPattarn() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (_skillUser.type != CharacterDisplayBase.TYPE_PLAYER)
            {
                return;
            }
            var _loc_1:* = 0;
            while (_loc_1 < this._aCharacter.length)
            {
                
                _loc_2 = this._aCharacter[_loc_1];
                _loc_3 = _baseMc.getChildByName("charaNull" + ((_loc_1 + 1)).toString()) as MovieClip;
                _loc_2.setAnimationPattern(_loc_3);
                _loc_3.gotoAndPlay(_ACT_LABEL_START);
                this._aNullMc.push(_loc_3);
                _loc_1++;
            }
            return;
        }// end function

        private function createMirage() : void
        {
            var _loc_3:* = null;
            if (_skillUser.type != CharacterDisplayBase.TYPE_PLAYER)
            {
                return;
            }
            this._aCharacter.push(_skillUser.characterDisplay);
            var _loc_1:* = _skillUserDisplay as PlayerDisplay;
            var _loc_2:* = 1;
            while (_loc_2 < 3)
            {
                
                _loc_3 = new PlayerDisplay(_layer.getLayer(LayerBattle.CHARACTER), _loc_1.info.id, _loc_1.uniqueId);
                this._aCharacter.push(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        override public function setWeapon(param1:int) : void
        {
            var _loc_3:* = null;
            super.setWeapon(param1);
            var _loc_2:* = 0;
            while (_loc_2 < this._aCharacter.length)
            {
                
                _loc_3 = _baseMc.getChildByName("charaNull" + ((_loc_2 + 1)).toString()) as MovieClip;
                this.setWeaponMirage(param1, _loc_3);
                _loc_2++;
            }
            return;
        }// end function

        public function setWeaponMirage(param1:int, param2:MovieClip) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            if (_skillUserDisplay.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                return;
            }
            if (param2 != null)
            {
                _loc_3 = SkillManager.getInstance().getWeaponClassNameFromSkillType(SkillConstant.SKILL_TYPE_BOW);
                _loc_4 = param2.getChildByName("bow_Null2") as DisplayObjectContainer;
                _loc_5 = param2.getChildByName("bow1_Null") as DisplayObjectContainer;
                if (_loc_4 != null && _loc_5 != null)
                {
                    _loc_6 = createWeapon(_loc_3);
                    _loc_7 = createWeapon(_loc_3);
                    _loc_6.gotoAndStop(1);
                    _loc_7.gotoAndStop(2);
                    _loc_4.addChild(_loc_6);
                    _loc_5.addChild(_loc_7);
                    _aWeaponMc.push(_loc_6);
                    _aWeaponMc.push(_loc_7);
                }
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.SKILL_PATH + "Skill_Bow_DoubleShot.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SoundId.SE_REV_BOW_NIHONUCHI_SHINE, SoundId.SE_ARROW_HIT, SoundId.SE_RS3_BOW_BOW];
            return _loc_1;
        }// end function

    }
}
