package effect
{
    import battle.*;
    import character.*;
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import sound.*;

    public class EffectCombo extends EffectMc
    {
        private const _LABEL_LV1:String = "Lv1";
        private const _LABEL_LV2:String = "Lv2";
        private const _LABEL_LV3:String = "Lv3";
        private const _LABEL_LV4:String = "Lv4";
        private const _LABEL_LV5:String = "Lv5";
        private var _characterBase:CharacterDisplayBase;

        public function EffectCombo(param1:DisplayObjectContainer, param2:CharacterDisplayBase, param3:Point, param4:int)
        {
            this._characterBase = param2;
            this._characterBase.backupParent();
            super(param1, ResourcePath.BATTLE_PATH + "BattleComboEffect.swf", "BattleComboEffect", param3);
            var _loc_5:* = null;
            switch(param4)
            {
                case BattleConstant.COMBO_GRADE1:
                {
                    _mcEffect.gotoAndPlay(this._LABEL_LV1);
                    _loc_5 = _mcEffect.lv1Mc;
                    break;
                }
                case BattleConstant.COMBO_GRADE2:
                {
                    _mcEffect.gotoAndPlay(this._LABEL_LV2);
                    _loc_5 = _mcEffect.lv2Mc;
                    break;
                }
                case BattleConstant.COMBO_GRADE3:
                {
                    _mcEffect.gotoAndPlay(this._LABEL_LV3);
                    _loc_5 = _mcEffect.lv3Mc;
                    break;
                }
                case BattleConstant.COMBO_GRADE4:
                {
                    _mcEffect.gotoAndPlay(this._LABEL_LV4);
                    _loc_5 = _mcEffect.lv4Mc;
                    break;
                }
                case BattleConstant.COMBO_GRADE5:
                {
                    _mcEffect.gotoAndPlay(this._LABEL_LV5);
                    _loc_5 = _mcEffect.lv5Mc;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_5 != null)
            {
                this._characterBase.pos = new Point(0, 0);
                _loc_5.charaNull.addChild(this._characterBase.layer);
                _loc_5.gotoAndPlay("start");
            }
            if (this._characterBase.type == CharacterDisplayBase.TYPE_PLAYER)
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADDITIONAL_DAMAGE);
            }
            else
            {
                SoundManager.getInstance().playSe(SoundId.SE_ADDITIONAL_DAMAGE);
            }
            return;
        }// end function

        override public function release() : void
        {
            this._characterBase.returnParent();
            super.release();
            return;
        }// end function

        override public function isEnd() : Boolean
        {
            if (!_mcEffect)
            {
                return true;
            }
            var _loc_1:* = _mcEffect.currentLabel;
            if (_loc_1 == this._LABEL_LV1)
            {
                _loc_1 = _mcEffect.lv1Mc.currentLabel;
            }
            if (_loc_1 == this._LABEL_LV2)
            {
                _loc_1 = _mcEffect.lv2Mc.currentLabel;
            }
            if (_loc_1 == this._LABEL_LV3)
            {
                _loc_1 = _mcEffect.lv3Mc.currentLabel;
            }
            if (_loc_1 == this._LABEL_LV4)
            {
                _loc_1 = _mcEffect.lv4Mc.currentLabel;
            }
            if (_loc_1 == this._LABEL_LV5)
            {
                _loc_1 = _mcEffect.lv5Mc.currentLabel;
            }
            return _loc_1 == "end";
        }// end function

    }
}
