package topbar
{
    import develop.*;
    import flash.display.*;
    import user.*;

    public class ProgressBar extends Object
    {
        private var _baseMc:MovieClip;
        private var _aLamp:Array;
        public static const PROGRESS_MAX:int = 10;

        public function ProgressBar(param1:MovieClip)
        {
            this._baseMc = param1;
            this._aLamp = [this._baseMc.progressLamp1, this._baseMc.progressLamp2, this._baseMc.progressLamp3, this._baseMc.progressLamp4, this._baseMc.progressLamp5, this._baseMc.progressLamp6, this._baseMc.progressLamp7, this._baseMc.progressLamp8, this._baseMc.progressLamp9, this._baseMc.progressLamp10];
            this.setProgress();
            return;
        }// end function

        public function updateProgress() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData.progress;
            if (_loc_1 > 0 && _loc_1 <= PROGRESS_MAX)
            {
                _loc_2 = this._aLamp[(_loc_1 - 1)];
                if (_loc_2 != null && _loc_2.currentLabel == "off")
                {
                    _loc_2.gotoAndPlay("onStart");
                }
                else
                {
                    DebugLog.print("年数の取得に問題あり");
                }
            }
            return;
        }// end function

        public function resetProgres() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aLamp)
            {
                
                _loc_1.gotoAndStop("off");
            }
            return;
        }// end function

        private function setProgress() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData.progress;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (_loc_2 <= PROGRESS_MAX)
                {
                    _loc_3 = this._aLamp[_loc_2];
                    _loc_3.gotoAndStop("on");
                }
                _loc_2++;
            }
            return;
        }// end function

    }
}
