package icon
{
    import flash.display.*;
    import player.*;

    public class MagicTypeIcon extends Object
    {
        private var _mc:MovieClip;

        public function MagicTypeIcon(param1:MovieClip, param2:int = 0)
        {
            this._mc = param1;
            this.setMagicType(param2);
            return;
        }// end function

        public function setMagicType(param1:int) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = PlayerManager.getInstance().getMagicTypeLabel(param1);
            var _loc_3:* = [this._mc.attributeType1Mc, this._mc.attributeType2Mc, this._mc.attributeType3Mc, this._mc.attributeType4Mc, this._mc.attributeType5Mc, this._mc.attributeType6Mc];
            this._mc.gotoAndStop(Math.max(1, _loc_2.length));
            this._mc.visible = false;
            if (_loc_2.length != Constant.EMPTY_ID)
            {
                this._mc.visible = true;
                _loc_4 = 0;
                while (_loc_4 < _loc_2.length)
                {
                    
                    _loc_5 = _loc_2[_loc_4];
                    _loc_6 = _loc_3[_loc_4];
                    if (_loc_6)
                    {
                        _loc_6.gotoAndStop(_loc_5);
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

    }
}
