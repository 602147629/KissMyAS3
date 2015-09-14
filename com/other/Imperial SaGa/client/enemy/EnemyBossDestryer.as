package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class EnemyBossDestryer extends EnemyDisplayMetamorphoseBase
    {
        private var _effectFireMain:EffectParticleBossFireMain;
        private var _bFireEnd:Boolean;
        private var _effectWaterMain:EffectParticleBossWaterMain;
        private var _bWaterStop:Boolean;
        private var _effectBatibatiMain:EffectBatibatiMain;
        private var _bInit:Boolean;
        private var _enemyId:int;
        private static const _FIRE_WAIT_TIME:Number = 0.1;
        private static const _WATER_WAIT_TIME:Number = 0.1;
        private static const _EFFECT_FIRE_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "fireRed.png";
        private static const _EFFECT_WATER_PATH:String = ResourcePath.ENEMY_EFFECT_PATH + "Destryer_Gel_Drop01.png";

        public function EnemyBossDestryer(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._bInit = false;
            this._enemyId = param2;
            return;
        }// end function

        public function get effectFireMain() : EffectParticleBossFireMain
        {
            return this._effectFireMain;
        }// end function

        public function set bFireEnd(param1:Boolean) : void
        {
            this._bFireEnd = param1;
            return;
        }// end function

        public function get effectWaterMain() : EffectParticleBossWaterMain
        {
            return this._effectWaterMain;
        }// end function

        public function set bWaterStop(param1:Boolean) : void
        {
            this._bWaterStop = param1;
            return;
        }// end function

        public function setEffectData(param1:BitmapData, param2:BitmapData) : void
        {
            this.init(param1, param2);
            return;
        }// end function

        private function init(param1:BitmapData = null, param2:BitmapData = null) : void
        {
            this._bInit = true;
            this._effectFireMain = new EffectParticleBossFireMain(param1, _layer.getLayer(LayerCharacter.FRONT_EFFECT), this.cbFireCreate, _FIRE_WAIT_TIME, _EFFECT_FIRE_PATH, new Point(0.3, 0.3));
            this._effectFireMain.setTransform(100, 0);
            this._effectWaterMain = new EffectParticleBossWaterMain(param2, _layer.getLayer(LayerCharacter.FRONT_EFFECT), this.cbWaterCreate, _WATER_WAIT_TIME, _EFFECT_WATER_PATH, new Point(0.5, 0.5));
            if (this._enemyId == EnemyId.id_mons_Destryer_6th_RS3 || this._enemyId == EnemyId.id_mons_Destryer_7th_RS3)
            {
            }
            else
            {
                this._bFireEnd = true;
            }
            if (this._enemyId == EnemyId.id_mons_Destryer_8th_RS3)
            {
            }
            else
            {
                this._bWaterStop = true;
            }
            if (this._enemyId == EnemyId.id_mons_Destryer_4th_RS3)
            {
                this._effectBatibatiMain = new EffectBatibatiMain(this.cbCreateBatibati);
                this._effectBatibatiMain.setWaitTimeBase(0.2);
            }
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            if (this._effectFireMain != null)
            {
                this._effectFireMain.release();
            }
            this._effectFireMain = null;
            if (this._effectWaterMain)
            {
                this._effectWaterMain.release();
            }
            this._effectWaterMain = null;
            if (this._effectBatibatiMain)
            {
                this._effectBatibatiMain.release();
            }
            this._effectBatibatiMain = null;
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            if (this._bInit == false)
            {
                this.init();
            }
            super.control(param1);
            if (this._effectFireMain != null)
            {
                this._effectFireMain.control(param1);
            }
            if (this._effectWaterMain != null)
            {
                this._effectWaterMain.control(param1);
            }
            if (this._effectBatibatiMain != null)
            {
                this._effectBatibatiMain.control(param1);
            }
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            switch(_labelAnim)
            {
                case _LABEL_CHANGE_OUT:
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

        public function cbFireCreate() : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._bFireEnd || _mc.currentLabel == _LABEL_CHANGE_IN || _mc.currentLabel == _LABEL_CHANGE_OUT || _mc.currentLabel == _LABEL_DEAD)
            {
                return;
            }
            var _loc_1:* = _mc.transform.concatenatedMatrix.clone();
            _loc_1.invert();
            var _loc_2:* = 1;
            var _loc_3:* = [];
            if (this._enemyId == EnemyId.id_mons_Destryer_6th_RS3)
            {
                _loc_3 = [_mc.monster.effectGuideNull1, _mc.monster.effectGuideNull2];
                if (_mc.currentLabel == _LABEL_ATTACK)
                {
                    _loc_2 = 1.5;
                }
            }
            if (this._enemyId == EnemyId.id_mons_Destryer_7th_RS3)
            {
                _loc_3 = [_mc.monster.effectGuideNull1, _mc.monster.effectGuideNull2, _mc.monster.effectGuideNull3];
            }
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_4 == null)
                {
                    continue;
                }
                _loc_5 = 0;
                while (_loc_5 < 1)
                {
                    
                    _loc_6 = new Matrix();
                    _loc_6 = _loc_4.transform.concatenatedMatrix.clone();
                    _loc_6.concat(_loc_1);
                    _loc_7 = new Point(_loc_6.tx, _loc_6.ty);
                    _loc_7 = this._effectFireMain.offset.add(new Point(_loc_7.x, _loc_7.y));
                    _loc_8 = new EffectParticleFireParts(this._effectFireMain.bmpData, this._effectFireMain.fireBitmapData, _loc_7, -100);
                    _loc_8.vanishWaitTime = 0.3;
                    _loc_8.scale = _loc_8.scale * _loc_2;
                    this._effectFireMain.addEffect(_loc_8);
                    _loc_5++;
                }
            }
            return;
        }// end function

        public function cbWaterCreate() : void
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            if (this._bWaterStop || _mc.currentLabel == _LABEL_CHANGE_IN || _mc.currentLabel == _LABEL_CHANGE_OUT || _mc.currentLabel == _LABEL_DEAD)
            {
                return;
            }
            var _loc_1:* = _mc.transform.concatenatedMatrix.clone();
            _loc_1.invert();
            var _loc_2:* = [_mc.monster.effectGuideNull1, _mc.monster.effectGuideNull2];
            var _loc_3:* = 0;
            var _loc_4:* = 1;
            if (_mc.currentLabel == _LABEL_ATTACK)
            {
                _loc_4 = 1.5;
            }
            for each (_loc_5 in _loc_2)
            {
                
                _loc_6 = 0;
                while (_loc_6 < 2)
                {
                    
                    _loc_7 = new Matrix();
                    _loc_7 = _loc_5.transform.concatenatedMatrix.clone();
                    _loc_7.concat(_loc_1);
                    _loc_8 = new Point(_loc_7.tx, _loc_7.ty);
                    _loc_9 = new Point(0, (-150 + Random.range(0, 50)) * _loc_4);
                    _loc_7.identity();
                    _loc_7.rotate((Random.range(0, 20) - 10 + _loc_3) * Math.PI / 180);
                    _loc_9 = _loc_7.transformPoint(_loc_9);
                    _loc_8 = this._effectWaterMain.offset.add(_loc_8);
                    _loc_10 = 200;
                    _loc_11 = new EffectParticleWaterParts(this._effectWaterMain.bmpData, this._effectWaterMain.waterBitmapData, _loc_8, _loc_9, _loc_10);
                    _loc_11.setLiveTime(1.3, 1.3);
                    _loc_11.scale = Random.range(80, 120) / 100;
                    this._effectWaterMain.addEffect(_loc_11);
                    _loc_6++;
                }
                _loc_3 = _loc_3 + 15;
            }
            return;
        }// end function

        private function cbCreateBatibati() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (_mc.currentLabel == _LABEL_MAGIC || _mc.currentLabel == _LABEL_CHANGE_IN || _mc.currentLabel == _LABEL_CHANGE_OUT || _mc.currentLabel == _LABEL_DEAD)
            {
                return;
            }
            var _loc_1:* = Random.range(1, 2);
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_3 = new Point(Random.range(0, 200) - 100, Random.range(0, 10) * -1);
                _loc_4 = new Point(1, 0);
                if (Lot.isHit(50))
                {
                    _loc_4.x = _loc_4.x * -1;
                }
                _loc_4.normalize(200);
                _loc_5 = new EffectBatibati(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _loc_3, _loc_4);
                _loc_5.setColor(0, 0, 0);
                this._effectBatibatiMain.addEffect(_loc_5);
                _loc_2++;
            }
            return;
        }// end function

        private function playSeMotion() : void
        {
            if (_bLabelAnimDetailChange == false)
            {
                return;
            }
            switch(this._enemyId)
            {
                case EnemyId.id_mons_Destryer_1st_RS3:
                {
                    switch(_labelAnimDetail)
                    {
                        case "se1001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se1002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_SWISH);
                            break;
                        }
                        case "se2001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se2002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_MAGIC_TAME);
                            break;
                        }
                        case "se3001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_CHANGE_IN);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case EnemyId.id_mons_Destryer_5th_RS3:
                {
                    switch(_labelAnimDetail)
                    {
                        case "se1001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se1002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIBUNE_ATTACK_SWISH);
                            break;
                        }
                        case "se1003":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIBUNE_ATTACK_ZANGEKI);
                            break;
                        }
                        case "se2001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se2002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_MAGIC_TAME);
                            break;
                        }
                        case "se3001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_CHANGE_IN);
                            break;
                        }
                        case "se4001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIBUNE_CHANGE_OUT);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case EnemyId.id_mons_Destryer_6th_RS3:
                {
                    switch(_labelAnimDetail)
                    {
                        case "se1001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIAVNAS_ATTACK_START);
                            break;
                        }
                        case "se1002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIAVNAS_ATTACK_SWORDSET);
                            break;
                        }
                        case "se1003":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIAVNAS_ATTACK_SWISH);
                            break;
                        }
                        case "se2001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se2002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_MAGIC_TAME);
                            break;
                        }
                        case "se3001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_CHANGE_IN);
                            break;
                        }
                        case "se4001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIAVNAS_CHANGE_OUT);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case EnemyId.id_mons_Destryer_7th_RS3:
                {
                    switch(_labelAnimDetail)
                    {
                        case "se1001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIAVNAS_ATTACK_START);
                            break;
                        }
                        case "se1002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIALLOC_ATTACK_SWISH);
                            break;
                        }
                        case "se2001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se2002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_MAGIC_TAME);
                            break;
                        }
                        case "se3001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_CHANGE_IN);
                            break;
                        }
                        case "se4001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIALLOC_CHANGE_OUT);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case EnemyId.id_mons_Destryer_8th_RS3:
                {
                    switch(_labelAnimDetail)
                    {
                        case "se1001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se1002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIFORN_ATTACK_ZANGEKI);
                            break;
                        }
                        case "se2001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se2002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_MAGIC_TAME);
                            break;
                        }
                        case "se3001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_CHANGE_IN);
                            break;
                        }
                        case "se4001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAIFORN_CHANGE_OUT);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case EnemyId.id_mons_Destryer_4th_RS3:
                {
                    switch(_labelAnimDetail)
                    {
                        case "se1001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se1002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAILAST_ATTACK_SWISH);
                            break;
                        }
                        case "se2001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAI_ATTACK_START);
                            break;
                        }
                        case "se2002":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAILAST_MAGIC_TAME);
                            break;
                        }
                        case "se2003":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAILAST_MAGIC_SHOT);
                            break;
                        }
                        case "se4001":
                        {
                            SoundManager.getInstance().playSe(SoundId.SE_REV_HAKAILAST_CHANGE_OUT);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_HAKAIALLOC_ATTACK_START, SoundId.SE_REV_HAKAIALLOC_ATTACK_SWISH, SoundId.SE_REV_HAKAIALLOC_CHANGE_OUT, SoundId.SE_REV_HAKAIAVNAS_ATTACK_START, SoundId.SE_REV_HAKAIAVNAS_ATTACK_SWISH, SoundId.SE_REV_HAKAIAVNAS_ATTACK_SWORDSET, SoundId.SE_REV_HAKAIAVNAS_CHANGE_OUT, SoundId.SE_REV_HAKAIBUNE_ATTACK_SWISH, SoundId.SE_REV_HAKAIBUNE_ATTACK_ZANGEKI, SoundId.SE_REV_HAKAIBUNE_CHANGE_OUT, SoundId.SE_REV_HAKAIFORN_ATTACK_ZANGEKI, SoundId.SE_REV_HAKAIFORN_CHANGE_OUT, SoundId.SE_REV_HAKAILAST_ATTACK_SWISH, SoundId.SE_REV_HAKAILAST_CHANGE_OUT, SoundId.SE_REV_HAKAILAST_MAGIC_SHOT, SoundId.SE_REV_HAKAILAST_MAGIC_TAME, SoundId.SE_REV_HAKAI_ATTACK_START, SoundId.SE_REV_HAKAI_ATTACK_SWISH, SoundId.SE_REV_HAKAI_CHANGE_IN, SoundId.SE_REV_HAKAI_MAGIC_TAME];
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(_EFFECT_FIRE_PATH);
            _loc_1.push(_EFFECT_WATER_PATH);
            return _loc_1;
        }// end function

    }
}
