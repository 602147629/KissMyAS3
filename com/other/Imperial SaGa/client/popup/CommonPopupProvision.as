package popup
{
    import flash.display.*;
    import icon.*;
    import input.*;
    import message.*;
    import utility.*;

    public class CommonPopupProvision extends Object
    {
        private var _mcBase:MovieClip;
        private var _aProvision:Array;
        private var _idx:int;
        private var _isoBalloon:InStayOut;
        private var _isoWindow:InStayOut;
        private var _cbFlags:uint;
        private var _bBusy:Boolean;
        private var _itemIcon:ItemDescriptionIcon;
        private static const _CB_FLAG_BALLOON:uint = 1;
        private static const _CB_FLAG_WINDOW:uint = 2;
        private static const _CB_FLAG_ALL:uint = 3;

        public function CommonPopupProvision(param1:MovieClip, param2:String, param3:Array)
        {
            this._mcBase = param1;
            this._aProvision = param3 == null ? ([]) : (param3);
            this._idx = 0;
            this._isoBalloon = new InStayOut(this._mcBase.chrInfoBalloonTopMc);
            this._isoWindow = new InStayOut(this._mcBase.WindowMc);
            this._cbFlags = 0;
            this._bBusy = false;
            this._itemIcon = new ItemDescriptionIcon(this._mcBase.WindowMc, Constant.EMPTY_ID, Constant.EMPTY_ID, 0, InputManager.INPUT_GROUP_CONFIG);
            this._itemIcon.setMouseOverEnable(true);
            TextControl.setText(this._mcBase.WindowMc.titleTextMc.textDt, param2);
            this.setupItem();
            return;
        }// end function

        public function isBusy() : Boolean
        {
            return this._bBusy;
        }// end function

        public function isEmpty() : Boolean
        {
            return this._idx >= this._aProvision.length;
        }// end function

        public function release() : void
        {
            if (this._itemIcon)
            {
                this._itemIcon.release();
            }
            this._itemIcon = null;
            if (this._isoWindow)
            {
                this._isoWindow.release();
            }
            this._isoWindow = null;
            if (this._isoBalloon)
            {
                this._isoBalloon.release();
            }
            this._isoBalloon = null;
            this._aProvision = null;
            this._mcBase = null;
            return;
        }// end function

        public function setNaviCharaBmp(param1:Bitmap) : void
        {
            if (param1)
            {
                this._mcBase.naviCharaNull.addChild(param1);
            }
            return;
        }// end function

        public function nextItem() : void
        {
            if (this._bBusy || this.isEmpty())
            {
                return;
            }
            this._bBusy = true;
            this._cbFlags = 0;
            this._isoBalloon.setOut(this.cbBalloonOut);
            this._isoWindow.setOut(this.cbWindowOut);
            return;
        }// end function

        private function cbBalloonOut() : void
        {
            if (this._mcBase == null)
            {
                return;
            }
            this._cbFlags = this._cbFlags | _CB_FLAG_BALLOON;
            if (this._cbFlags == _CB_FLAG_ALL)
            {
                this.setupItem();
            }
            return;
        }// end function

        private function cbWindowOut() : void
        {
            if (this._mcBase == null)
            {
                return;
            }
            this._cbFlags = this._cbFlags | _CB_FLAG_WINDOW;
            if (this._cbFlags == _CB_FLAG_ALL)
            {
                this.setupItem();
            }
            return;
        }// end function

        private function setupItem() : void
        {
            var _loc_1:* = null;
            if (this._idx < this._aProvision.length)
            {
                _loc_1 = this._aProvision[this._idx];
                this._itemIcon.setItem(_loc_1.category, _loc_1.itemId, _loc_1.num);
                TextControl.setText(this._mcBase.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, _loc_1.message);
                var _loc_2:* = this;
                var _loc_3:* = this._idx + 1;
                _loc_2._idx = _loc_3;
            }
            else
            {
                this._itemIcon.setItem(Constant.EMPTY_ID, Constant.EMPTY_ID, 0);
                TextControl.setText(this._mcBase.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, "");
            }
            this._cbFlags = 0;
            this._isoBalloon.setIn(this.cbBalloonIn);
            this._isoWindow.setIn(this.cbWindowIn);
            return;
        }// end function

        private function cbBalloonIn() : void
        {
            if (this._mcBase == null)
            {
                return;
            }
            this._cbFlags = this._cbFlags | _CB_FLAG_BALLOON;
            if (this._cbFlags == _CB_FLAG_ALL)
            {
                this._bBusy = false;
            }
            return;
        }// end function

        private function cbWindowIn() : void
        {
            if (this._mcBase == null)
            {
                return;
            }
            this._cbFlags = this._cbFlags | _CB_FLAG_WINDOW;
            if (this._cbFlags == _CB_FLAG_ALL)
            {
                this._bBusy = false;
            }
            return;
        }// end function

    }
}
