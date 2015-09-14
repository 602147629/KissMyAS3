package popup
{
    import cooperateCode.*;
    import flash.display.*;
    import flash.text.*;
    import message.*;
    import utility.*;

    public class CommonPopupCooperateCode extends Object
    {
        private var _mcBase:MovieClip;
        private var _aCodeInfo:Array;
        private var _idx:int;
        private var _isoBalloon:InStayOut;
        private var _cbFlags:uint;
        private var _bBusy:Boolean;
        private static const _CB_FLAG_BALLOON:uint = 1;
        private static const _CB_FLAG_ALL:uint = 1;

        public function CommonPopupCooperateCode(param1:MovieClip, param2:String, param3:Array)
        {
            this._mcBase = param1;
            this._aCodeInfo = param3 == null ? ([]) : (param3);
            this._idx = 0;
            this._isoBalloon = new InStayOut(this._mcBase.chrInfoBalloonTopMc);
            this._cbFlags = 0;
            this._bBusy = false;
            TextControl.setText(this._mcBase.WindowMc.titleTextMc.textDt, param2);
            var _loc_4:* = this._mcBase.WindowMc.serialMc.textDt;
            this._mcBase.WindowMc.serialMc.textDt.embedFonts = false;
            _loc_4.alwaysShowSelection = true;
            _loc_4.selectable = true;
            DisplayUtils.setMouseEnable(this._mcBase, true);
            DisplayUtils.setMouseEnable(this._mcBase.WindowMc, true);
            DisplayUtils.setMouseEnable(this._mcBase.WindowMc.serialMc, true);
            this.setupItem();
            return;
        }// end function

        public function isBusy() : Boolean
        {
            return this._bBusy;
        }// end function

        public function isEmpty() : Boolean
        {
            return this._idx >= this._aCodeInfo.length;
        }// end function

        public function release() : void
        {
            if (this._isoBalloon)
            {
                this._isoBalloon.release();
            }
            this._isoBalloon = null;
            this._aCodeInfo = null;
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
            return;
        }// end function

        private function cbBalloonOut() : void
        {
            if (this._mcBase == null)
            {
                return;
            }
            this._cbFlags = this._cbFlags | _CB_FLAG_BALLOON;
            this.setupItem();
            return;
        }// end function

        private function setupItem() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._idx < this._aCodeInfo.length)
            {
                _loc_1 = this._aCodeInfo[this._idx];
                _loc_2 = TextControl.formatIdText(MessageId.BENEFIT_INFORMATION_MESSAGE, _loc_1.campaignName);
                this._mcBase.WindowMc.serialMc.textDt.text = _loc_1.serialCode;
                TextControl.setText(this._mcBase.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, _loc_2);
                var _loc_3:* = this;
                var _loc_4:* = this._idx + 1;
                _loc_3._idx = _loc_4;
            }
            else
            {
                this._mcBase.WindowMc.serialMc.textDt.text = "";
                TextControl.setText(this._mcBase.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, "");
            }
            this._cbFlags = 0;
            this._isoBalloon.setIn(this.cbBalloonIn);
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

    }
}
