package enemy
{
    import effect.*;
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import sound.*;
    import utility.*;

    public class EnemyBossWaterDragon extends EnemyDisplay
    {
        private var _effectBatibatiMain:EffectBatibatiMain;
        private static const _WAIT_TIME:Number = 0.5;

        public function EnemyBossWaterDragon(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            this._effectBatibatiMain = new EffectBatibatiMain(this.cbCreateBatibati);
            return;
        }// end function

        override public function release() : void
        {
            super.release();
            this._effectBatibatiMain.release();
            return;
        }// end function

        override public function control(param1:Number) : void
        {
            super.control(param1);
            this._effectBatibatiMain.control(param1);
            return;
        }// end function

        override protected function controlAnim(param1:Number) : void
        {
            super.controlAnim(param1);
            this.playSeMotion();
            return;
        }// end function

        private function cbCreateBatibati() : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (_mc.currentLabel == _LABEL_DEAD)
            {
                return;
            }
            var _loc_1:* = [_mc.monster.effectGuideNull10, _mc.monster.effectGuideNull9, _mc.monster.effectGuideNull8, _mc.monster.effectGuideNull7, _mc.monster.effectGuideNull6, _mc.monster.effectGuideNull5, _mc.monster.effectGuideNull4, _mc.monster.effectGuideNull3, _mc.monster.effectGuideNull2, _mc.monster.effectGuideNull1];
            var _loc_2:* = Random.range(1, 2);
            var _loc_3:* = _mc.transform.concatenatedMatrix.clone();
            _loc_3.invert();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_5 = Random.range(0, _loc_1.length - 3);
                _loc_6 = _loc_1[_loc_5];
                _loc_7 = _loc_1[_loc_5 + 2];
                _loc_8 = new Matrix();
                _loc_8 = _loc_6.transform.concatenatedMatrix.clone();
                _loc_8.concat(_loc_3);
                _loc_9 = new Matrix();
                _loc_9 = _loc_7.transform.concatenatedMatrix.clone();
                _loc_9.concat(_loc_3);
                _loc_10 = new Point(_loc_8.tx, _loc_8.ty);
                _loc_11 = new Point(_loc_9.tx, _loc_9.ty);
                _loc_12 = new EffectBatibati(_layer.getLayer(LayerCharacter.FRONT_EFFECT), _loc_10, _loc_11);
                _loc_12.setColor(50, 0, 255);
                _loc_12.setSpeedNormal();
                this._effectBatibatiMain.addEffect(_loc_12);
                _loc_4++;
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
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUIRYUU_ATTACK_START);
            }
            if (_labelAnimDetail == "se1002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUIRYUU_ATTACK_SWISH);
            }
            if (_labelAnimDetail == "se2001")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUIRYUU_MAGIC_START);
            }
            if (_labelAnimDetail == "se2002")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_SUIRYUU_MAGIC_SHOT);
            }
            return;
        }// end function

        public static function getResource() : Array
        {
            var _loc_1:* = [];
            return _loc_1;
        }// end function

        public static function getSoundResource() : Array
        {
            return [SoundId.SE_REV_SUIRYUU_ATTACK_START, SoundId.SE_REV_SUIRYUU_ATTACK_SWISH, SoundId.SE_REV_SUIRYUU_MAGIC_START, SoundId.SE_REV_SUIRYUU_MAGIC_SHOT];
        }// end function

    }
}
