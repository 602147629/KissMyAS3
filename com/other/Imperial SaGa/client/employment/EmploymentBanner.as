package employment
{
    import button.*;
    import flash.display.*;
    import flash.net.*;
    import resource.*;
    import utility.*;

    public class EmploymentBanner extends Object
    {
        private const _WAIT_TIME:int = 180;
        private const _MAX:int = 5;
        private var _mcBanner:MovieClip;
        private var _isoBanner:InStayOut;
        private var _aBannerData:Array;
        private var _bannerBtn:ButtonBase;
        private var _aGroupBtn:Array;
        private var _selectIdx:int;
        private var _oldSelectIdx:int;
        private var _time:int;

        public function EmploymentBanner(param1:DisplayObjectContainer, param2:Array)
        {
            this._mcBanner = param1 as MovieClip;
            this._aBannerData = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._MAX)
            {
                
                if (_loc_3 < param2.length)
                {
                    this._aBannerData.push(param2[_loc_3]);
                }
                _loc_3++;
            }
            this._isoBanner = new InStayOut(this._mcBanner);
            this._selectIdx = 0;
            this._time = this._WAIT_TIME;
            this.createPageBtn(this._aBannerData);
            this.setBanner(this._selectIdx, (this._selectIdx + 1) % this._aBannerData.length);
            return;
        }// end function

        public function release() : void
        {
            this.releasePageBtn();
            this.releaseBanner(this._mcBanner.btnMc1);
            this.releaseBanner(this._mcBanner.btnMc2);
            if (this._bannerBtn)
            {
                ButtonManager.getInstance().removeButton(this._bannerBtn);
                this._bannerBtn = null;
            }
            if (this._isoBanner)
            {
                this._isoBanner.release();
            }
            this._isoBanner = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._aBannerData.length > 1)
            {
                this._time = this._time - param1;
                if (this._time <= 0)
                {
                    this.setPage((this._selectIdx + 1) % this._aBannerData.length);
                    this.setPageChange();
                    this._time = this._WAIT_TIME;
                }
            }
            this.update();
            return;
        }// end function

        public function openBanner(param1:Function = null) : void
        {
            var cbFunc:* = param1;
            this.setBtnDisable(true);
            this._isoBanner.setIn(function () : void
            {
                setBtnDisable(false);
                return;
            }// end function
            );
            return;
        }// end function

        public function closeBanner(param1:Function = null) : void
        {
            this.setBtnDisableAll(true);
            this._isoBanner.setOut(param1);
            return;
        }// end function

        private function setBtnDisableAll(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (this._bannerBtn)
            {
                this._bannerBtn.setDisable(param1);
            }
            for each (_loc_2 in this._aGroupBtn)
            {
                
                if (_loc_2)
                {
                    _loc_2.setDisableFlag(param1);
                }
            }
            return;
        }// end function

        private function setBtnDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            if (this._bannerBtn)
            {
                this._bannerBtn.setDisable(param1);
            }
            var _loc_3:* = 0;
            while (_loc_3 < this._aGroupBtn.length)
            {
                
                _loc_2 = this._aGroupBtn[_loc_3];
                if (_loc_3 != this._selectIdx)
                {
                    _loc_2.setDisableFlag(param1);
                }
                _loc_3++;
            }
            return;
        }// end function

        private function createBanner(param1:MovieClip, param2:EmploymentBannerData) : void
        {
            var _loc_3:* = ResourceManager.getInstance().createBitmap(param2.bannerFileName);
            if (_loc_3)
            {
                param1.imgNull.addChild(_loc_3);
            }
            return;
        }// end function

        private function releaseBanner(param1:MovieClip) : void
        {
            if (param1.imgNull)
            {
                param1.imgNull.removeChildren();
            }
            return;
        }// end function

        private function setBanner(param1:int, param2:int) : void
        {
            this.releaseBanner(this._mcBanner.btnMc1);
            this.releaseBanner(this._mcBanner.btnMc2);
            var _loc_3:* = this._aBannerData[param1];
            if (_loc_3)
            {
                if (!this._bannerBtn && _loc_3.bannerUrl != "")
                {
                    this._bannerBtn = ButtonManager.getInstance().addButton(this._mcBanner.btnMc1, this.cbBannerButton);
                    this._bannerBtn.enterSeId = ButtonBase.SE_CURSOR_ID;
                }
                this._bannerBtn.setId(param1);
                if (_loc_3.bannerUrl != "")
                {
                    this._bannerBtn.setDisable(false);
                }
                else
                {
                    this._bannerBtn.setDisable(true);
                }
                this.createBanner(this._mcBanner.btnMc1, _loc_3);
            }
            _loc_3 = this._aBannerData[param2];
            if (_loc_3)
            {
                this.createBanner(this._mcBanner.btnMc2, _loc_3);
            }
            return;
        }// end function

        private function cbBannerButton(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aBannerData[param1];
            if (_loc_2 && _loc_2.bannerUrl != "")
            {
                _loc_3 = new URLRequest(_loc_2.bannerUrl);
                navigateToURL(_loc_3);
            }
            return;
        }// end function

        private function createPageBtn(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (param1.length > 0)
            {
                this._mcBanner.btnGroupMc.visible = true;
                this._aGroupBtn = [];
                _loc_4 = 1;
                while (_loc_4 <= 9)
                {
                    
                    this._mcBanner.btnGroupMc["btnMc" + _loc_4].visible = false;
                    _loc_4++;
                }
                _loc_5 = [[""], ["5"], ["4", "6"], ["3", "5", "7"], ["2", "4", "6", "8"], ["1", "3", "5", "7", "9"]];
                _loc_6 = _loc_5[param1.length];
                _loc_4 = 0;
                while (_loc_4 < _loc_6.length)
                {
                    
                    if (_loc_4 < param1.length)
                    {
                        _loc_2 = this._mcBanner.btnGroupMc["btnMc" + _loc_6[_loc_4]];
                        _loc_2.visible = true;
                        if (param1.length > 1)
                        {
                            _loc_3 = new ButtonBase(_loc_2, this.cbPageBtnClick, null, this.cbPageBtnOut);
                            _loc_3.setId(_loc_4);
                            _loc_3.enterSeId = ButtonBase.SE_CURSOR_ID;
                            ButtonManager.getInstance().addButtonBase(_loc_3);
                            this._aGroupBtn.push(_loc_3);
                        }
                    }
                    _loc_4++;
                }
                this.setPage(0);
            }
            else
            {
                this._mcBanner.btnGroupMc.visible = false;
            }
            return;
        }// end function

        private function releasePageBtn() : void
        {
            var _loc_1:* = null;
            if (this._aGroupBtn)
            {
                for each (_loc_1 in this._aGroupBtn)
                {
                    
                    if (_loc_1)
                    {
                        ButtonManager.getInstance().removeButton(_loc_1);
                        _loc_1 = null;
                    }
                }
            }
            this._aGroupBtn = null;
            return;
        }// end function

        private function cbPageBtnClick(param1:int) : void
        {
            var _loc_2:* = this._selectIdx;
            this.setPage(param1);
            this.setBanner(_loc_2, this._selectIdx);
            if (this._aBannerData.length > 1)
            {
                this.setPageChange();
            }
            return;
        }// end function

        private function cbPageBtnOut(param1:int) : void
        {
            var _loc_2:* = this._aGroupBtn[param1];
            if (_loc_2 && this._selectIdx != param1)
            {
                _loc_2.getMoveClip().gotoAndStop("disable");
            }
            return;
        }// end function

        private function setPage(param1:int) : void
        {
            var _loc_2:* = null;
            this._selectIdx = param1;
            var _loc_3:* = 0;
            while (_loc_3 < this._aGroupBtn.length)
            {
                
                _loc_2 = this._aGroupBtn[_loc_3];
                if (_loc_3 == this._selectIdx)
                {
                    _loc_2.getMoveClip().gotoAndStop("offMouse");
                    _loc_2.setDisableFlag(true);
                }
                else
                {
                    _loc_2.getMoveClip().gotoAndStop("disable");
                    _loc_2.setDisableFlag(false);
                }
                _loc_3++;
            }
            return;
        }// end function

        private function setPageChange() : void
        {
            this.setBtnDisable(true);
            this._mcBanner.gotoAndPlay("switchStart");
            return;
        }// end function

        private function update() : void
        {
            if (this._mcBanner && this._mcBanner.currentFrameLabel == "switchEnd")
            {
                this._mcBanner.gotoAndStop("stay");
                this._time = this._WAIT_TIME;
                this.setBtnDisable(false);
                this.setBanner(this._selectIdx, (this._selectIdx + 1) % this._aBannerData.length);
            }
            return;
        }// end function

    }
}
