package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossSevenHeroes extends EnemyDisplayMetamorphoseBase
    {
        private var _effectLightMain:EnemyParticleMain;
        private var _effectAfterImage:EnemyEffectAfterImage;
        private static const _WAIT_TIME:Number = 0.3;
        private static const _VEC_LIGHT_MAGIC:Number = 200;
        private static const _EFFECT_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Scales01.png";

        public function EnemyBossSevenHeroes(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            var _loc_4:* = ResourceManager.getInstance().createBitmap(_EFFECT_PATH);
            var _loc_5:* = [new ColorTransform(1, 1, 1)];
            this._effectAfterImage = new EnemyEffectAfterImage(_layer.getLayer(LayerCharacter.BACK_EFFECT), _mc);
            this._effectAfterImage.blurPow = new Point(0, 0);
            this._effectAfterImage.blurVec = new Point(-5, -30);
            this._effectAfterImage.blurColor = new ColorTransform(1, 0, 0.8, 1);
            this._effectAfterImage.blurEndColor = new ColorTransform(1, 0, 0.8, 0);
            this._effectAfterImage.bBlurFront = false;
            this._effectAfterImage.blendMode = BlendMode.ADD;
            var _loc_6:* = 0;
            switch(param2)
            {
                case EnemyId.id_mons_SevenHeroes_First_RS2:
                {
                    _loc_6 = _WAIT_TIME;
                    this._effectAfterImage.blurTime = 1.5;
                    this._effectAfterImage.blurLiveTime = 1.2;
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_Second_RS2:
                {
                    _loc_6 = _WAIT_TIME;
                    this._effectAfterImage.blurTime = 1.2;
                    this._effectAfterImage.blurLiveTime = 1;
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_Thrid_RS2:
                {
                    _loc_6 = _WAIT_TIME;
                    this._effectAfterImage.blurTime = 1.1;
                    this._effectAfterImage.blurLiveTime = 0.8;
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_Forth_RS2:
                {
                    _loc_6 = _WAIT_TIME * 2;
                    this._effectAfterImage.blurTime = 1;
                    this._effectAfterImage.blurLiveTime = 0.8;
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_Fifth_RS2:
                {
                    _loc_6 = _WAIT_TIME * 4;
                    this._effectAfterImage.blurTime = 0.9;
                    this._effectAfterImage.blurLiveTime = 0.8;
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_Sixth_RS2:
                {
                    this._effectAfterImage.blurTime = 0.7;
                    this._effectAfterImage.blurLiveTime = 0.8;
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_Final_RS2:
                {
                    this._effectAfterImage.blurTime = 0.5;
                    this._effectAfterImage.blurLiveTime = 0.8;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_6 > 0)
            {
                this._effectLightMain = new EnemyParticleMain(_layer.getLayer(LayerCharacter.FRONT_EFFECT), this.cbParticlePartsCreate, _loc_6, _loc_4, _loc_5);
                this._effectLightMain.setCallBackControl(this.cbParticleControl);
            }
            this._effectAfterImage.setBlurEffect();
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectAfterImage)
            {
                this._effectAfterImage.release();
            }
            this._effectAfterImage = null;
            if (this._effectLightMain)
            {
                this._effectLightMain.release();
            }
            this._effectLightMain = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            if (this._effectLightMain != null)
            {
                this._effectLightMain.control(param1);
            }
            if (this._effectAfterImage != null)
            {
                this._effectAfterImage.control(param1);
            }
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            switch(_labelAnim)
            {
                case _LABEL_STAY:
                {
                    if (_bLabelAnimChange)
                    {
                        if (this._effectLightMain != null)
                        {
                            this._effectLightMain.bHiSpeed = false;
                        }
                    }
                    break;
                }
                case _LABEL_MAGIC:
                {
                    if (_bLabelAnimChange)
                    {
                        if (this._effectLightMain != null)
                        {
                            this._effectLightMain.bHiSpeed = true;
                        }
                    }
                    break;
                }
                case _LABEL_CHANGE_OUT:
                {
                    break;
                }
                case _LABEL_CHANGE_IN:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.playSeMotion();
            return;
        }// end function

        private function cbParticlePartsCreate(param1:DisplayObjectContainer, param2:BitmapData) : EffectParticleBase
        {
            if (_mc.currentLabel == _LABEL_DEAD || _mc.currentLabel == _LABEL_CHANGE_IN || _mc.currentLabel == _LABEL_CHANGE_OUT)
            {
                return null;
            }
            var _loc_3:* = new Point(0, 0);
            _loc_3.x = _loc_3.x + (Random.range(0, 200) - 100);
            _loc_3.y = _loc_3.y + Random.range(0, 10) * -1;
            _loc_3.x = _loc_3.x + (-param2.width) * 0.5;
            _loc_3.y = _loc_3.y + (-param2.height) * 0.5;
            var _loc_4:* = new Point(0, Random.range(40, 70) * -1);
            var _loc_5:* = Random.range(5, 10);
            if (Lot.isHit(50))
            {
                _loc_5 = _loc_5 * -1;
            }
            return new EffectParticleLightParts(param1, param2, _loc_3, _loc_4, _loc_5, 1);
        }// end function

        private function cbParticleControl(param1:Number, param2:EffectParticleLightParts) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (_mc.currentLabel == _LABEL_MAGIC)
            {
                _loc_3 = new Point(effectNull.x, effectNull.y);
                _loc_4 = param2.pos.clone();
                _loc_5 = new Point(_loc_3.x - _loc_4.x, _loc_3.y - _loc_4.y);
                _loc_5.normalize(_VEC_LIGHT_MAGIC);
                param2.addVec(param1, _loc_5);
            }
            return;
        }// end function

        private function playSeMotion() : void
        {
            if (_bLabelAnimDetailChange == false)
            {
                return;
            }
            if (_labelAnimDetail == "se1001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se1003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_ATTACK_SWORD);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_ATTACK_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_MAGIC_TAME);
            }
            if (_labelAnimDetail == "se2003")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_MAGIC_SHOT);
            }
            if (_labelAnimDetail == "se3001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_CHANGE_IN);
            }
            if (_labelAnimDetail == "se4001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SHITIEIYU_CHANGE_OUT);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_EFFECT_PATH);
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_SHITIEIYU_ATTACK_START, SoundId.SE_REV_SHITIEIYU_ATTACK_SWISH, SoundId.SE_REV_SHITIEIYU_ATTACK_SWORD, SoundId.SE_REV_SHITIEIYU_CHANGE_IN, SoundId.SE_REV_SHITIEIYU_CHANGE_OUT, SoundId.SE_REV_SHITIEIYU_MAGIC_SHOT, SoundId.SE_REV_SHITIEIYU_MAGIC_TAME];
        }// end function

    }
}
