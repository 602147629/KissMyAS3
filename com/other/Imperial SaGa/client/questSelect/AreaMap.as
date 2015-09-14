package questSelect
{
    import area.*;
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import message.*;
    import quest.*;
    import resource.*;
    import utility.*;

    public class AreaMap extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoIcon:InStayOut;
        private var _isoBanner:InStayOut;
        private var _timer:Timer;
        private var _areaId:int;
        private var _bmpBg:Bitmap;
        private var _aQuest:Array;
        private var _aBanner:Array;
        private var _aBtnIcon:Array;
        private var _aIconMc:Array;
        private var _bIconClose:Boolean;
        private var _displayBannerIndex:int;
        private var _bannerBtn:ButtonBase;
        private var _aBannerBtn:Array;
        private var _aBannerLampMc:Array;
        private var _cbIconMouseOver:Function;
        private var _cbIconMouseOut:Function;
        private var _cbIconClick:Function;
        private var _cbMapClick:Function;
        private var _bBtnEnable:Boolean;

        public function AreaMap(param1:MovieClip, param2:Function, param3:Function, param4:Function, param5:Function)
        {
            this._mc = param1;
            this._cbIconMouseOver = param2;
            this._cbIconMouseOut = param3;
            this._cbIconClick = param4;
            this._cbMapClick = param5;
            this._isoMain = new InStayOut(this._mc);
            this._isoIcon = new InStayOut(this._mc.areamapMoveMc.iconLayerMc);
            this._isoBanner = new InStayOut(this._mc.areamapMoveMc.bannerMc);
            this._aBannerLampMc = [this._mc.areamapMoveMc.bannerMc.bannerPageMc.infoPage_Lamp1Mc, this._mc.areamapMoveMc.bannerMc.bannerPageMc.infoPage_Lamp2Mc, this._mc.areamapMoveMc.bannerMc.bannerPageMc.infoPage_Lamp3Mc];
            this._aQuest = new Array();
            this._aBanner = new Array();
            this._aBtnIcon = new Array();
            this._aIconMc = new Array();
            this._bBtnEnable = false;
            TextControl.setIdText(this._mc.areamapMoveMc.areamapTextMc.textDt, MessageId.AREA_MAP_INFORMATION);
            return;
        }// end function

        public function get aBtnIcon() : Array
        {
            return this._aBtnIcon;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function get bIconClose() : Boolean
        {
            return this._bIconClose;
        }// end function

        public function get bBtnEnable() : Boolean
        {
            return this._bBtnEnable;
        }// end function

        public function release() : void
        {
            if (this._bannerBtn)
            {
                ButtonManager.getInstance().removeButton(this._bannerBtn);
            }
            this._bannerBtn = null;
            this.deleteButton();
            if (this._timer)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
            }
            this._timer = null;
            if (this._mc.areamapMoveMc.bannerMc.bannerBtnMc.bannerNull.numChildren > 0)
            {
                this._mc.areamapMoveMc.bannerMc.bannerBtnMc.bannerNull.removeChildren();
            }
            this._isoIcon.release();
            this._isoIcon = null;
            this._isoMain.release();
            this._isoMain = null;
            this._isoBanner.release();
            this._isoBanner = null;
            this.removeQuestIcon();
            if (this._mc.hasEventListener(MouseEvent.CLICK) == true)
            {
                this._mc.removeEventListener(MouseEvent.CLICK, this._cbMapClick);
            }
            if (this._bmpBg != null)
            {
                if (this._bmpBg.parent)
                {
                    this._bmpBg.parent.removeChild(this._bmpBg);
                }
            }
            this._bmpBg = null;
            return;
        }// end function

        public function setIn(param1:int, param2:Array) : void
        {
            this._areaId = param1;
            if (this._bmpBg != null && this._bmpBg.parent)
            {
                this._bmpBg.parent.removeChild(this._bmpBg);
            }
            var _loc_3:* = AreaManager.getInstance().getArea(this._areaId);
            this._bmpBg = ResourceManager.getInstance().createBitmap(ResourcePath.QUEST_AREA_MAP_PATH + _loc_3.areaMapFile);
            this._bmpBg.smoothing = true;
            this._mc.areamapMoveMc.imageNull.addChild(this._bmpBg);
            if (this._areaId != QuestConstant.BATTLE_QUEST_AREA_ID)
            {
                this._mc.areamapMoveMc.bannerMc.visible = false;
                this.setDsableBanner(true);
            }
            else
            {
                this._aBanner = param2;
                this.createBanner();
            }
            this._isoMain.setIn();
            return;
        }// end function

        public function setOut() : void
        {
            this._isoMain.setOut();
            this._aBanner = [];
            if (this._isoBanner)
            {
                this._isoBanner.setOut();
            }
            if (this._timer)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
            }
            return;
        }// end function

        public function setFlagOn(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            for each (_loc_2 in this._aIconMc)
            {
                
                _loc_3 = _loc_2.mc as MovieClip;
                _loc_4 = _loc_2.putMc as MovieClip;
                if (param1 == _loc_2.id)
                {
                    _loc_3.battleFlagMc.visible = true;
                    _loc_4.mapNewMc.visible = false;
                    _loc_4.mapEasyMc.visible = false;
                    _loc_4.mapStoryMc.visible = false;
                    continue;
                }
                _loc_3.battleFlagMc.visible = false;
                _loc_4.mapNewMc.visible = _loc_2.bNewIcon;
                _loc_4.mapEasyMc.visible = _loc_2.bEasyIcon;
                _loc_4.mapStoryMc.visible = _loc_2.bStoryIcon;
            }
            return;
        }// end function

        public function allFlagOff() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_1 in this._aIconMc)
            {
                
                _loc_2 = _loc_1.mc as MovieClip;
                _loc_3 = _loc_1.putMc as MovieClip;
                _loc_2.battleFlagMc.visible = false;
                _loc_3.mapNewMc.visible = _loc_1.bNewIcon;
                _loc_3.mapEasyMc.visible = _loc_1.bEasyIcon;
                _loc_3.mapStoryMc.visible = _loc_1.bStoryIcon;
            }
            return;
        }// end function

        public function inIcon(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = false;
            var _loc_10:* = false;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            this.removeQuestIcon();
            this.deleteButton();
            this._aQuest = param1;
            this._aIconMc = new Array();
            for each (_loc_2 in this._aQuest)
            {
                
                _loc_6 = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf", "QuestIconMc");
                _loc_7 = ResourceManager.getInstance().createMovieClip(ResourcePath.QUEST_PATH + "UI_QuestSelect.swf", "QuestIconPutMc");
                _loc_6.x = _loc_2.iconPos.x;
                _loc_6.y = _loc_2.iconPos.y;
                _loc_7.x = _loc_6.x;
                _loc_7.y = _loc_6.y;
                DisplayUtils.setMouseEnable(_loc_6.battleFlagMc, false);
                DisplayUtils.setMouseEnable(_loc_7, false);
                _loc_8 = _loc_2.bNewQuest;
                _loc_9 = _loc_2.bEasyQuest;
                _loc_10 = _loc_2.bStoryQuest;
                _loc_9 = _loc_9 && _loc_10 == false;
                _loc_6.battleFlagMc.visible = false;
                _loc_7.mapNewMc.visible = _loc_8;
                _loc_7.mapEasyMc.visible = _loc_9;
                _loc_7.mapStoryMc.visible = _loc_10;
                _loc_11 = QuestConstant.AREA_QUEST_TYPE_NORMAL;
                switch(_loc_2.questType)
                {
                    case CommonConstant.QUEST_TYPE_DAILY:
                    {
                        _loc_11 = QuestConstant.AREA_QUEST_TYPE_WEEKLY;
                        break;
                    }
                    case CommonConstant.QUEST_TYPE_GUERRILLA:
                    {
                        _loc_11 = QuestConstant.AREA_QUEST_TYPE_GUERRILLA;
                        break;
                    }
                    case CommonConstant.QUEST_TYPE_CHALLENGE:
                    {
                        _loc_11 = QuestConstant.AREA_QUEST_TYPE_DAILY;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_6.iconMc.markMc.gotoAndStop(_loc_11);
                _loc_12 = _loc_2.iconPos.y * 10000 + _loc_2.iconPos.x;
                _loc_13 = new QuestIconButton(_loc_6, _loc_6.iconMc, this._cbIconClick, this._cbIconMouseOver, this._cbIconMouseOut);
                _loc_13.setId(_loc_2.no);
                _loc_13.enterSeId = Constant.UNDECIDED;
                _loc_13.setDisableFlag(!this._bBtnEnable);
                ButtonManager.getInstance().addButtonBase(_loc_13);
                _loc_14 = new Object();
                _loc_14.id = _loc_2.no;
                _loc_14.mc = _loc_6;
                _loc_14.putMc = _loc_7;
                _loc_14.bNewIcon = _loc_8;
                _loc_14.bEasyIcon = _loc_9;
                _loc_14.bStoryIcon = _loc_10;
                _loc_14.priority = _loc_12;
                this._aBtnIcon.push(_loc_13);
                this._aIconMc.push(_loc_14);
            }
            this._aIconMc.sortOn("priority", Array.NUMERIC);
            _loc_3 = this._mc.areamapMoveMc.iconLayerMc.iconNull;
            _loc_5 = 0;
            while (_loc_5 < this._aIconMc.length)
            {
                
                _loc_4 = this._aIconMc[_loc_5];
                _loc_3.addChild(_loc_4.mc);
                _loc_5++;
            }
            _loc_5 = 0;
            while (_loc_5 < this._aIconMc.length)
            {
                
                _loc_4 = this._aIconMc[_loc_5];
                _loc_3.addChild(_loc_4.putMc);
                _loc_5++;
            }
            this._isoIcon.setIn(this.cbSetIn);
            this._bIconClose = false;
            return;
        }// end function

        public function outIcon() : void
        {
            this._aQuest = [];
            this.removeQuestIcon();
            this.setButtonEnable(false);
            this.deleteButton();
            this._isoIcon.setOut(this.cbOutIcon);
            return;
        }// end function

        private function cbOutIcon() : void
        {
            this._bIconClose = true;
            this.deleteButton();
            return;
        }// end function

        private function cbSetIn() : void
        {
            return;
        }// end function

        private function deleteButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBtnIcon)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
                _loc_1.release();
            }
            this._aBtnIcon = [];
            return;
        }// end function

        public function setSelectIcon(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBtnIcon)
            {
                
                if (_loc_2.id == param1)
                {
                    _loc_2.setMouseOverDisplay();
                    break;
                }
            }
            return;
        }// end function

        public function setNotSelectIcon(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aBtnIcon)
            {
                
                if (_loc_2.id == param1)
                {
                    _loc_2.setMouseOutDisplay();
                    break;
                }
            }
            return;
        }// end function

        public function resetSelectIcon() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aBtnIcon)
            {
                
                _loc_1.setMouseOutDisplay();
            }
            return;
        }// end function

        private function createBanner() : void
        {
            var _loc_1:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._mc.areamapMoveMc.bannerMc.bannerBtnMc.bannerNull.numChildren > 0)
            {
                this._mc.areamapMoveMc.bannerMc.bannerBtnMc.bannerNull.removeChildren();
            }
            for each (_loc_1 in this._aBannerLampMc)
            {
                
                _loc_1.gotoAndStop("off");
            }
            this._displayBannerIndex = 0;
            this._mc.areamapMoveMc.bannerMc.visible = this._aBanner.length > 0;
            this.setDsableBanner(this._aBanner.length == 0);
            if (this._aBanner.length == 0)
            {
                return;
            }
            var _loc_2:* = this._aBanner[this._displayBannerIndex];
            var _loc_3:* = this._mc.areamapMoveMc.bannerMc;
            if (_loc_2 != null)
            {
                _loc_4 = ResourceManager.getInstance().createBitmap(_loc_2.bannerPath);
                if (_loc_4 != null)
                {
                    _loc_3.bannerBtnMc.bannerNull.addChild(_loc_4);
                    this._isoBanner.setIn(this.cbBannerSetIn);
                }
                if (this._bannerBtn)
                {
                    ButtonManager.getInstance().removeButton(this._bannerBtn);
                }
                this._bannerBtn = null;
                this._bannerBtn = ButtonManager.getInstance().addButton(_loc_3.bannerBtnMc, this.cbBannerButton);
                this.setDsableBanner(true);
                _loc_3.bannerPageMc.gotoAndStop("infoPage" + this._aBanner.length);
                _loc_5 = this._aBannerLampMc[this._displayBannerIndex];
                _loc_5.gotoAndStop("on");
            }
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._bBtnEnable = param1;
            for each (_loc_2 in this._aBtnIcon)
            {
                
                _loc_2.setMouseOutDisplay();
                _loc_2.setDisableFlag(param1 == false);
            }
            if (param1)
            {
                this._mc.addEventListener(MouseEvent.CLICK, this._cbMapClick);
            }
            else
            {
                this._mc.removeEventListener(MouseEvent.CLICK, this._cbMapClick);
            }
            return;
        }// end function

        private function removeQuestIcon() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aIconMc)
            {
                
                if (_loc_1.putMc != null && _loc_1.putMc.parent != null)
                {
                    _loc_1.putMc.parent.removeChild(_loc_1.putMc);
                }
                _loc_1.putMc = null;
                if (_loc_1.mc != null && _loc_1.mc.parent != null)
                {
                    _loc_1.mc.parent.removeChild(_loc_1.mc);
                }
                _loc_1.mc = null;
            }
            this._aIconMc = [];
            return;
        }// end function

        private function setDsableBanner(param1:Boolean) : void
        {
            if (this._bannerBtn)
            {
                this._bannerBtn.setDisableFlag(param1);
            }
            return;
        }// end function

        private function cbBannerButton(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aBanner[this._displayBannerIndex];
            if (_loc_2 != null)
            {
                _loc_3 = new URLRequest(_loc_2.url);
                navigateToURL(_loc_3);
            }
            return;
        }// end function

        private function cbTimer(event:TimerEvent) : void
        {
            if (this._timer)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
            }
            if (this._aBanner.length > 1)
            {
                if (this._isoBanner)
                {
                    this._isoBanner.setOut(this.cbBannerSetOut);
                }
                if (this._bannerBtn)
                {
                    this.setDsableBanner(true);
                }
            }
            return;
        }// end function

        private function cbBannerSetIn() : void
        {
            if (this._bannerBtn)
            {
                this.setDsableBanner(false);
            }
            if (this._timer != null)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
            }
            if (this._aBanner.length == 0)
            {
                return;
            }
            if (this._aBanner.length > 1)
            {
                this._timer = new Timer(5000, 1);
                this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimer);
                this._timer.start();
            }
            return;
        }// end function

        private function cbBannerSetOut() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = this;
            var _loc_7:* = this._displayBannerIndex + 1;
            _loc_6._displayBannerIndex = _loc_7;
            if (this._aBanner.length <= this._displayBannerIndex)
            {
                this._displayBannerIndex = 0;
            }
            var _loc_1:* = this._aBanner[this._displayBannerIndex];
            var _loc_2:* = this._mc.areamapMoveMc.bannerMc;
            if (_loc_2.bannerBtnMc.bannerNull.numChildren > 0)
            {
                _loc_2.bannerBtnMc.bannerNull.removeChildren();
            }
            for each (_loc_3 in this._aBannerLampMc)
            {
                
                _loc_3.gotoAndStop("off");
            }
            _loc_4 = this._aBannerLampMc[this._displayBannerIndex];
            _loc_4.gotoAndStop("on");
            _loc_5 = ResourceManager.getInstance().createBitmap(_loc_1.bannerPath);
            if (_loc_5 != null)
            {
                _loc_2.bannerBtnMc.bannerNull.addChild(_loc_5);
                this._isoBanner.setIn(this.cbBannerSetIn);
            }
            return;
        }// end function

    }
}
