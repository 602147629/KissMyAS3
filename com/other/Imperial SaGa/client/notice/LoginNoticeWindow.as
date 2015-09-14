package notice
{
    import button.*;
    import develop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import input.*;
    import layer.*;
    import message.*;
    import resource.*;

    public class LoginNoticeWindow extends Object
    {
        private const _BUTTON_PAGE_L:int = 1;
        private const _BUTTON_PAGE_R:int = 2;
        private const _DISP_TIME:Number = 5;
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _closeBtn:ButtonBase;
        private var _nextBtn:ButtonBase;
        private var _page:int;
        private var _pageMax:int;
        private var _bClose:Boolean;
        private var _aNoticeInfo:Array;
        private var _aPageBtn:Array;
        private var _aPageLampMc:Array;
        private var _aPageCheck:Array;
        private var _requestUrl:String;
        private var _bitmap:Bitmap;
        private var _timeCount:Number;
        private var _frameCount:int;

        public function LoginNoticeWindow(param1:LayerHome, param2:Array)
        {
            this._layer = param1;
            this._aNoticeInfo = param2;
            this._bClose = false;
            this._timeCount = 0;
            this._page = 0;
            this._pageMax = this._aNoticeInfo.length - 1;
            this._aPageBtn = [];
            this._aPageCheck = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aNoticeInfo.length)
            {
                
                this._aPageCheck[_loc_3] = 0;
                _loc_3++;
            }
            this._frameCount = 0;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_AnnouncePopup.swf", "LoginInfoPopup");
            if (this._baseMc != null)
            {
                this._layer.getLayer(LayerHome.NOTICE).addChild(this._baseMc);
                this._aPageLampMc = [this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_Lamp1Mc, this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_Lamp2Mc, this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_Lamp3Mc, this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_Lamp4Mc, this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_Lamp5Mc, this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_Lamp6Mc];
                this.pageBtn();
                this.displayNotice();
                this._baseMc.gotoAndPlay("in");
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this.removeDispItem();
            for each (_loc_1 in this._aPageBtn)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aPageBtn = null;
            ButtonManager.getInstance().removeButton(this._closeBtn);
            this._closeBtn = null;
            if (this._nextBtn)
            {
                ButtonManager.getInstance().removeButton(this._nextBtn);
            }
            this._nextBtn = null;
            if (this._baseMc)
            {
                this._layer.getLayer(LayerHome.NOTICE).removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            this._timeCount = this._timeCount + param1;
            if (this._timeCount >= this._DISP_TIME)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._page + 1;
                _loc_2._page = _loc_3;
                if (this._page > this._pageMax)
                {
                    this._page = 0;
                }
                this._timeCount = 0;
                this.displayNotice();
            }
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._baseMc.currentLabel == "end";
        }// end function

        private function displayNotice() : void
        {
            var _loc_1:* = this._aNoticeInfo[this._page];
            if (_loc_1.type == 1)
            {
                this._baseMc.loginInfoPopupMc.gotoAndStop("attention");
            }
            else
            {
                this._baseMc.loginInfoPopupMc.gotoAndStop("normal");
            }
            this.removeDispItem();
            this.updatePage();
            this._requestUrl = "";
            TextControl.setText(this._baseMc.loginInfoPopupMc.loginInfoTitleMc.textDt, _loc_1.title);
            switch(_loc_1.type)
            {
                case CommonConstant.NOTICE_TYPE_MAINTENANCE:
                case CommonConstant.NOTICE_TYPE_MESSAGE:
                {
                    this.dispMessageByString(_loc_1);
                    break;
                }
                case CommonConstant.NOTICE_TYPE_MESSAGE_NAVI:
                {
                    this.dispMessageByNavi(_loc_1);
                    break;
                }
                case CommonConstant.NOTICE_TYPE_IMAGE:
                {
                    this.dispMessageByImage(_loc_1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function removeDispItem() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            InputManager.getInstance().delMouseCallback(this);
            if (this._baseMc != null)
            {
                if (this._baseMc.loginInfoPopupMc.naviInfoNull.hasEventListener(MouseEvent.CLICK))
                {
                    this._baseMc.loginInfoPopupMc.naviInfoNull.removeEventListener(MouseEvent.CLICK, this.cbImageClick);
                }
                if (this._baseMc.loginInfoPopupMc.naviInfoNull.numChildren > 0)
                {
                    _loc_1 = this._baseMc.loginInfoPopupMc.naviInfoNull.numChildren;
                    _loc_2 = _loc_1;
                    while (_loc_2 > 0)
                    {
                        
                        this._baseMc.loginInfoPopupMc.naviInfoNull.removeChildAt((_loc_2 - 1));
                        _loc_2 = _loc_2 - 1;
                    }
                }
                TextControl.setText(this._baseMc.loginInfoPopupMc.loginInfoTextMc.textDt, "");
            }
            return;
        }// end function

        private function dispMessageByString(param1:ManagementNoticeInfo) : void
        {
            TextControl.setText(this._baseMc.loginInfoPopupMc.loginInfoTextMc.textDt, param1.param1);
            return;
        }// end function

        private function dispMessageByNavi(param1:ManagementNoticeInfo) : void
        {
            var _loc_2:* = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_AnnouncePopup.swf", "LoginInfoNavi");
            var _loc_3:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            _loc_2.naviCharaNull.addChild(_loc_3);
            _loc_3.x = _loc_3.x - _loc_3.width / 2;
            _loc_3.y = _loc_3.y - _loc_3.height;
            TextControl.setText(_loc_2.balloonTextMc.textDt, param1.param1);
            this._baseMc.loginInfoPopupMc.naviInfoNull.addChild(_loc_2);
            return;
        }// end function

        private function dispMessageByImage(param1:ManagementNoticeInfo) : void
        {
            this._bitmap = ResourceManager.getInstance().createBitmap(param1.param2);
            if (this._bitmap != null)
            {
                this._bitmap.y = -this._bitmap.height;
                this._baseMc.loginInfoPopupMc.naviInfoNull.addChild(this._bitmap);
                if (param1.param1.length > 0)
                {
                    this._requestUrl = param1.param1;
                    InputManager.getInstance().addMouseCallback(this, null, this.cbImageClick);
                }
            }
            return;
        }// end function

        private function pageBtn() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.closeBtnMc, this.cbCloseButton);
            this._closeBtn.setDisable(true);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._closeBtn.getMoveClip().textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._nextBtn = ButtonManager.getInstance().addButton(this._baseMc.nextBtnMc, this.cbPageButton, this._BUTTON_PAGE_R);
            this._nextBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            TextControl.setIdText(this._baseMc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            if (this._aNoticeInfo.length > 1)
            {
                this._baseMc.loginInfoPopupMc.loginInfoPageMc.gotoAndStop("infoPage" + this._aNoticeInfo.length);
                _loc_1 = ButtonManager.getInstance().addButton(this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_L_BtnMc, this.cbPageButton, this._BUTTON_PAGE_L);
                _loc_2 = ButtonManager.getInstance().addButton(this._baseMc.loginInfoPopupMc.loginInfoPageMc.infoPage_R_BtnMc, this.cbPageButton, this._BUTTON_PAGE_R);
                _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
                _loc_2.enterSeId = ButtonBase.SE_CURSOR_ID;
                this._aPageBtn.push(_loc_1);
                this._aPageBtn.push(_loc_2);
            }
            return;
        }// end function

        private function updatePage() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            for each (_loc_1 in this._aPageLampMc)
            {
                
                _loc_1.gotoAndStop("off");
            }
            _loc_1 = this._aPageLampMc[this._page];
            _loc_1.gotoAndStop("on");
            if (this._aPageCheck[this._page] == 0)
            {
                this._aPageCheck[this._page] = 1;
            }
            if (this._bClose == false)
            {
                _loc_2 = this._aPageCheck.indexOf(0);
                if (_loc_2 < 0)
                {
                    this._nextBtn.setDisable(true);
                    this._nextBtn.getMoveClip().visible = false;
                    this._closeBtn.setDisable(false);
                    this._bClose = true;
                }
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            if (this._baseMc.currentLabel == "stay")
            {
                this._closeBtn.setDisable(true);
                this._closeBtn.setDisableFlag(true);
                this._baseMc.gotoAndPlay("out");
            }
            return;
        }// end function

        private function cbPageButton(param1:int) : void
        {
            this._timeCount = 0;
            if (param1 == this._BUTTON_PAGE_L)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._page - 1;
                _loc_2._page = _loc_3;
                if (this._page < 0)
                {
                    this._page = this._pageMax;
                }
            }
            if (param1 == this._BUTTON_PAGE_R)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._page + 1;
                _loc_2._page = _loc_3;
                if (this._page > this._pageMax)
                {
                    this._page = 0;
                }
            }
            this.displayNotice();
            return;
        }// end function

        private function cbImageClick(event:MouseEvent) : void
        {
            var _loc_2:* = InputManager.getInstance().corsor;
            if (this._bitmap == null || this._bitmap != null && this._bitmap.hitTestPoint(_loc_2.x, _loc_2.y) == false)
            {
                return;
            }
            if (this._requestUrl == "")
            {
                return;
            }
            DebugLog.print("URLリクエスト　URL:" + this._requestUrl);
            var _loc_3:* = new URLRequest(this._requestUrl);
            navigateToURL(_loc_3);
            return;
        }// end function

    }
}
