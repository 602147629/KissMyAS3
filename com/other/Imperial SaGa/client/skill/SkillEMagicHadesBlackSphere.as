package skill
{
    import battle.*;
    import character.*;
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;

    public class SkillEMagicHadesBlackSphere extends SkillMagicBase
    {
        private var _formationPos:Point;
        private const _PHASE_BULLET_CREATE:int = 20;
        private const _PHASE_BULLET:int = 30;
        private const _PHASE_HIT:int = 40;
        private var _createBullet:EffectMc;
        private var _aBullet:Array;
        private const BULLET_SPEED:int = 300;

        public function SkillEMagicHadesBlackSphere(param1:LayerBattle, param2:BattleActionBase, param3:Array, param4:Boolean, param5:EffectManager)
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            super(param1, param2, param3, param4, param5, getResource());
            if (bossEffectCreate(_BOSS_ARIA_HADES))
            {
                playCastingSE();
            }
            var _loc_6:* = ResourceManager.getInstance().createMovieClip(getResource(), "nullPosition");
            if (_skillUser.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                _loc_7 = _loc_6.enemyNullMc;
                this._formationPos = new Point((_loc_7.x + _loc_7.width) / 2, (_loc_7.y + _loc_7.height) / 2);
            }
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                _loc_8 = _loc_6.playerNullMc;
                this._formationPos = new Point(_loc_8.x, _loc_8.y);
            }
            setPhase(_PHASE_WAIT);
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
                    this.controlAction();
                    break;
                }
                case _PHASE_END:
                {
                    this.controlEnd();
                    break;
                }
                case this._PHASE_BULLET_CREATE:
                {
                    this.controlBulletCreate();
                    break;
                }
                case this._PHASE_BULLET:
                {
                    this.controlBullet(param1);
                    break;
                }
                case this._PHASE_HIT:
                {
                    this.controlHit();
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
                case this._PHASE_BULLET_CREATE:
                {
                    this.phaseBulletCreate();
                    break;
                }
                case this._PHASE_BULLET:
                {
                    this.phaseBullet();
                    break;
                }
                case this._PHASE_HIT:
                {
                    this.phaseHit();
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
            super.phaseAction();
            if (isBoss() == false)
            {
                playCastingSE();
            }
            return;
        }// end function

        override protected function controlAction() : void
        {
            super.controlAction();
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_BULLET:
                    {
                        setPhase(this._PHASE_BULLET_CREATE);
                        break;
                    }
                    case _ACT_LABEL_END:
                    {
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

        private function phaseBulletCreate() : void
        {
            var _loc_1:* = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
            this._createBullet = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _ACT_LABEL_START_FRONT, _loc_1, _bReverse);
            addEffect(this._createBullet);
            SoundManager.getInstance().playSe(SoundId.SE_REV_DARK_BLACKSPHERE_EFFECT);
            return;
        }// end function

        private function controlBulletCreate() : void
        {
            if (this._createBullet.mcEffect.currentLabel == _ACT_LABEL_BULLET)
            {
                setPhase(this._PHASE_BULLET);
                this._createBullet.release();
            }
            return;
        }// end function

        private function phaseBullet() : void
        {
            if (_skillUser.type == CharacterDisplayBase.TYPE_ENEMY)
            {
                if (isBoss())
                {
                    _bossEffect.gotoAndPlay(_ACT_LABEL_BACK);
                }
            }
            this._aBullet = [];
            var _loc_1:* = getMagicBulletStartNull(_baseMc.bulletStartNullMc);
            var _loc_2:* = this.getSpeedVector(_loc_1, this._formationPos, this.BULLET_SPEED);
            var _loc_3:* = this.getHitTime(_loc_1, this._formationPos, this.BULLET_SPEED);
            var _loc_4:* = ResourceManager.getInstance().createMovieClip(getResource(), "bullet");
            var _loc_5:* = new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_4, _loc_1, _loc_2);
            new SkillPartsArrow(_layer.getLayer(LayerBattle.CHARACTER), _loc_4, _loc_1, _loc_2).setHitMake(_loc_3);
            this._aBullet.push(_loc_5);
            return;
        }// end function

        private function controlBullet(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = this._aBullet.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aBullet[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.bHit)
                {
                    _loc_4 = new EffectMc(_layer.getLayer(LayerBattle.FRONT_EFFECT), getResource(), _EFFECT_MC_HIT, this._formationPos, _bReverse);
                    addEffect(_loc_4, this.cbSetEffectPhase);
                    _loc_3.release();
                    this._aBullet.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._aBullet.length == 0)
            {
                setPhase(this._PHASE_HIT);
            }
            return;
        }// end function

        private function cbSetEffectPhase(param1:EffectMc, param2:String) : void
        {
            switch(param2)
            {
                case _EFFECT_LABEL_START:
                {
                    break;
                }
                case _EFFECT_LABEL_DAMAGE_LAST:
                {
                    SoundManager.getInstance().playSe(SoundId.SE_REV_DARK_BLACKSPHERE_HIT);
                    playDamageAll();
                    break;
                }
                case _EFFECT_LABEL_END:
                {
                    _baseMc.gotoAndPlay(_ACT_LABEL_BACK);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function phaseHit() : void
        {
            return;
        }// end function

        private function controlHit() : void
        {
            if (_bValidateMain)
            {
                switch(_baseMc.currentLabel)
                {
                    case _ACT_LABEL_END:
                    {
                        setPhase(_PHASE_END);
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

        public static function getResource() : String
        {
            return ResourcePath.SKILL_ENEMY_PATH + "Magic_Hades_BlackSphere.swf";
        }// end function

        public static function getSeIdList() : Array
        {
            var _loc_1:* = [SkillMagicBase._TEMP_CASTING_SE, SoundId.SE_REV_DARK_BLACKSPHERE_EFFECT, SoundId.SE_REV_DARK_BLACKSPHERE_HIT];
            return _loc_1;
        }// end function

    }
}
