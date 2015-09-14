package loginBonus
{
    import flash.display.*;
    import item.*;
    import message.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class LoginBonusSheetDisp extends Object
    {
        private const _WAIT_TIME:Number = 0.5;
        private const _PHASE_INIT:int = 1;
        private const _PHASE_OPEN:int = 10;
        private const _PHASE_TITLE:int = 11;
        private const _PHASE_TITLE_MINI:int = 12;
        private const _PHASE_WAIT:int = 13;
        private const _PHASE_PUSH_STAMP:int = 20;
        private const _PHASE_NEXT_PAGE:int = 21;
        private const _PHASE_GET_POPUP:int = 30;
        private const _PHASE_WAREHOUSE_POPUP:int = 31;
        private const _PHASE_CLOSE:int = 90;
        private var _bonusSheetData:LoginBonusSheetData;
        private var _phase:int;
        private var _mcBase:MovieClip;
        private var _isoTitleMini:InStayOut;
        private var _resourcePath:String;
        private var _mcMain:MovieClip;
        private var _isoMain:InStayOut;
        private var _mcTitleEffect:MovieClip;
        private var _mcTitle:MovieClip;
        private var _mcTitleLogo:MovieClip;
        private var _mcSheetMap1:MovieClip;
        private var _mcSheetMap2:MovieClip;
        private var _mcArrow:MovieClip;
        private var _sheet:LoginBonusSheet;
        private var _sheet1st:LoginBonusSheet;
        private var _sheet2nd:LoginBonusSheet;
        private var _stampIndex:int;
        private var _restStampCount:int;
        private var _waitTime:Number;
        private var _popup:LoginBonusPopup;
        private var _bEnd:Boolean;

        public function LoginBonusSheetDisp(param1:LoginBonusSheetData, param2:MovieClip, param3:String, param4:String)
        {
            this._bonusSheetData = param1;
            this._restStampCount = this._bonusSheetData.getStampCount;
            this._mcBase = param2;
            this._resourcePath = param3;
            this._mcArrow = ResourceManager.getInstance().createMovieClip(this._resourcePath, "mapArrowMc");
            this._mcMain = this._mcBase.logBoMapSetMc;
            this._mcMain.gotoAndPlay("stop");
            this._isoMain = new InStayOut(this._mcMain);
            this._popup = new LoginBonusPopup(this._mcBase.logBoWindowSetMc, this._bonusSheetData);
            if (this._bonusSheetData.bMiniTitleEnable)
            {
                this._mcTitle = ResourceManager.getInstance().createMovieClip(param4, "logBoTitle");
                this._mcBase.logBoKanbanMc.titleMcNull.addChild(this._mcTitle);
                this._mcBase.logBoKanbanMc.visible = true;
            }
            else
            {
                this._mcBase.logBoKanbanMc.visible = false;
            }
            this._mcSheetMap1 = ResourceManager.getInstance().createMovieClip(param4, "logBoMap");
            this._mcMain.logBoMapSwitchMc.logBoMapNull1.addChild(this._mcSheetMap1);
            this._mcSheetMap2 = ResourceManager.getInstance().createMovieClip(param4, "logBoMap");
            this._mcMain.logBoMapSwitchMc.logBoMapNull2.addChild(this._mcSheetMap2);
            this._mcMain.logBoMapSwitchMc.gotoAndStop("stop");
            this._mcTitleLogo = ResourceManager.getInstance().createMovieClip(param4, "logBoLogo");
            this._mcBase.logBoTopMc.logoMcNull.addChild(this._mcTitleLogo);
            this._mcTitleEffect = this._mcBase.logBoTopMc;
            this._mcTitleEffect.gotoAndStop("stop");
            if (this._bonusSheetData.bMiniTitleEnable)
            {
                this._isoTitleMini = new InStayOut(this._mcBase.logBoKanbanMc);
            }
            this.setPhase(this._PHASE_INIT);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            this._mcTitleEffect = null;
            if (this._popup)
            {
                this._popup.release();
            }
            this._popup = null;
            if (this._sheet)
            {
                this._sheet.release();
            }
            this._sheet = null;
            if (this._isoTitleMini)
            {
                this._isoTitleMini.release();
            }
            this._isoTitleMini = null;
            if (this._sheet1st)
            {
                this._sheet1st.release();
            }
            this._sheet1st = null;
            if (this._sheet2nd)
            {
                this._sheet2nd.release();
            }
            this._sheet2nd = null;
            this._sheet = null;
            if (this._mcTitleLogo != null)
            {
                if (this._mcTitleLogo.parent)
                {
                    this._mcTitleLogo.parent.removeChild(this._mcTitleLogo);
                }
            }
            this._mcTitleLogo = null;
            if (this._mcSheetMap1 != null)
            {
                if (this._mcSheetMap1.parent)
                {
                    this._mcSheetMap1.parent.removeChild(this._mcSheetMap1);
                }
            }
            this._mcSheetMap1 = null;
            if (this._mcSheetMap2 != null)
            {
                if (this._mcSheetMap2.parent)
                {
                    this._mcSheetMap2.parent.removeChild(this._mcSheetMap2);
                }
            }
            this._mcSheetMap2 = null;
            if (this._mcTitle != null)
            {
                if (this._mcTitle.parent)
                {
                    this._mcTitle.parent.removeChild(this._mcTitle);
                }
            }
            this._mcTitle = null;
            if (this._mcArrow != null)
            {
                if (this._mcArrow.parent)
                {
                    this._mcArrow.parent.removeChild(this._mcArrow);
                }
            }
            this._mcArrow = null;
            if (this._isoMain != null)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            this._mcBase = null;
            this._bonusSheetData = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_INIT:
                {
                    this.controlInit(param1);
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.controlOpen(param1);
                    break;
                }
                case this._PHASE_TITLE:
                {
                    this.controlTitle(param1);
                    break;
                }
                case this._PHASE_TITLE_MINI:
                {
                    this.controlTitleMini(param1);
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait(param1);
                    break;
                }
                case this._PHASE_PUSH_STAMP:
                {
                    this.controlPushStamp(param1);
                    break;
                }
                case this._PHASE_NEXT_PAGE:
                {
                    this.controlNextPage(param1);
                    break;
                }
                case this._PHASE_GET_POPUP:
                {
                    this.controlGetPopup(param1);
                    break;
                }
                case this._PHASE_WAREHOUSE_POPUP:
                {
                    this.controlWarehousePopup(param1);
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setPhase(param1:int) : void
        {
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_INIT:
                {
                    this.phaseInit();
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.phaseOpen();
                    break;
                }
                case this._PHASE_TITLE:
                {
                    this.phaseTitle();
                    break;
                }
                case this._PHASE_TITLE_MINI:
                {
                    this.phaseTitleMini();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.phaseWait();
                    break;
                }
                case this._PHASE_PUSH_STAMP:
                {
                    this.phasePushStamp();
                    break;
                }
                case this._PHASE_NEXT_PAGE:
                {
                    this.phaseNextPage();
                    break;
                }
                case this._PHASE_GET_POPUP:
                {
                    this.phaseGetPopup();
                    break;
                }
                case this._PHASE_WAREHOUSE_POPUP:
                {
                    this.phaseWarehousePopup();
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
            return;
        }// end function

        private function phaseInit() : void
        {
            if (this._bonusSheetData.bStampEnable)
            {
                this._sheet1st = new LoginBonusSheet(this._mcSheetMap1, this._bonusSheetData.aSheetBonus, this._bonusSheetData.nowStampCount, this._resourcePath);
                this._sheet1st.setMark(this._bonusSheetData.nowStampCount, this._mcArrow);
                if (this._bonusSheetData.aNextSheetBonus.length > 0 && this._bonusSheetData.nowStampCount + this._bonusSheetData.getStampCount > this._bonusSheetData.aSheetBonus.length)
                {
                    this._sheet2nd = new LoginBonusSheet(this._mcSheetMap2, this._bonusSheetData.aNextSheetBonus, 0, this._resourcePath);
                }
                this._sheet = this._sheet1st;
                this._stampIndex = this._bonusSheetData.nowStampCount;
            }
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        private function controlInit(param1:Number) : void
        {
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoMain.setIn();
            return;
        }// end function

        private function controlOpen(param1:Number) : void
        {
            if (this._isoMain.bOpened)
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_ROGINBONUS_TITLE);
                this.setPhase(this._PHASE_TITLE);
            }
            return;
        }// end function

        private function phaseTitle() : void
        {
            this._mcTitleEffect.gotoAndPlay("start");
            return;
        }// end function

        private function controlTitle(param1:Number) : void
        {
            if (this._mcTitleEffect.currentLabel == "end")
            {
                this.setPhase(this._PHASE_TITLE_MINI);
            }
            return;
        }// end function

        private function phaseTitleMini() : void
        {
            if (this._isoTitleMini)
            {
                this._isoTitleMini.setIn();
            }
            else
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function controlTitleMini(param1:Number) : void
        {
            if (this._isoTitleMini.bOpened)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._waitTime = this._WAIT_TIME;
            return;
        }// end function

        private function controlWait(param1:Number) : void
        {
            this._waitTime = this._waitTime - param1;
            if (this._waitTime <= 0)
            {
                if (this._sheet)
                {
                    this.setPhase(this._PHASE_PUSH_STAMP);
                }
                else
                {
                    this.setPhase(this._PHASE_GET_POPUP);
                }
            }
            return;
        }// end function

        private function phasePushStamp() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = this._bonusSheetData.aGetBonus[this._bonusSheetData.aGetBonus.length - this._restStampCount];
            if (_loc_2)
            {
                _loc_1 = ResourceManager.getInstance().createBitmap(ItemManager.getInstance().getItemPng(_loc_2.type, _loc_2.id));
            }
            if (_loc_1)
            {
                _loc_1.smoothing = true;
            }
            this._sheet.setPushStamp(this._stampIndex, _loc_1);
            return;
        }// end function

        private function controlPushStamp(param1:Number) : void
        {
            this._sheet.control(param1);
            if (this._sheet.isStampAnimation() == false)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._stampIndex + 1;
                _loc_2._stampIndex = _loc_3;
                var _loc_2:* = this;
                var _loc_3:* = this._restStampCount - 1;
                _loc_2._restStampCount = _loc_3;
                if (this._restStampCount == 0)
                {
                    this.setPhase(this._PHASE_GET_POPUP);
                }
                else if (this._stampIndex >= this._bonusSheetData.aSheetBonus.length)
                {
                    this.setPhase(this._PHASE_NEXT_PAGE);
                }
                else
                {
                    this.setPhase(this._PHASE_PUSH_STAMP);
                }
            }
            return;
        }// end function

        private function phaseNextPage() : void
        {
            this._mcMain.logBoMapSwitchMc.gotoAndPlay("start");
            return;
        }// end function

        private function controlNextPage(param1:Number) : void
        {
            if (this._mcMain.logBoMapSwitchMc.currentLabel == "end")
            {
                this._sheet = this._sheet2nd;
                this._stampIndex = 0;
                this.setPhase(this._PHASE_PUSH_STAMP);
            }
            return;
        }// end function

        private function phaseGetPopup() : void
        {
            this._popup.open();
            return;
        }// end function

        private function controlGetPopup(param1:Number) : void
        {
            if (this._popup.bEnd)
            {
                if (this._bonusSheetData.bWarehouse)
                {
                    this.setPhase(this._PHASE_WAREHOUSE_POPUP);
                }
                else
                {
                    this.setPhase(this._PHASE_CLOSE);
                }
            }
            return;
        }// end function

        private function phaseWarehousePopup() : void
        {
            CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_SEND_STRAGE), function () : void
            {
                setPhase(_PHASE_CLOSE);
                return;
            }// end function
            );
            return;
        }// end function

        private function controlWarehousePopup(param1:Number) : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            if (this._isoTitleMini)
            {
                this._isoTitleMini.setOut();
            }
            this._isoMain.setOut(this.cbClose);
            return;
        }// end function

        private function controlClose(param1:Number) : void
        {
            return;
        }// end function

        private function cbClose() : void
        {
            this._bEnd = true;
            return;
        }// end function

    }
}
