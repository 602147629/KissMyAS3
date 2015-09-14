package employment
{
    import button.*;
    import flash.display.*;
    import flash.net.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class EmploymentLimitedParts extends Object
    {
        private var _mcBase:MovieClip;
        private var _mcFirework:MovieClip;
        private var _mcBanner:MovieClip;
        private var _mcCutin:MovieClip;
        private var _isoBanner:InStayOut;
        private var _isoCutin:InStayOut;
        private var _btnBanner:ButtonBase;
        private var _bannerClickedJumpUrl:String;
        private var _cbCompleted:Function;
        private var _emperorId:int;
        private var _emperorCharacterId:int;
        private var _bPlayingFirework:Boolean;

        public function EmploymentLimitedParts(param1:DisplayObjectContainer, param2:int, param3:String, param4:String)
        {
            var _loc_5:* = null;
            this._bannerClickedJumpUrl = param4;
            this._cbCompleted = null;
            this._bPlayingFirework = false;
            this._emperorId = param2;
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf", "LimitMc");
            param1.addChild(this._mcBase);
            this._mcFirework = this._mcBase.fireworksSetMc;
            this._mcBanner = this._mcBase.BannerMc;
            this._mcCutin = this._mcBase.gchaCutinMc;
            this._isoBanner = new InStayOut(this._mcBanner);
            this._isoCutin = new InStayOut(this._mcCutin);
            this._btnBanner = ButtonManager.getInstance().addButton(this._mcBanner.dummyBaBtnMc, this.cbBannerButton);
            this._btnBanner.setDisable(true);
            if (param3.indexOf("http:") == 0)
            {
                _loc_5 = ResourceManager.getInstance().createBitmap(param3);
            }
            else
            {
                _loc_5 = ResourceManager.getInstance().createBitmap(ResourcePath.LIMITED_EMPLOY_BANNER_PATH + param3);
            }
            if (_loc_5)
            {
                this._mcBanner.dummyBaBtnMc.bannerNull.addChild(_loc_5);
                _loc_5.x = _loc_5.x - _loc_5.width / 2;
                _loc_5.y = _loc_5.y - _loc_5.height / 2;
            }
            var _loc_6:* = PlayerManager.getInstance().getPlayerInformation(this._emperorId);
            var _loc_7:* = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_6.bustUpFileName);
            if (ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_6.bustUpFileName))
            {
                this._mcCutin.charaNull.charaNull.addChild(_loc_7);
                _loc_7.smoothing = true;
                _loc_7.x = _loc_7.x - _loc_7.width / 2;
                _loc_7.y = _loc_7.y - _loc_7.height;
            }
            this._emperorCharacterId = _loc_6.characterId;
            return;
        }// end function

        public function get bPlayingFirework() : Boolean
        {
            return this._bPlayingFirework;
        }// end function

        public function get bOpenedCutin() : Boolean
        {
            return this._isoCutin.bOpened;
        }// end function

        public function release() : void
        {
            ButtonManager.getInstance().removeButton(this._btnBanner);
            this._btnBanner = null;
            if (this._isoBanner)
            {
                this._isoBanner.release();
            }
            this._isoBanner = null;
            if (this._isoCutin)
            {
                this._isoCutin.release();
            }
            this._isoCutin = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function control() : void
        {
            if (this._bPlayingFirework && this._mcFirework.currentLabel == "end")
            {
                this._bPlayingFirework = false;
                if (this._cbCompleted != null)
                {
                    this._cbCompleted();
                }
            }
            return;
        }// end function

        public function playFirework(param1:Function = null) : void
        {
            this._cbCompleted = param1;
            this._mcFirework.gotoAndPlay("start");
            this._bPlayingFirework = true;
            return;
        }// end function

        public function openBanner(param1:Function = null) : void
        {
            var cbFunc:* = param1;
            this._cbCompleted = cbFunc;
            this._btnBanner.setDisableFlag(true);
            this._isoBanner.setIn(function () : void
            {
                _btnBanner.setDisable(false);
                if (_cbCompleted != null)
                {
                    _cbCompleted();
                }
                return;
            }// end function
            );
            return;
        }// end function

        public function closeBanner(param1:Function = null) : void
        {
            this._cbCompleted = param1;
            this._btnBanner.setDisableFlag(true);
            this._isoBanner.setOut(this._cbCompleted);
            return;
        }// end function

        public function openStartCutin(param1:Function = null) : void
        {
            this._cbCompleted = param1;
            TextControl.setText(this._mcCutin.balloonMc.textMc.textDt, PlayerManager.getInstance().getWordLimitedEmploymentReady(this._emperorCharacterId));
            this._isoCutin.setIn(this._cbCompleted);
            return;
        }// end function

        public function openEndCutin(param1:Function = null) : void
        {
            this._cbCompleted = param1;
            TextControl.setText(this._mcCutin.balloonMc.textMc.textDt, PlayerManager.getInstance().getWordLimitedEmploymentFinish(this._emperorCharacterId));
            this._isoCutin.setIn(this._cbCompleted);
            return;
        }// end function

        public function closeCutin(param1:Function = null) : void
        {
            this._cbCompleted = param1;
            this._isoCutin.setOut(this._cbCompleted);
            return;
        }// end function

        private function cbBannerButton(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._bannerClickedJumpUrl && this._bannerClickedJumpUrl != "")
            {
                _loc_2 = new URLRequest(this._bannerClickedJumpUrl);
                navigateToURL(_loc_2);
            }
            return;
        }// end function

    }
}
