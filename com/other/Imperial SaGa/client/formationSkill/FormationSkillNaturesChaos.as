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
    import utility.*;

    public class FormationSkillNaturesChaos extends FormationSkillBase
    {
        private var _aAttackMemberMc:Array;
        private var _aBullet:Array;
        private var _fade:Fade;
        private var _attackMember:int;
        private var _waitFrame:int;
        private static const WAIT_FRAME:int = 2;
        private static const aNotDisplayWeapon:Array = [CommonConstant.CHARACTER_WEAPONTYPE_AX, CommonConstant.CHARACTER_WEAPONTYPE_BOW, CommonConstant.CHARACTER_WEAPONTYPE_CLUB, CommonConstant.CHARACTER_WEAPONTYPE_HALBERD, CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS, CommonConstant.CHARACTER_WEAPONTYPE_NAIL, CommonConstant.CHARACTER_WEAPONTYPE_SPEAR];

        public function FormationSkillNaturesChaos(param1:LayerBattle, param2:Array, param3:Array, param4:EffectManager)
        {
            super(param1, param2, param3, param4);
            _mc = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
            this._aAttackMemberMc = [];
            this._aBullet = [];
            setPhase(_PHASE_APPROACH);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.release();
            for each (_loc_1 in this._aBullet)
            {
                
                _loc_1.release();
            }
            this._aBullet = [];
            for each (_loc_2 in this._aAttackMemberMc)
            {
                
                if (_loc_2)
                {
                    if (_loc_2.parent)
                    {
                        _loc_2.parent.removeChild(_loc_2);
                    }
                }
            }
            this._aAttackMemberMc = [];
            if (this._fade)
            {
                this._fade.release();
            }
            this._fade = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            super.control(param1);
            for each (_loc_2 in this._aBullet)
            {
                
                _loc_2.control(param1);
            }
            return;
        }// end function

        override public function setWeapon() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < _aAttacer.length)
            {
                
                _loc_2 = _aAttacer[_loc_1] as BattleActionPlayer;
                _loc_3 = _loc_2.playerDisplay.info;
                if (aNotDisplayWeapon.indexOf(_loc_3.weaponType) > -1)
                {
                    Assert.print("剣系の武器以外のキャラクターが参加しています");
                }
                _loc_1++;
            }
            return;
        }// end function

        override protected function phaseAction() : void
        {
            super.phaseAction();
            this._attackMember = 1;
            this._waitFrame = 0;
            var _loc_1:* = _aAttacer[0];
            var _loc_2:* = _loc_1.characterDisplay as PlayerDisplay;
            _loc_2.setAnimationPattern(_mc);
            _mc.x = _loc_2.pos.x;
            _mc.y = _loc_2.pos.y;
            _layer.getLayer(LayerBattle.CHARACTER).addChild(_mc);
            return;
        }// end function

        override protected function controlAction() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            super.controlAction();
            if (this._aAttackMemberMc.length < (_aAttacer.length - 1))
            {
                var _loc_13:* = this;
                var _loc_14:* = this._waitFrame + 1;
                _loc_13._waitFrame = _loc_14;
                if (this._waitFrame >= WAIT_FRAME)
                {
                    this._waitFrame = 0;
                    var _loc_13:* = this;
                    var _loc_14:* = this._attackMember + 1;
                    _loc_13._attackMember = _loc_14;
                    _loc_2 = ResourceManager.getInstance().createMovieClip(getResource(), "position_chara_act");
                    _loc_3 = _aAttacer[(this._attackMember - 1)];
                    _loc_4 = _loc_3.characterDisplay as PlayerDisplay;
                    _loc_4.setAnimationPattern(_loc_2);
                    _loc_2.x = _loc_4.pos.x;
                    _loc_2.y = _loc_4.pos.y;
                    _layer.getLayer(LayerBattle.CHARACTER).addChild(_loc_2);
                    this._aAttackMemberMc.push(_loc_2);
                }
            }
            if (bValidateMain)
            {
                switch(_mc.currentLabel)
                {
                    case _ACT_LABEL_HIT:
                    {
                        _loc_7 = 0;
                        while (_loc_7 < _aTarget.length)
                        {
                            
                            _loc_8 = _aTarget[_loc_7];
                            _loc_9 = _loc_8.characterDisplay;
                            _loc_10 = _loc_9.getEffectNullMatrix();
                            _loc_11 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, _loc_9.pos.add(new Point(_loc_10.tx, _loc_10.ty)));
                            addEffect(_loc_11, this.cbEffectUpdate);
                            _loc_7++;
                        }
                        break;
                    }
                    case _ACT_LABEL_BULLET:
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_SWISH);
                        _loc_5 = _aAttacer[_loc_7] as BattleActionPlayer;
                        this.createBullet(_loc_5, _mc);
                        _loc_6 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_FRONT, _targetDisplayPos);
                        addEffect(_loc_6);
                        break;
                    }
                    case _ACT_LABEL_DARK_ON:
                    {
                        this._fade = new Fade(_layer.getLayer(LayerBattle.BACKGROUND));
                        this._fade.maxAlpha = 0.8;
                        this._fade.setFadeIn(30);
                        break;
                    }
                    case _ACT_LABEL_DARK_OFF:
                    {
                        this._fade.setFadeOut(Constant.FADE_OUT_TIME);
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
            _loc_7 = 1;
            for each (_loc_1 in this._aAttackMemberMc)
            {
                
                if (_loc_1 && _loc_1.currentFrameLabel == _ACT_LABEL_BULLET)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_SWISH);
                    _loc_12 = _aAttacer[_loc_7] as BattleActionPlayer;
                    this.createBullet(_loc_12, _loc_1);
                }
                _loc_7++;
            }
            return;
        }// end function

        override protected function phaseEnd() : void
        {
            return;
        }// end function

        override protected function controlEnd() : void
        {
            super.controlEnd();
            var _loc_1:* = this._aAttackMemberMc[(this._aAttackMemberMc.length - 1)];
            var _loc_2:* = this._aBullet[(this._aBullet.length - 1)];
            if (_loc_1.currentLabel == _ACT_LABEL_END && _loc_2.bEnd == true)
            {
                _bSkillEnd = true;
            }
            return;
        }// end function

        private function createBullet(param1:BattleActionPlayer, param2:MovieClip) : void
        {
            var _loc_3:* = param1.playerDisplay;
            var _loc_4:* = _loc_3.info;
            var _loc_5:* = _loc_3.mc.localToGlobal(new Point());
            var _loc_6:* = new FormationSkillNaturesChaosBullet(param2.bulletStartNullMc, param1.playerDisplay.effectNull, _loc_4.weaponType, _loc_5.y < Constant.SCREEN_HEIGHT_HALF);
            this._aBullet.push(_loc_6);
            return;
        }// end function

        protected function cbEffectUpdate(param1:EffectMc, param2:String) : void
        {
            var _loc_3:* = null;
            switch(param2)
            {
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_SWORD1);
                    for each (_loc_3 in _aTarget)
                    {
                        
                        playDamage(_loc_3);
                    }
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function getResource() : String
        {
            return ResourcePath.FORMATION_SKILL_PATH + "FormationSkill_NaturesChaos.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            return [SoundId.SE_SWORD1, SoundId.SE_SWISH];
        }// end function

    }
}
