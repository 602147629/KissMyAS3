package makeEquip
{
    import button.*;
    import destinystone.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import item.*;
    import message.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import status.*;
    import utility.*;

    public class MakeEquipDecompositionProduction extends MakeEquipBase
    {
        private var _aStoneImage:Array;
        private var _aStatusPopUp:Array;
        private var _aDecompositionStones:Array;
        private var _itemId:Array;
        private var decompoItemGetMc:Array;
        private var _bResource:Boolean;
        private var _isoDecompoArray:Array;
        private var _mcWindow:MovieClip;
        private var _bWarehouse:Boolean;
        private var _bmp:Bitmap;
        private var Iconlistener1:MovieClip;
        private var StatusPopUp1:ItemNameStatus;
        private var Iconlistener2:MovieClip;
        private var StatusPopUp2:ItemNameStatus;
        private var Iconlistener3:MovieClip;
        private var StatusPopUp3:ItemNameStatus;
        private var Iconlistener4:MovieClip;
        private var StatusPopUp4:ItemNameStatus;
        private var Iconlistener5:MovieClip;
        private var StatusPopUp5:ItemNameStatus;
        private var Iconlistener6:MovieClip;
        private var StatusPopUp6:ItemNameStatus;
        private var Iconlistener7:MovieClip;
        private var StatusPopUp7:ItemNameStatus;
        private var Iconlistener8:MovieClip;
        private var StatusPopUp8:ItemNameStatus;
        private var Iconlistener9:MovieClip;
        private var StatusPopUp9:ItemNameStatus;
        private var Iconlistener11:MovieClip;
        private var StatusPopUp11:ItemNameStatus;
        private var Iconlistener12:MovieClip;
        private var StatusPopUp12:ItemNameStatus;
        private var Iconlistener13:MovieClip;
        private var StatusPopUp13:ItemNameStatus;
        private var Iconlistener14:MovieClip;
        private var StatusPopUp14:ItemNameStatus;
        private var Iconlistener15:MovieClip;
        private var StatusPopUp15:ItemNameStatus;
        private var Iconlistener16:MovieClip;
        private var StatusPopUp16:ItemNameStatus;
        private var Iconlistener17:MovieClip;
        private var StatusPopUp17:ItemNameStatus;
        private var Iconlistener18:MovieClip;
        private var StatusPopUp18:ItemNameStatus;
        private var timerStartItem:Array;
        private var decompoStonesNames:Array;
        private var itemsShown:Boolean = false;
        private const aDecompositionStoneNull:Array;

        public function MakeEquipDecompositionProduction(param1:DisplayObjectContainer, param2:MovieClip, param3:Array, param4:Array, param5:Boolean)
        {
            var n:int;
            var aStoneId:Array;
            var i:int;
            var decompoItemGetMc:MovieClip;
            var stoneInfo:DestinyStoneInformation;
            var bmp:Bitmap;
            var m:MovieClip;
            var p:MovieClip;
            var _isoDecompoItemGetMc:InStayOut;
            var timerIconOpen1:Timer;
            var isoItem1:InStayOut;
            var timerIconOpen2:Timer;
            var isoItem2:InStayOut;
            var timerIconOpen3:Timer;
            var isoItem3:InStayOut;
            var timerIconOpen4:Timer;
            var isoItem4:InStayOut;
            var timerIconOpen5:Timer;
            var isoItem5:InStayOut;
            var timerIconOpen6:Timer;
            var isoItem6:InStayOut;
            var timerIconOpen7:Timer;
            var isoItem7:InStayOut;
            var timerIconOpen8:Timer;
            var isoItem8:InStayOut;
            var timerIconOpen9:Timer;
            var isoItem9:InStayOut;
            var parent:* = param1;
            var mcWindow:* = param2;
            var itemId:* = param3;
            var stoneArray:* = param4;
            var bWarehouse:* = param5;
            this.aDecompositionStoneNull = [[], [0], [1, 2], [0, 3, 4], [1, 2, 3, 4], [0, 1, 2, 3, 4]];
            this._aDecompositionStones = [];
            this._aDecompositionStones = stoneArray;
            this._isoDecompoArray = [];
            this._aStatusPopUp = [];
            this.timerStartItem = [];
            this.decompoStonesNames = [];
            this._itemId = itemId;
            this._mcWindow = mcWindow;
            this._bWarehouse = bWarehouse && stoneArray.length > 0;
            var className:String;
            super(parent, className, false);
            this._aStoneImage = [];
            var aMcStoneImage:Array;
            var aMcStonePopUpPosition:Array;
            var Decided_aMcStoneImage:Array;
            switch(this._aDecompositionStones.length)
            {
                case 1:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 2:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 3:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 4:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 5:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 6:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 7:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 8:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                case 9:
                {
                    Decided_aMcStoneImage;
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.createPopUps();
            if (this._aDecompositionStones != null)
            {
                aStoneId = this.aDecompositionStoneNull[this._aDecompositionStones.length];
                i;
                while (i < this._aDecompositionStones.length)
                {
                    
                    decompoItemGetMc = ResourceManager.getInstance().createMovieClip(MakeEquipConstant.RESOURCE_PATH, "decompoItemGetMc");
                    stoneInfo = ItemManager.getInstance().getDestinyStoneInformation(this._aDecompositionStones[i].materialId);
                    bmp = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + stoneInfo.fileName);
                    bmp.smoothing = true;
                    decompoItemGetMc.itemIcon.dsNull.addChild(bmp);
                    m = Decided_aMcStoneImage[i];
                    p = aMcStonePopUpPosition[i];
                    m.addChild(decompoItemGetMc);
                    TextControl.setText(decompoItemGetMc.itemIcon.NumTextMc.textDt, this._aDecompositionStones[i].num);
                    this._aStoneImage.push(bmp);
                    this.decompoStonesNames.push(stoneInfo.name);
                    _isoDecompoItemGetMc = new InStayOut(decompoItemGetMc);
                    this._isoDecompoArray.push(_isoDecompoItemGetMc);
                    i = (i + 1);
                }
            }
            this.setPopUps();
            switch(this.decompoStonesNames.length)
            {
                case 1:
                {
                    this.StatusPopUp5.setStatus(this.decompoStonesNames[0]);
                    break;
                }
                case 2:
                {
                    this.StatusPopUp14.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp15.setStatus(this.decompoStonesNames[1]);
                    break;
                }
                case 3:
                {
                    this.StatusPopUp4.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp5.setStatus(this.decompoStonesNames[1]);
                    this.StatusPopUp6.setStatus(this.decompoStonesNames[2]);
                    break;
                }
                case 4:
                {
                    this.StatusPopUp13.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp14.setStatus(this.decompoStonesNames[1]);
                    this.StatusPopUp15.setStatus(this.decompoStonesNames[2]);
                    this.StatusPopUp16.setStatus(this.decompoStonesNames[3]);
                    break;
                }
                case 5:
                {
                    this.StatusPopUp3.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp4.setStatus(this.decompoStonesNames[1]);
                    this.StatusPopUp5.setStatus(this.decompoStonesNames[2]);
                    this.StatusPopUp6.setStatus(this.decompoStonesNames[3]);
                    this.StatusPopUp7.setStatus(this.decompoStonesNames[4]);
                    break;
                }
                case 6:
                {
                    this.StatusPopUp12.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp13.setStatus(this.decompoStonesNames[1]);
                    this.StatusPopUp14.setStatus(this.decompoStonesNames[2]);
                    this.StatusPopUp15.setStatus(this.decompoStonesNames[3]);
                    this.StatusPopUp16.setStatus(this.decompoStonesNames[4]);
                    this.StatusPopUp17.setStatus(this.decompoStonesNames[5]);
                    break;
                }
                case 7:
                {
                    this.StatusPopUp2.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp3.setStatus(this.decompoStonesNames[1]);
                    this.StatusPopUp4.setStatus(this.decompoStonesNames[2]);
                    this.StatusPopUp5.setStatus(this.decompoStonesNames[3]);
                    this.StatusPopUp6.setStatus(this.decompoStonesNames[4]);
                    this.StatusPopUp7.setStatus(this.decompoStonesNames[5]);
                    this.StatusPopUp8.setStatus(this.decompoStonesNames[6]);
                    break;
                }
                case 8:
                {
                    this.StatusPopUp11.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp12.setStatus(this.decompoStonesNames[1]);
                    this.StatusPopUp13.setStatus(this.decompoStonesNames[2]);
                    this.StatusPopUp14.setStatus(this.decompoStonesNames[3]);
                    this.StatusPopUp15.setStatus(this.decompoStonesNames[4]);
                    this.StatusPopUp16.setStatus(this.decompoStonesNames[5]);
                    this.StatusPopUp17.setStatus(this.decompoStonesNames[6]);
                    this.StatusPopUp18.setStatus(this.decompoStonesNames[7]);
                    break;
                }
                case 9:
                {
                    this.StatusPopUp1.setStatus(this.decompoStonesNames[0]);
                    this.StatusPopUp2.setStatus(this.decompoStonesNames[1]);
                    this.StatusPopUp3.setStatus(this.decompoStonesNames[2]);
                    this.StatusPopUp4.setStatus(this.decompoStonesNames[3]);
                    this.StatusPopUp5.setStatus(this.decompoStonesNames[4]);
                    this.StatusPopUp6.setStatus(this.decompoStonesNames[5]);
                    this.StatusPopUp7.setStatus(this.decompoStonesNames[6]);
                    this.StatusPopUp8.setStatus(this.decompoStonesNames[7]);
                    this.StatusPopUp9.setStatus(this.decompoStonesNames[8]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            n;
            while (n < this._isoDecompoArray.length)
            {
                
                switch(n)
                {
                    case 0:
                    {
                        timerIconOpen1 = new Timer(n * 150, 1);
                        isoItem1 = this._isoDecompoArray[0];
                        timerIconOpen1.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem1.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen1);
                        break;
                    }
                    case 1:
                    {
                        timerIconOpen2 = new Timer(n * 150, 1);
                        isoItem2 = this._isoDecompoArray[1];
                        timerIconOpen2.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem2.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen2);
                        break;
                    }
                    case 2:
                    {
                        timerIconOpen3 = new Timer(n * 150, 1);
                        isoItem3 = this._isoDecompoArray[2];
                        timerIconOpen3.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem3.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen3);
                        break;
                    }
                    case 3:
                    {
                        timerIconOpen4 = new Timer(n * 150, 1);
                        isoItem4 = this._isoDecompoArray[3];
                        timerIconOpen4.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem4.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen4);
                        break;
                    }
                    case 4:
                    {
                        timerIconOpen5 = new Timer(n * 150, 1);
                        isoItem5 = this._isoDecompoArray[4];
                        timerIconOpen5.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem5.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen5);
                        break;
                    }
                    case 5:
                    {
                        timerIconOpen6 = new Timer(n * 150, 1);
                        isoItem6 = this._isoDecompoArray[5];
                        timerIconOpen6.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem6.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen6);
                        break;
                    }
                    case 6:
                    {
                        timerIconOpen7 = new Timer(n * 150, 1);
                        isoItem7 = this._isoDecompoArray[6];
                        timerIconOpen7.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem7.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen7);
                        break;
                    }
                    case 7:
                    {
                        timerIconOpen8 = new Timer(n * 150, 1);
                        isoItem8 = this._isoDecompoArray[7];
                        timerIconOpen8.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem8.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen8);
                        break;
                    }
                    case 8:
                    {
                        timerIconOpen9 = new Timer(n * 150, 1);
                        isoItem9 = this._isoDecompoArray[8];
                        timerIconOpen9.addEventListener(TimerEvent.TIMER_COMPLETE, function () : void
            {
                isoItem9.setIn();
                return;
            }// end function
            );
                        this.timerStartItem.push(timerIconOpen9);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                n = (n + 1);
            }
            var btn:* = ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbReturn);
            btn.enterSeId = ButtonBase.SE_CANCEL_ID;
            _aButton.push(btn);
            setButtonDisable(true);
            TextControl.setIdText(_mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            this.setOpen();
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            super.release();
            if (this._bmp)
            {
                if (this._bmp.bitmapData != null)
                {
                    this._bmp.bitmapData.dispose();
                }
                if (this._bmp.parent)
                {
                    this._bmp.parent.removeChild(this._bmp);
                }
            }
            this._bmp = null;
            for each (_loc_1 in this._aStoneImage)
            {
                
                _loc_2 = _loc_1.bitmapData;
                if (_loc_2 != null)
                {
                    _loc_2.dispose();
                }
                if (_loc_1.parent != null)
                {
                    _loc_1.parent.removeChild(_loc_1);
                }
            }
            this._aStoneImage = [];
            this._aDecompositionStones = [];
            return;
        }// end function

        private function setOpen() : void
        {
            _mc.windNull.addChild(this._mcWindow);
            _isoMain.setIn(this.cbIn);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            if (_mc.isPlaying)
            {
                if (_mc.currentFrame == 12)
                {
                    SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_START1016);
                }
                if (_mc.currentFrameLabel == "item")
                {
                    if (this.itemsShown == false)
                    {
                        for each (_loc_3 in this.timerStartItem)
                        {
                            
                            _loc_3.start();
                        }
                        this.itemsShown = true;
                    }
                    SoundManager.getInstance().playSe(SoundId.SE_COMPOSE_SUCSESS);
                }
            }
            if (this._bResource)
            {
                return;
            }
            if (ResourceManager.getInstance().isLoaded() == false || SoundManager.getInstance().isLoaded() == false)
            {
                return;
            }
            var _loc_2:* = ItemManager.getInstance().getDestinyStoneInformation(this._aDecompositionStones[0].materialId);
            TextControl.setText(_mc.compoNameWindMc.textMc.textDt, StringTools.format(MessageManager.getInstance().getMessage(MessageId.MAKE_EQUIP_DECOMPO_SUCCESS_GET), _loc_2.name, this._aDecompositionStones[0].num));
            this._bResource = true;
            this.setOpen();
            return;
        }// end function

        private function cbIn() : void
        {
            if (this._bWarehouse)
            {
                CommonPopup.getInstance().openAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.CONFIRM_SEND_STRAGE), function () : void
            {
                enableButton();
                return;
            }// end function
            );
            }
            else
            {
                this.enableButton();
            }
            return;
        }// end function

        private function cbReturn(param1:int) : void
        {
            var isoItem:InStayOut;
            var id:* = param1;
            var _loc_3:* = 0;
            var _loc_4:* = this._isoDecompoArray;
            while (_loc_4 in _loc_3)
            {
                
                isoItem = _loc_4[_loc_3];
                isoItem.setOut(function () : void
            {
                close();
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function enableButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in _aButton)
            {
                
                _loc_1.setDisable(false);
            }
            return;
        }// end function

        private function createPopUps() : void
        {
            this.Iconlistener1 = _mc.getItemSetMc.SetNull01;
            this.StatusPopUp1 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp1);
            this.Iconlistener2 = _mc.getItemSetMc.SetNull02;
            this.StatusPopUp2 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp2);
            this.Iconlistener3 = _mc.getItemSetMc.SetNull03;
            this.StatusPopUp3 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp3);
            this.Iconlistener4 = _mc.getItemSetMc.SetNull04;
            this.StatusPopUp4 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp4);
            this.Iconlistener5 = _mc.getItemSetMc.SetNull05;
            this.StatusPopUp5 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp5);
            this.Iconlistener6 = _mc.getItemSetMc.SetNull06;
            this.StatusPopUp6 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp6);
            this.Iconlistener7 = _mc.getItemSetMc.SetNull07;
            this.StatusPopUp7 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp7);
            this.Iconlistener8 = _mc.getItemSetMc.SetNull08;
            this.StatusPopUp8 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp8);
            this.Iconlistener9 = _mc.getItemSetMc.SetNull09;
            this.StatusPopUp9 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp9);
            this.Iconlistener11 = _mc.getItemSetMc.SetNull11;
            this.StatusPopUp11 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp11);
            this.Iconlistener12 = _mc.getItemSetMc.SetNull12;
            this.StatusPopUp12 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp12);
            this.Iconlistener13 = _mc.getItemSetMc.SetNull13;
            this.StatusPopUp13 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp13);
            this.Iconlistener14 = _mc.getItemSetMc.SetNull14;
            this.StatusPopUp14 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp14);
            this.Iconlistener15 = _mc.getItemSetMc.SetNull15;
            this.StatusPopUp15 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp15);
            this.Iconlistener16 = _mc.getItemSetMc.SetNull16;
            this.StatusPopUp16 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp16);
            this.Iconlistener17 = _mc.getItemSetMc.SetNull17;
            this.StatusPopUp17 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp17);
            this.Iconlistener18 = _mc.getItemSetMc.SetNull18;
            this.StatusPopUp18 = new ItemNameStatus(_mc.getItemSetMc);
            this._aStatusPopUp.push(this.StatusPopUp18);
            return;
        }// end function

        private function setPopUps() : void
        {
            var StatusPopUpPos1:* = new Point(_mc.getItemSetMc.PopNull01.x, _mc.getItemSetMc.PopNull01.y);
            this.StatusPopUp1.setPosition(StatusPopUpPos1);
            this.StatusPopUp1.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener1.x + this.Iconlistener1.width / 2, _mc.getItemSetMc.y + this.Iconlistener1.y + this.Iconlistener1.height));
            this.StatusPopUp1.hide();
            this.Iconlistener1.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp1.show();
                return;
            }// end function
            );
            this.Iconlistener1.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp1.hide();
                return;
            }// end function
            );
            var StatusPopUpPos2:* = new Point(_mc.getItemSetMc.PopNull02.x, _mc.getItemSetMc.PopNull02.y);
            this.StatusPopUp2.setPosition(StatusPopUpPos2);
            this.StatusPopUp2.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener2.x + this.Iconlistener2.width / 2, _mc.getItemSetMc.y + this.Iconlistener2.y + this.Iconlistener2.height));
            this.StatusPopUp2.hide();
            this.Iconlistener2.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp2.show();
                return;
            }// end function
            );
            this.Iconlistener2.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp2.hide();
                return;
            }// end function
            );
            var StatusPopUpPos3:* = new Point(_mc.getItemSetMc.PopNull03.x, _mc.getItemSetMc.PopNull03.y);
            this.StatusPopUp3.setPosition(StatusPopUpPos3);
            this.StatusPopUp3.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener3.x + this.Iconlistener3.width / 2, _mc.getItemSetMc.y + this.Iconlistener3.y + this.Iconlistener3.height));
            this.StatusPopUp3.hide();
            this.Iconlistener3.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp3.show();
                return;
            }// end function
            );
            this.Iconlistener3.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp3.hide();
                return;
            }// end function
            );
            var StatusPopUpPos4:* = new Point(_mc.getItemSetMc.PopNull04.x, _mc.getItemSetMc.PopNull04.y);
            this.StatusPopUp4.setPosition(StatusPopUpPos4);
            this.StatusPopUp4.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener4.x + this.Iconlistener4.width / 2, _mc.getItemSetMc.y + this.Iconlistener4.y + this.Iconlistener4.height));
            this.StatusPopUp4.hide();
            this.Iconlistener4.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp4.show();
                return;
            }// end function
            );
            this.Iconlistener4.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp4.hide();
                return;
            }// end function
            );
            var StatusPopUpPos5:* = new Point(_mc.getItemSetMc.PopNull05.x, _mc.getItemSetMc.PopNull05.y);
            this.StatusPopUp5.setPosition(StatusPopUpPos5);
            this.StatusPopUp5.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener5.x + this.Iconlistener5.width / 2, _mc.getItemSetMc.y + this.Iconlistener5.y + this.Iconlistener5.height));
            this.StatusPopUp5.hide();
            this.Iconlistener5.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp5.show();
                return;
            }// end function
            );
            this.Iconlistener5.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp5.hide();
                return;
            }// end function
            );
            var StatusPopUpPos6:* = new Point(_mc.getItemSetMc.PopNull06.x, _mc.getItemSetMc.PopNull06.y);
            this.StatusPopUp6.setPosition(StatusPopUpPos6);
            this.StatusPopUp6.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener6.x + this.Iconlistener6.width / 2, _mc.getItemSetMc.y + this.Iconlistener6.y + this.Iconlistener6.height));
            this.StatusPopUp6.hide();
            this.Iconlistener6.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp6.show();
                return;
            }// end function
            );
            this.Iconlistener6.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp6.hide();
                return;
            }// end function
            );
            var StatusPopUpPos7:* = new Point(_mc.getItemSetMc.PopNull07.x, _mc.getItemSetMc.PopNull07.y);
            this.StatusPopUp7.setPosition(StatusPopUpPos7);
            this.StatusPopUp7.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener7.x + this.Iconlistener7.width / 2, _mc.getItemSetMc.y + this.Iconlistener7.y + this.Iconlistener7.height));
            this.StatusPopUp7.hide();
            this.Iconlistener7.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp7.show();
                return;
            }// end function
            );
            this.Iconlistener7.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp7.hide();
                return;
            }// end function
            );
            var StatusPopUpPos8:* = new Point(_mc.getItemSetMc.PopNull08.x, _mc.getItemSetMc.PopNull08.y);
            this.StatusPopUp8.setPosition(StatusPopUpPos8);
            this.StatusPopUp8.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener8.x + this.Iconlistener8.width / 2, _mc.getItemSetMc.y + this.Iconlistener8.y + this.Iconlistener8.height));
            this.StatusPopUp8.hide();
            this.Iconlistener8.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp8.show();
                return;
            }// end function
            );
            this.Iconlistener8.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp8.hide();
                return;
            }// end function
            );
            var StatusPopUpPos9:* = new Point(_mc.getItemSetMc.PopNull09.x, _mc.getItemSetMc.PopNull09.y);
            this.StatusPopUp9.setPosition(StatusPopUpPos9);
            this.StatusPopUp9.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener9.x + this.Iconlistener9.width / 2, _mc.getItemSetMc.y + this.Iconlistener9.y + this.Iconlistener9.height));
            this.StatusPopUp9.hide();
            this.Iconlistener9.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp9.show();
                return;
            }// end function
            );
            this.Iconlistener9.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp9.hide();
                return;
            }// end function
            );
            var StatusPopUpPos11:* = new Point(_mc.getItemSetMc.PopNull11.x, _mc.getItemSetMc.PopNull11.y);
            this.StatusPopUp11.setPosition(StatusPopUpPos11);
            this.StatusPopUp11.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener11.x + this.Iconlistener11.width / 2, _mc.getItemSetMc.y + this.Iconlistener11.y + this.Iconlistener11.height));
            this.StatusPopUp11.hide();
            this.Iconlistener11.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp11.show();
                return;
            }// end function
            );
            this.Iconlistener11.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp11.hide();
                return;
            }// end function
            );
            var StatusPopUpPos12:* = new Point(_mc.getItemSetMc.PopNull12.x, _mc.getItemSetMc.PopNull12.y);
            this.StatusPopUp12.setPosition(StatusPopUpPos12);
            this.StatusPopUp12.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener12.x + this.Iconlistener12.width / 2, _mc.getItemSetMc.y + this.Iconlistener12.y + this.Iconlistener12.height));
            this.StatusPopUp12.hide();
            this.Iconlistener12.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp12.show();
                return;
            }// end function
            );
            this.Iconlistener12.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp12.hide();
                return;
            }// end function
            );
            var StatusPopUpPos13:* = new Point(_mc.getItemSetMc.PopNull13.x, _mc.getItemSetMc.PopNull13.y);
            this.StatusPopUp13.setPosition(StatusPopUpPos13);
            this.StatusPopUp13.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener13.x + this.Iconlistener13.width / 2, _mc.getItemSetMc.y + this.Iconlistener13.y + this.Iconlistener13.height));
            this.StatusPopUp13.hide();
            this.Iconlistener13.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp13.show();
                return;
            }// end function
            );
            this.Iconlistener13.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp13.hide();
                return;
            }// end function
            );
            var StatusPopUpPos14:* = new Point(_mc.getItemSetMc.PopNull14.x, _mc.getItemSetMc.PopNull14.y);
            this.StatusPopUp14.setPosition(StatusPopUpPos14);
            this.StatusPopUp14.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener14.x + this.Iconlistener14.width / 2, _mc.getItemSetMc.y + this.Iconlistener14.y + this.Iconlistener14.height));
            this.StatusPopUp14.hide();
            this.Iconlistener14.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp14.show();
                return;
            }// end function
            );
            this.Iconlistener14.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp14.hide();
                return;
            }// end function
            );
            var StatusPopUpPos15:* = new Point(_mc.getItemSetMc.PopNull15.x, _mc.getItemSetMc.PopNull15.y);
            this.StatusPopUp15.setPosition(StatusPopUpPos15);
            this.StatusPopUp15.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener15.x + this.Iconlistener15.width / 2, _mc.getItemSetMc.y + this.Iconlistener15.y + this.Iconlistener15.height));
            this.StatusPopUp15.hide();
            this.Iconlistener15.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp15.show();
                return;
            }// end function
            );
            this.Iconlistener15.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp15.hide();
                return;
            }// end function
            );
            var StatusPopUpPos16:* = new Point(_mc.getItemSetMc.PopNull16.x, _mc.getItemSetMc.PopNull16.y);
            this.StatusPopUp16.setPosition(StatusPopUpPos16);
            this.StatusPopUp16.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener16.x + this.Iconlistener16.width / 2, _mc.getItemSetMc.y + this.Iconlistener16.y + this.Iconlistener16.height));
            this.StatusPopUp16.hide();
            this.Iconlistener16.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp16.show();
                return;
            }// end function
            );
            this.Iconlistener16.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp16.hide();
                return;
            }// end function
            );
            var StatusPopUpPos17:* = new Point(_mc.getItemSetMc.PopNull17.x, _mc.getItemSetMc.PopNull17.y);
            this.StatusPopUp17.setPosition(StatusPopUpPos17);
            this.StatusPopUp17.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener17.x + this.Iconlistener17.width / 2, _mc.getItemSetMc.y + this.Iconlistener17.y + this.Iconlistener17.height));
            this.StatusPopUp17.hide();
            this.Iconlistener17.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp17.show();
                return;
            }// end function
            );
            this.Iconlistener17.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp17.hide();
                return;
            }// end function
            );
            var StatusPopUpPos18:* = new Point(_mc.getItemSetMc.PopNull18.x, _mc.getItemSetMc.PopNull18.y);
            this.StatusPopUp18.setPosition(StatusPopUpPos18);
            this.StatusPopUp18.setArrowTargetPosition(new Point(_mc.getItemSetMc.x + this.Iconlistener18.x + this.Iconlistener18.width / 2, _mc.getItemSetMc.y + this.Iconlistener18.y + this.Iconlistener18.height));
            this.StatusPopUp18.hide();
            this.Iconlistener18.addEventListener(MouseEvent.MOUSE_OVER, function () : void
            {
                StatusPopUp18.show();
                return;
            }// end function
            );
            this.Iconlistener18.addEventListener(MouseEvent.MOUSE_OUT, function () : void
            {
                StatusPopUp18.hide();
                return;
            }// end function
            );
            return;
        }// end function

    }
}
