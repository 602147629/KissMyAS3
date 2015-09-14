package notice
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class LostNoticeWindow extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_DISP_CARD:int = 10;
        private const _PHASE_DISP_KILLED:int = 20;
        private const _PHASE_DISP_NAVI:int = 30;
        private const _PHASE_CLOSE:int = 99;
        private const _WAIT_INTERVAL:Number = 0.5;
        private var _KILLED_DISP_TIME:Number = 1;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _btnClose:ButtonBase;
        private var _aCharacterNullMc:Array;
        private const _aUseNullIndex:Array;
        private var _aPlayer:Array;
        private var _waitTime:Number;
        private var _fadeIndex:int;
        private var _bmpNavi:Bitmap;
        private var _lostMc:MovieClip;
        private var _isoLost:InStayOut;
        private var _phase:int;
        public static const _NAVI_CHARACTER_PATH:String = ResourcePath.NAVI_CHARACTER_PATH;

        public function LostNoticeWindow(param1:DisplayObjectContainer)
        {
            var _loc_3:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            this._aUseNullIndex = [[2], [2, 3], [1, 2, 3], [1, 2, 3, 4], [0, 1, 2, 3, 4], [0, 1, 2, 3, 4, 5]];
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Home.swf", "LostInfoPopup");
            param1.addChild(this._mc);
            this._bmpNavi = ResourceManager.getInstance().createBitmap(_NAVI_CHARACTER_PATH);
            var _loc_2:* = new Matrix();
            _loc_2.translate((-this._bmpNavi.width) * 0.5, -this._bmpNavi.height);
            _loc_2.scale(-1, 1);
            this._bmpNavi.transform.matrix = _loc_2;
            this._mc.infoPopupNaviCharaMc.naviCharaNull.addChild(this._bmpNavi);
            this._mc.infoPopupNaviCharaMc.alpha = 0;
            this._isoMain = new InStayOut(this._mc);
            this._waitTime = 0;
            this._lostMc = this._mc.LostProductionMc;
            this._isoLost = new InStayOut(this._lostMc);
            this._aPlayer = [];
            this._aCharacterNullMc = [this._mc.lostChara1, this._mc.lostChara2, this._mc.lostChara3, this._mc.lostChara4, this._mc.lostChara5, this._mc.lostChara6];
            var _loc_4:* = NoticeManager.getInstance().aCharacterLost;
            var _loc_5:* = this._aUseNullIndex[(_loc_4.length - 1)];
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4.length)
            {
                
                _loc_7 = _loc_5[_loc_6];
                _loc_3 = this._aCharacterNullMc[_loc_7];
                _loc_8 = new LostNoticeCharacter(_loc_3, _loc_4[_loc_6]);
                this._aPlayer.push(_loc_8);
                _loc_6++;
            }
            _loc_6 = 0;
            while (_loc_6 < this._aCharacterNullMc.length)
            {
                
                if (_loc_5.indexOf(_loc_6) == -1)
                {
                    _loc_3 = this._aCharacterNullMc[_loc_6];
                    _loc_3.visible = false;
                }
                _loc_6++;
            }
            this._btnClose = ButtonManager.getInstance().addButton(this._mc.closeBtnMc, this.cbButtonClose);
            this._btnClose.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._mc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this._btnClose.setDisable(true);
            TextControl.setIdText(this._mc.infoPopupNaviCharaMc.infoBalloonTextMc.textDt, MessageId.NOTICE_LOST_NAVI_MESSAGE);
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoMain.bEnd;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._bmpNavi)
            {
                if (this._bmpNavi.parent)
                {
                    this._bmpNavi.parent.removeChild(this._bmpNavi);
                }
                if (this._bmpNavi.bitmapData != null)
                {
                    this._bmpNavi.bitmapData.dispose();
                }
            }
            this._bmpNavi = null;
            for each (_loc_1 in this._aPlayer)
            {
                
                _loc_1.release();
            }
            this._aPlayer = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        private function cbIn() : void
        {
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_DISP_CARD:
                {
                    this.controlDispCard(param1);
                    break;
                }
                case this._PHASE_DISP_KILLED:
                {
                    this.controlDispKilled(param1);
                    break;
                }
                case this._PHASE_DISP_NAVI:
                {
                    this.controlDispNavi();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_DISP_CARD:
                    {
                        this.phaseDispCard();
                        break;
                    }
                    case this._PHASE_DISP_KILLED:
                    {
                        this.phaseDispKilled();
                        break;
                    }
                    case this._PHASE_DISP_NAVI:
                    {
                        this.phaseDispNavi();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoMain.setIn(this.cbIn);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMain.bOpened)
            {
                this.setPhase(this._PHASE_DISP_CARD);
            }
            return;
        }// end function

        private function phaseDispCard() : void
        {
            this._fadeIndex = 0;
            return;
        }// end function

        private function controlDispCard(param1:Number) : void
        {
            var _loc_3:* = null;
            this._waitTime = this._waitTime + param1;
            if (this._waitTime > this._WAIT_INTERVAL)
            {
                this._waitTime = 0;
                if (this._fadeIndex < this._aPlayer.length)
                {
                    this._aPlayer[this._fadeIndex].startFade();
                    var _loc_4:* = this;
                    var _loc_5:* = this._fadeIndex + 1;
                    _loc_4._fadeIndex = _loc_5;
                }
            }
            var _loc_2:* = true;
            for each (_loc_3 in this._aPlayer)
            {
                
                _loc_3.control(param1);
                if (_loc_3.bEndGrayScale == false)
                {
                    _loc_2 = false;
                }
            }
            if (_loc_2 == true)
            {
                this.setPhase(this._PHASE_DISP_KILLED);
            }
            return;
        }// end function

        private function phaseDispKilled() : void
        {
            if (this._isoLost.bClosed)
            {
                this._waitTime = 0;
                this._isoLost.setIn();
                SoundManager.getInstance().playSe(SoundId.SE_REV_LOST_SENSHI);
            }
            return;
        }// end function

        private function controlDispKilled(param1:Number) : void
        {
            if (this._isoLost.bAnimetion)
            {
                return;
            }
            if (this._isoLost.bClosed)
            {
                this.setPhase(this._PHASE_DISP_NAVI);
            }
            else
            {
                this._waitTime = this._waitTime + param1;
                if (this._waitTime > this._KILLED_DISP_TIME)
                {
                    this._waitTime = 0;
                    this._isoLost.setOut();
                }
            }
            return;
        }// end function

        private function phaseDispNavi() : void
        {
            return;
        }// end function

        private function controlDispNavi() : void
        {
            if (this._mc.infoPopupNaviCharaMc.alpha < 1)
            {
                this._mc.infoPopupNaviCharaMc.alpha = this._mc.infoPopupNaviCharaMc.alpha + 0.1;
            }
            else if (this._btnClose.isEnable() == false)
            {
                this._btnClose.setDisable(false);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoMain.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        private function cbButtonClose(param1:int) : void
        {
            this._btnClose.setDisable(true);
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        public static function getResource() : Array
        {
            return [_NAVI_CHARACTER_PATH];
        }// end function

    }
}
