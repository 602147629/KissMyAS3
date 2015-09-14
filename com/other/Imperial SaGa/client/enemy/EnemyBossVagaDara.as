package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import sound.*;
    import utility.*;

    public class EnemyBossVagaDara extends EnemyDisplayMetamorphoseBase
    {
        private const _SHINE_WAIT_TIME:Number = 4;
        private var _shineWaitTime:Number;
        private var _effectManager:EffectManager;
        private var _effectAfterImage:EnemyEffectAfterImage;
        private var _enemyId:int;

        public function EnemyBossVagaDara(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._enemyId = param2;
            this._effectManager = new EffectManager();
            this._effectAfterImage = new EnemyEffectAfterImage(param1, _mc);
            this._shineWaitTime = this._SHINE_WAIT_TIME;
            this._effectAfterImage.blurPow = new Point(10, 10);
            this._effectAfterImage.blurTime = 2;
            this._effectAfterImage.blurLiveTime = 1;
            this._effectAfterImage.blurVec = new Point(0, -10);
            this._effectAfterImage.blurColor = new ColorTransform(1, 1, 1, 1, 255, 255, 255, 0);
            this._effectAfterImage.blurEndColor = new ColorTransform(1, 1, 1, 0, 255, 255, 255, 0);
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
            if (this._effectManager)
            {
                this._effectManager.release();
            }
            this._effectManager = null;
            return;
        }// end function

        override public function control(param1:Number) : void
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
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            super.control(param1);
            this._shineWaitTime = this._shineWaitTime - param1;
            if (this._shineWaitTime <= 0)
            {
                this._shineWaitTime = this._SHINE_WAIT_TIME + Random.range(0, 300) * 0.01;
                if (_mc.currentLabel == _LABEL_STAY)
                {
                    _loc_2 = [];
                    _loc_3 = [];
                    switch(this._enemyId)
                    {
                        case EnemyId.id_mons_VagaDara_Sword_IS:
                        {
                            _loc_4 = [_mc.monster.sword_r.swordEffectNull1, _mc.monster.sword_r.swordEffectNull2, _mc.monster.sword_r.swordEffectNull3, _mc.monster.sword_r.swordEffectNull4];
                            _loc_5 = [_mc.monster.sword_l.swordEffectNull1, _mc.monster.sword_l.swordEffectNull2, _mc.monster.sword_l.swordEffectNull3, _mc.monster.sword_l.swordEffectNull4];
                            _loc_2 = Lot.isHit(50) ? (_loc_4) : (_loc_5);
                            break;
                        }
                        case EnemyId.id_mons_VagaDara_Harp_IS:
                        {
                            _loc_2 = [_mc.monster.harp.harpEffectNull1, _mc.monster.harp.harpEffectNull2, _mc.monster.harp.harpEffectNull3, _mc.monster.harp.harpEffectNull4, _mc.monster.harp.harpEffectNull5, _mc.monster.harp.harpEffectNull6, _mc.monster.harp.harpEffectNull7];
                            break;
                        }
                        case EnemyId.id_mons_VagaDara_Spear_IS:
                        {
                            if (_mc.monster.spear_r == null || _mc.monster.spear_l == null)
                            {
                                break;
                            }
                            _loc_6 = [_mc.monster.spear_r.spearEffectNull1, _mc.monster.spear_r.spearEffectNull2, _mc.monster.spear_r.spearEffectNull3, _mc.monster.spear_r.spearEffectNull4, _mc.monster.spear_r.spearEffectNull5, _mc.monster.spear_r.spearEffectNull6, _mc.monster.spear_r.spearEffectNull7];
                            _loc_7 = [_mc.monster.spear_l.spearEffectNull1, _mc.monster.spear_l.spearEffectNull2, _mc.monster.spear_l.spearEffectNull3];
                            _loc_8 = [_mc.monster.spear_l.spearEffectNull4, _mc.monster.spear_l.spearEffectNull5, _mc.monster.spear_l.spearEffectNull6, _mc.monster.spear_l.spearEffectNull7];
                            _loc_9 = new LotList();
                            if (Lot.isHit(50))
                            {
                                _loc_2 = _loc_8;
                                _loc_3 = _loc_7;
                            }
                            else
                            {
                                _loc_2 = _loc_6;
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_2.length > 0)
                    {
                        if (this._enemyId == EnemyId.id_mons_VagaDara_Sword_IS || this._enemyId == EnemyId.id_mons_VagaDara_Spear_IS)
                        {
                            _loc_10 = new EffectSharpShines(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _mc, _loc_2, 0.5, this.cnSharpShinesEnd);
                            this._effectManager.addEffect(_loc_10);
                            if (_loc_3.length > 0)
                            {
                                _loc_10 = new EffectSharpShines(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _mc, _loc_3, 0.5, this.cnSharpShinesEnd);
                                _loc_10.setWaitStartTime(0.2);
                                this._effectManager.addEffect(_loc_10);
                            }
                        }
                        if (this._enemyId == EnemyId.id_mons_VagaDara_Harp_IS)
                        {
                            _loc_11 = 0;
                            while (_loc_11 < _loc_2.length)
                            {
                                
                                _loc_12 = _loc_2[_loc_11];
                                _loc_13 = new EffectSharpShinesPoint(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _mc, _loc_12, 1);
                                _loc_13.setGlowFilter(108, 201, 83);
                                _loc_13.setWaitStartTime(_loc_11 * 0.1);
                                this._effectManager.addEffect(_loc_13);
                                _loc_11++;
                            }
                        }
                    }
                }
            }
            this._effectManager.control(param1);
            this._effectAfterImage.control(param1);
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function cnSharpShinesEnd(param1:MovieClip) : void
        {
            var _loc_2:* = new EffectSharpShinesPoint(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _mc, param1, 0.2);
            this._effectManager.addEffect(_loc_2);
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
                case EnemyId.id_mons_VagaDara_Sword_IS:
                {
                    if (_labelAnimDetail == "se1001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLASWORD_ATTACK_START);
                    }
                    else if (_labelAnimDetail == "se1002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLASWORD_ATTACK_SWISH);
                    }
                    else if (_labelAnimDetail == "se2001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLAINST_ATTACK_START);
                    }
                    else if (_labelAnimDetail == "se2002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLA_MAGIC_TAME);
                    }
                    else if (_labelAnimDetail == "se3001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLA_CHANGE_IN);
                    }
                    else if (_labelAnimDetail == "se4001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLASWORD_CHANGE_OUT);
                    }
                    break;
                }
                case EnemyId.id_mons_VagaDara_Harp_IS:
                {
                    if (_labelAnimDetail == "se1001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLAINST_ATTACK_START);
                    }
                    else if (_labelAnimDetail == "se1002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLAINST_ATTACK_SWISH);
                    }
                    else if (_labelAnimDetail == "se2001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLA_MAGIC_TAME);
                    }
                    else if (_labelAnimDetail == "se3001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLA_CHANGE_IN);
                    }
                    else if (_labelAnimDetail == "se4001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLAINST_CHANGE_OUT);
                    }
                    break;
                }
                case EnemyId.id_mons_VagaDara_Spear_IS:
                {
                    if (_labelAnimDetail == "se1001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLASPEAR_ATTACK_START);
                    }
                    else if (_labelAnimDetail == "se1002")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLASPEAR_ATTACK_SWISH);
                    }
                    else if (_labelAnimDetail == "se2001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLA_MAGIC_TAME);
                    }
                    else if (_labelAnimDetail == "se3001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLA_CHANGE_IN);
                    }
                    else if (_labelAnimDetail == "se4001")
                    {
                        SoundManager.getInstance().playSe(SoundId.SE_REV_VADAGALLASPEAR_CHANGE_OUT);
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

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            _loc_1.push(EffectSharpShines.RESOURCE_PATH);
            _loc_1.push(EffectSharpShinesPoint.RESOURCE_PATH);
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_VADAGALLASWORD_ATTACK_START, SoundId.SE_REV_VADAGALLASWORD_ATTACK_SWISH, SoundId.SE_REV_VADAGALLASWORD_CHANGE_OUT, SoundId.SE_REV_VADAGALLAINST_ATTACK_START, SoundId.SE_REV_VADAGALLAINST_ATTACK_SWISH, SoundId.SE_REV_VADAGALLAINST_CHANGE_OUT, SoundId.SE_REV_VADAGALLASPEAR_ATTACK_START, SoundId.SE_REV_VADAGALLASPEAR_ATTACK_SWISH, SoundId.SE_REV_VADAGALLASPEAR_CHANGE_OUT, SoundId.SE_REV_VADAGALLA_CHANGE_IN, SoundId.SE_REV_VADAGALLA_MAGIC_TAME];
        }// end function

    }
}
