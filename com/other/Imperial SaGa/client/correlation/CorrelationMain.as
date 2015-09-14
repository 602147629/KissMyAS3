package correlation
{
    import balloon.*;
    import button.*;
    import character.*;
    import develop.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import player.*;
    import resource.*;
    import sound.*;
    import user.*;
    import utility.*;

    public class CorrelationMain extends Object
    {
        private var _phase:int;
        private var _parent:DisplayObjectContainer;
        private var _baseMc:MovieClip;
        private var _isoMc:InStayOut;
        private var _scrollMc:MovieClip;
        private var _displayArea:MovieClip;
        private var _playerInfo:PlayerInformation;
        private var _aFileNullMc:Array;
        private var _aSuccessiveEmperorCharaFaceData:Array;
        private var _aCharaNullMc:Array;
        private var _aDisplayCharaNullMc:Array;
        private var _aDisplayImgName:Array;
        private var _aPlayerInfomation:Array;
        private var _aDisplayPlayerId:Array;
        private var _aButton:Array;
        private var _aBalloon:Array;
        private var _aScrollBtn:Array;
        private var _targetPos:Point;
        private var _scrollTopMax:Number;
        private var _scrollBottomMax:Number;
        private var _scrollLeftMax:Number;
        private var _scrollRightMax:Number;
        private var _scrollTopBtn:ButtonBase;
        private var _scrollBottomBtn:ButtonBase;
        private var _scrollLeftBtn:ButtonBase;
        private var _scrollRightBtn:ButtonBase;
        private var _scrollInputDrag:InputDrag;
        private var _posScrollDragBase:Point;
        private var _bDragInit:Boolean;
        private var _bScroll:Boolean;
        private var _bPushBtn:Boolean;
        private var _posLeftTop:Point;
        private var _posRightBottom:Point;
        private var _playerList:CorrelationPlayerList;
        private var _selectCharacterId:int;
        private var _closeBtn:ButtonBase;
        private var _cbClose:Function;
        private static var _NULL_EMPEROR_MC_NAME:String = "faceNullEmperor";
        private static var PHASE_RESOURCE_LOAD:int = 1;
        private static var PHASE_SET_CHARACTER:int = 2;
        private static var PHASE_OPEN:int = 3;
        private static var PHASE_CLOSE:int = 4;
        private static var PHASE_MAIN:int = 10;
        private static var PHASE_PLAYER_LIST_LOAD:int = 20;
        private static var PHASE_PLAYER_LIST:int = 21;
        private static var PHASE_END:int = 99;
        private static var BUTTON_SCROLL_TOP:int = 1;
        private static var BUTTON_SCROLL_BOTTOM:int = 2;
        private static var BUTTON_SCROLL_LEFT:int = 3;
        private static var BUTTON_SCROLL_RIGHT:int = 4;
        private static const SCROLL_VALUE:Number = 10;

        public function CorrelationMain(param1:DisplayObjectContainer, param2:int, param3:Function, param4:Function)
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            this._parent = param1;
            this._cbClose = param4;
            this._playerInfo = PlayerManager.getInstance().getPlayerInformation(param2);
            this._aFileNullMc = [];
            this._aSuccessiveEmperorCharaFaceData = [];
            this._aCharaNullMc = [];
            this._aDisplayCharaNullMc = [];
            this._aDisplayImgName = [];
            this._aPlayerInfomation = [];
            this._aDisplayPlayerId = [];
            this._aButton = [];
            this._aBalloon = [];
            this._aScrollBtn = [];
            this._targetPos = new Point();
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Correlation.swf", "CorrelationMainMc");
            this._isoMc = new InStayOut(this._baseMc);
            this._scrollMc = this._baseMc.correlationMainMc.correlationLayoutMc;
            this._displayArea = this._baseMc.correlationMainMc.displayArea;
            param1.addChild(this._baseMc);
            this._posLeftTop = new Point(this._scrollMc.x, this._scrollMc.y);
            this._scrollTopMax = 0;
            this._scrollBottomMax = 0;
            this._scrollLeftMax = 0;
            this._scrollRightMax = 0;
            this._bScroll = false;
            this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.closeBtnMc, this.cbCloseButton);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._baseMc.closeBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_CLOSE);
            var _loc_5:* = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Correlation.swf", "CharaListPopupMc");
            this._playerList = new CorrelationPlayerList(this._parent, _loc_5, [], this.cbCloseCharacterList);
            this._selectCharacterId = Constant.EMPTY_ID;
            if (this._playerInfo == null)
            {
                Assert.print("CorrelationMain にて　戦士情報の取得に失敗しました.");
                return;
            }
            if (this._playerInfo.diagramName == "" || this._playerInfo.diagramName == "Dummy" || this._playerInfo.diagramFileName == "" || this._playerInfo.diagramFileName == "Dummy")
            {
                DebugLog.print("ダミーや未設定のキャラクターが選ばれたのでスルーします。");
                this._cbClose();
                this.setPhase(PHASE_END);
                return;
            }
            var _loc_6:* = ResourceManager.getInstance().createMovieClip(ResourcePath.CORRELATION_SHEET_PATH + this._playerInfo.diagramFileName, this._playerInfo.diagramName);
            this._scrollMc.addChild(_loc_6);
            this.setScrollMax(_loc_6);
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6.numChildren)
            {
                
                _loc_8 = _loc_6.getChildAt(_loc_7) as MovieClip;
                if (_loc_8.name.indexOf("fileNull") >= 0)
                {
                    this._aFileNullMc.push(_loc_8);
                }
                else if (_loc_8.name.indexOf("Icon") >= 0)
                {
                    this.addBalloon(_loc_8);
                }
                else if (_loc_8.name.indexOf("faceNull") < 0)
                {
                }
                else
                {
                    _loc_9 = null;
                    _loc_10 = null;
                    _loc_11 = null;
                    if (_loc_8.name.indexOf(_NULL_EMPEROR_MC_NAME) >= 0)
                    {
                        _loc_14 = _loc_8.name.replace(_NULL_EMPEROR_MC_NAME + "0", "");
                        _loc_15 = int(_loc_14) - 1;
                        _loc_16 = UserDataManager.getInstance().userData;
                        _loc_17 = new CorrelationCharaFaceData();
                        if (_loc_15 >= _loc_16.aSuccessiveEmperorId.length)
                        {
                            _loc_17.mc = _loc_8;
                            _loc_17.fileName = ResourcePath.PLAYER_CORRELATION_PATH + "ID_CORRELATION_EMPERORNULL.png";
                            _loc_17.bBlackOut = false;
                        }
                        else
                        {
                            param2 = _loc_16.aSuccessiveEmperorId[_loc_15];
                            _loc_11 = PlayerManager.getInstance().getPlayerInformation(param2);
                            if (_loc_11 == null)
                            {
                                this.errorMessageNotFoundCharactor(param2);
                            }
                            _loc_17.charaId = _loc_11.characterId;
                            _loc_17.playerId = param2;
                            _loc_17.bBlackOut = false;
                            _loc_17.mc = _loc_8;
                            _loc_17.pInfo = _loc_11;
                            _loc_17.fileName = ResourcePath.PLAYER_CORRELATION_PATH + _loc_11.correlationFileName;
                        }
                        _loc_9 = _loc_6.getChildByName("charaEmperor0" + _loc_14 + "BtnMc") as MovieClip;
                        _loc_10 = new CorrelationCharacterButton(_loc_9, this.cbSelectCharacter, _loc_17.charaId);
                        ButtonManager.getInstance().addButtonBase(_loc_10);
                        _loc_10.setDisableFlag(true);
                        this._aSuccessiveEmperorCharaFaceData.push(_loc_17);
                        this._aButton.push(_loc_10);
                    }
                    else
                    {
                        _loc_12 = _loc_8.name.replace("faceNull", "");
                        _loc_9 = _loc_6.getChildByName("chara" + _loc_12 + "BtnMc") as MovieClip;
                        if (_loc_12 == "" || _loc_9 == null)
                        {
                        }
                        else
                        {
                            _loc_13 = UserDataManager.getInstance().userData.getCorrelationInfo(int(_loc_12));
                            _loc_10 = new CorrelationCharacterButton(_loc_9, this.cbSelectCharacter, parseInt(_loc_12));
                            ButtonManager.getInstance().addButtonBase(_loc_10);
                            if (_loc_13 == null)
                            {
                                _loc_10.setDisable(true);
                            }
                            else
                            {
                                _loc_10.setDisableFlag(true);
                            }
                            this._aButton.push(_loc_10);
                            this._aCharaNullMc.push(_loc_8);
                        }
                    }
                }
                _loc_7++;
            }
            this._scrollTopBtn = ButtonManager.getInstance().addPushButton(this._baseMc.correlationMainMc.scrollBtnTMc, BUTTON_SCROLL_TOP);
            this._aScrollBtn.push(this._scrollTopBtn);
            this._scrollBottomBtn = ButtonManager.getInstance().addPushButton(this._baseMc.correlationMainMc.scrollBtnBMc, BUTTON_SCROLL_BOTTOM);
            this._aScrollBtn.push(this._scrollBottomBtn);
            this._scrollLeftBtn = ButtonManager.getInstance().addPushButton(this._baseMc.correlationMainMc.scrollBtnLMc, BUTTON_SCROLL_LEFT);
            this._aScrollBtn.push(this._scrollLeftBtn);
            this._scrollRightBtn = ButtonManager.getInstance().addPushButton(this._baseMc.correlationMainMc.scrollBtnRMc, BUTTON_SCROLL_RIGHT);
            this._aScrollBtn.push(this._scrollRightBtn);
            this._scrollInputDrag = new InputDrag(this, this._baseMc.correlationMainMc, this.cbDrag, this.cbMove, this.cbDrop);
            this._scrollInputDrag.addMaskObject(Main.GetProcess().topBar.getMc());
            InputManager.getInstance().addDrag(this._scrollInputDrag);
            this._scrollTopBtn.enterSeId = Constant.UNDECIDED;
            this._scrollBottomBtn.enterSeId = Constant.UNDECIDED;
            this._scrollLeftBtn.enterSeId = Constant.UNDECIDED;
            this._scrollRightBtn.enterSeId = Constant.UNDECIDED;
            this._scrollTopBtn.overSeId = Constant.UNDECIDED;
            this._scrollBottomBtn.overSeId = Constant.UNDECIDED;
            this._scrollLeftBtn.overSeId = Constant.UNDECIDED;
            this._scrollRightBtn.overSeId = Constant.UNDECIDED;
            this.setDisableScroll(false);
            this.setPhase(PHASE_RESOURCE_LOAD);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            this._aDisplayImgName = [];
            this._aPlayerInfomation = [];
            this._aDisplayPlayerId = [];
            for each (_loc_1 in this._aBalloon)
            {
                
                BalloonManager.getInstance().removeBalloon(_loc_1);
            }
            this._aBalloon = [];
            for each (_loc_2 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_2);
            }
            this._aButton = [];
            for each (_loc_3 in this._aSuccessiveEmperorCharaFaceData)
            {
                
                if (_loc_3)
                {
                    if (_loc_3.mc)
                    {
                        if (_loc_3.mc.numChildren > 0)
                        {
                            _loc_3.mc.removeChildren();
                        }
                    }
                    _loc_3.release();
                }
            }
            this._aSuccessiveEmperorCharaFaceData = [];
            if (this._scrollInputDrag)
            {
                InputManager.getInstance().delDrag(this._scrollInputDrag);
                this._scrollInputDrag.release();
                this._scrollInputDrag = null;
            }
            this._posScrollDragBase = null;
            for each (_loc_4 in this._aScrollBtn)
            {
                
                ButtonManager.getInstance().removeButton(_loc_4);
            }
            this._aScrollBtn = [];
            for each (_loc_5 in this._aCharaNullMc)
            {
                
                if (_loc_5.numChildren > 0)
                {
                    _loc_5.removeChildren();
                }
            }
            this._aCharaNullMc = null;
            for each (_loc_6 in this._aFileNullMc)
            {
                
                if (_loc_6.numChildren > 0)
                {
                    _loc_6.removeChildren();
                }
            }
            this._aFileNullMc = null;
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            this._closeBtn = null;
            if (this._playerList)
            {
                this._playerList.release();
            }
            this._playerList = null;
            if (this._isoMc)
            {
                this._isoMc.release();
            }
            this._isoMc = null;
            if (this._baseMc && this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            switch(this._phase)
            {
                case PHASE_RESOURCE_LOAD:
                {
                    this.controlResourceLoad();
                    break;
                }
                case PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                case PHASE_MAIN:
                {
                    this.controlMain();
                    break;
                }
                case PHASE_PLAYER_LIST_LOAD:
                {
                    this.controlPlayerListLoad();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._playerList)
            {
                this._playerList.control(param1);
            }
            this._bPushBtn = false;
            for each (_loc_2 in this._aScrollBtn)
            {
                
                if (_loc_2.bPush)
                {
                    this.cbScrollButton(_loc_2.id);
                }
            }
            if (this._bPushBtn == false && this._bScroll)
            {
                this._bScroll = false;
                this.checkDisableIconButton();
            }
            return;
        }// end function

        public function close() : void
        {
            this.setPhase(PHASE_CLOSE);
            return;
        }// end function

        public function get isOpen() : Boolean
        {
            return this._phase == PHASE_MAIN;
        }// end function

        public function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_RESOURCE_LOAD:
                    {
                        this.phaseResourceLoad();
                        break;
                    }
                    case PHASE_SET_CHARACTER:
                    {
                        this.phaseSetCharacter();
                        break;
                    }
                    case PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case PHASE_MAIN:
                    {
                        this.phaseMain();
                        break;
                    }
                    case PHASE_PLAYER_LIST_LOAD:
                    {
                        this.phasePlayerListLoad();
                        break;
                    }
                    case PHASE_PLAYER_LIST:
                    {
                        this.phasePlayerList();
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

        private function phaseResourceLoad() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            this._aDisplayCharaNullMc = [];
            for each (_loc_1 in this._aCharaNullMc)
            {
                
                _loc_5 = _loc_1.localToGlobal(new Point());
                this._aDisplayCharaNullMc.push(_loc_1);
            }
            CorrelationPlayerList.loadResource();
            for each (_loc_2 in this._aDisplayCharaNullMc)
            {
                
                if (_loc_2.name.indexOf("faceNull") < 0)
                {
                    continue;
                }
                _loc_6 = _loc_2.name.replace("faceNull", "");
                _loc_7 = parseInt(_loc_6);
                if (this._aDisplayPlayerId.indexOf(_loc_7) >= 0)
                {
                    DebugLog.print("すでに読み込み済みなのでスルー(エラーではありません)");
                    continue;
                }
                _loc_8 = UserDataManager.getInstance().userData.getCorrelationInfo(_loc_7);
                _loc_9 = [];
                _loc_10 = null;
                if (_loc_8 == null)
                {
                    DebugLog.print("ID:" + _loc_7.toString() + "はサーバから送られていない戦士情報");
                    _loc_10 = PlayerManager.getInstance().getPlayerInformationByCharacterId(_loc_7);
                }
                else
                {
                    DebugLog.print("ID:" + _loc_7.toString() + "の戦士情報を取得");
                    _loc_10 = PlayerManager.getInstance().getPlayerInformation(_loc_8.playerId);
                }
                if (_loc_10 == null)
                {
                    this.errorMessageNotFoundCharactor(_loc_8.playerId);
                    continue;
                }
                _loc_9 = UserDataManager.getInstance().userData.getCorrelationList(_loc_7);
                _loc_11 = ResourcePath.PLAYER_CORRELATION_PATH + _loc_10.correlationFileName;
                ResourceManager.getInstance().loadResource(_loc_11);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_10.swf);
                ResourceManager.getInstance().loadResource(_loc_11);
                this._aPlayerInfomation.push(_loc_10);
                this._aDisplayPlayerId.push(_loc_10.characterId);
                _loc_12 = new Object();
                _loc_12.id = _loc_10.characterId;
                _loc_12.fileName = _loc_11;
                _loc_12.bBlackOut = _loc_9.length == 0 && _loc_8 == null;
                this._aDisplayImgName.push(_loc_12);
            }
            for each (_loc_3 in this._aFileNullMc)
            {
                
                _loc_13 = this.getFileNullFileName(_loc_3);
                ResourceManager.getInstance().loadResource(_loc_13);
            }
            for each (_loc_4 in this._aSuccessiveEmperorCharaFaceData)
            {
                
                if (_loc_4 != null)
                {
                    if (_loc_4.pInfo != null)
                    {
                        this._aPlayerInfomation.push(_loc_4.pInfo);
                        ResourceManager.getInstance().loadResource(_loc_4.fileName);
                        ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_4.pInfo.swf);
                        continue;
                    }
                    ResourceManager.getInstance().loadResource(_loc_4.fileName);
                }
            }
            SoundManager.getInstance().loadSoundArray([SoundId.SE_CHARA_SELECT]);
            return;
        }// end function

        private function controlResourceLoad() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(PHASE_SET_CHARACTER);
            }
            return;
        }// end function

        private function phaseSetCharacter() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            for each (_loc_1 in this._aDisplayCharaNullMc)
            {
                
                if (_loc_1.name.indexOf("faceNull") < 0)
                {
                    continue;
                }
                _loc_4 = _loc_1.name.replace("faceNull", "");
                _loc_5 = parseInt(_loc_4);
                for each (_loc_6 in this._aDisplayImgName)
                {
                    
                    if (_loc_6.id == _loc_5)
                    {
                        this.createBitmap(_loc_1, _loc_6.fileName, _loc_6.bBlackOut);
                        if (this._playerInfo.characterId == _loc_6.id)
                        {
                            this._scrollMc.x = this._scrollMc.x - (_loc_1.x + _loc_1.width / 2 - this._displayArea.width / 2);
                            if (this._scrollMc.x < this._scrollRightMax)
                            {
                                this._scrollMc.x = this._scrollRightMax;
                            }
                            if (this._scrollMc.x > this._scrollLeftMax)
                            {
                                this._scrollMc.x = this._scrollLeftMax;
                            }
                            this._scrollMc.y = this._scrollMc.y - (_loc_1.y + _loc_1.height / 2 - this._displayArea.height / 2);
                            if (this._scrollMc.y < this._scrollBottomMax)
                            {
                                this._scrollMc.y = this._scrollBottomMax;
                            }
                            if (this._scrollMc.y > this._scrollTopMax)
                            {
                                this._scrollMc.y = this._scrollTopMax;
                            }
                        }
                        break;
                    }
                }
            }
            for each (_loc_2 in this._aFileNullMc)
            {
                
                _loc_7 = this.getFileNullFileName(_loc_2);
                this.createBitmap(_loc_2, _loc_7, false);
            }
            for each (_loc_3 in this._aSuccessiveEmperorCharaFaceData)
            {
                
                this.createBitmap(_loc_3.mc, _loc_3.fileName, _loc_3.bBlackOut);
            }
            this.setPhase(PHASE_OPEN);
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoMc.setIn();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMc.bOpened)
            {
                this.setPhase(PHASE_MAIN);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            if (this._playerList)
            {
                this._playerList.close();
            }
            this._isoMc.setOut(this._cbClose);
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoMc.bEnd)
            {
                this.setPhase(PHASE_END);
            }
            return;
        }// end function

        private function phaseMain() : void
        {
            this._bScroll = false;
            this.setDisableScroll(false);
            this.checkDisableIconButton();
            return;
        }// end function

        private function controlMain() : void
        {
            return;
        }// end function

        private function phasePlayerListLoad() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = UserDataManager.getInstance().userData.getCorrelationList(this._selectCharacterId);
            for each (_loc_2 in _loc_1)
            {
                
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(_loc_2.playerId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
            }
            return;
        }// end function

        private function controlPlayerListLoad() : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                this.setPhase(PHASE_PLAYER_LIST);
            }
            return;
        }// end function

        private function phasePlayerList() : void
        {
            this._playerList.open(this._selectCharacterId);
            return;
        }// end function

        private function getFileNullFileName(param1:MovieClip) : String
        {
            return ResourcePath.PLAYER_CORRELATION_PATH + CharacterConstant.ID_CORRELATION + param1.name.replace("fileNull", "") + ".png";
        }// end function

        private function createBitmap(param1:MovieClip, param2:String, param3:Boolean) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = ResourceManager.getInstance().createBitmap(param2);
            if (ResourceManager.getInstance().createBitmap(param2) == null)
            {
                return;
            }
            _loc_4.smoothing = true;
            if (param3 == true)
            {
                _loc_5 = _loc_4.transform.colorTransform;
                _loc_5.redMultiplier = 0.5;
                _loc_5.greenMultiplier = 0.5;
                _loc_5.blueMultiplier = 0.5;
                _loc_4.transform.colorTransform = _loc_5;
            }
            param1.addChild(_loc_4);
            return;
        }// end function

        private function addBalloon(param1:MovieClip) : void
        {
            var _loc_2:* = param1.name.replace("Icon", "");
            var _loc_3:* = MessageManager.getInstance().getMessage(MessageId["RELATE_" + _loc_2]);
            var _loc_4:* = new BalloonNormal(this._parent, param1, param1.balloonNullMc, _loc_3);
            BalloonManager.getInstance().addBalloon(_loc_4);
            this._aBalloon.push(_loc_4);
            return;
        }// end function

        private function setDisableScroll(param1:Boolean) : void
        {
            if (this._scrollMc.y >= this._scrollTopMax)
            {
                this._scrollTopBtn.setDisable(true);
            }
            else
            {
                this._scrollTopBtn.setDisable(param1);
            }
            if (this._scrollMc.y <= this._scrollBottomMax)
            {
                this._scrollBottomBtn.setDisable(true);
            }
            else
            {
                this._scrollBottomBtn.setDisable(param1);
            }
            if (this._scrollMc.x >= this._scrollLeftMax)
            {
                this._scrollLeftBtn.setDisable(true);
            }
            else
            {
                this._scrollLeftBtn.setDisable(param1);
            }
            if (this._scrollMc.x <= this._scrollRightMax)
            {
                this._scrollRightBtn.setDisable(true);
            }
            else
            {
                this._scrollRightBtn.setDisable(param1);
            }
            this._scrollInputDrag.enable(!param1);
            return;
        }// end function

        private function setScrollMax(param1:MovieClip) : void
        {
            if (this._scrollTopMax > param1.y)
            {
                this._scrollTopMax = param1.y;
            }
            if (this._scrollLeftMax > param1.x)
            {
                this._scrollLeftMax = param1.x;
            }
            if (this._scrollBottomMax + this._displayArea.height < param1.y + param1.height)
            {
                this._scrollBottomMax = this._displayArea.height - (param1.y + param1.height);
            }
            if (this._scrollRightMax + this._displayArea.width < param1.x + param1.width)
            {
                this._scrollRightMax = this._displayArea.width - (param1.x + param1.width);
            }
            return;
        }// end function

        private function setDisableIconButton() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                _loc_1.setDisableFlag(true);
            }
            for each (_loc_2 in this._aBalloon)
            {
                
                _loc_2.setMouseOver(false);
                _loc_2.bEnable = false;
            }
            return;
        }// end function

        private function checkDisableIconButton() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_1:* = new Point((this._scrollMc.x > 0 ? (this._scrollMc.x) : (-this._scrollMc.x)) + this._posLeftTop.x, (this._scrollMc.y > 0 ? (this._scrollMc.y) : (-this._scrollMc.y)) + this._posLeftTop.y);
            var _loc_2:* = new Point(_loc_1.x + this._displayArea.width, _loc_1.y + this._displayArea.height);
            for each (_loc_3 in this._aButton)
            {
                
                _loc_5 = UserDataManager.getInstance().userData.getCorrelationInfo(_loc_3.id);
                _loc_6 = UserDataManager.getInstance().userData.getCorrelationList(_loc_3.id);
                if (_loc_5 == null || _loc_6.length == 0)
                {
                    continue;
                }
                _loc_7 = _loc_3.getMoveClip();
                if (_loc_7 != null && (_loc_7.x > _loc_1.x && _loc_7.y > _loc_1.y) && _loc_7.x + _loc_7.width < _loc_2.x && _loc_7.y + _loc_7.height < _loc_2.y)
                {
                    _loc_3.setDisableFlag(false);
                    continue;
                }
                _loc_3.setDisableFlag(true);
            }
            for each (_loc_4 in this._aBalloon)
            {
                
                _loc_8 = _loc_4.getHitObject();
                if (_loc_8 != null && (_loc_8.x > _loc_1.x && _loc_8.y > _loc_1.y) && _loc_8.x + _loc_8.width < _loc_2.x && _loc_8.y + _loc_8.height < _loc_2.y)
                {
                    _loc_4.bEnable = true;
                    if (_loc_4.bMouseOver)
                    {
                        _loc_4.control(0);
                    }
                    continue;
                }
                _loc_4.bEnable = false;
                _loc_4.setMouseOver(false);
            }
            return;
        }// end function

        private function cbSelectCharacter(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_3 in this._aPlayerInfomation)
            {
                
                if (_loc_3.characterId == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            if (_loc_2 == null)
            {
                return;
            }
            this._closeBtn.setDisableFlag(true);
            this.setDisableIconButton();
            this.setDisableScroll(true);
            this._selectCharacterId = _loc_2.characterId;
            this.setPhase(PHASE_PLAYER_LIST_LOAD);
            return;
        }// end function

        private function cbCloseCharacterList() : void
        {
            this._selectCharacterId = Constant.EMPTY_ID;
            this._closeBtn.setDisableFlag(false);
            this.setPhase(PHASE_MAIN);
            return;
        }// end function

        private function cbScrollButton(param1:int) : void
        {
            switch(param1)
            {
                case BUTTON_SCROLL_TOP:
                {
                    if (this._scrollMc.y < this._scrollTopMax)
                    {
                        this._scrollMc.y = this._scrollMc.y + SCROLL_VALUE;
                    }
                    break;
                }
                case BUTTON_SCROLL_BOTTOM:
                {
                    if (this._scrollMc.y > this._scrollBottomMax)
                    {
                        this._scrollMc.y = this._scrollMc.y - SCROLL_VALUE;
                    }
                    break;
                }
                case BUTTON_SCROLL_LEFT:
                {
                    if (this._scrollMc.x < this._scrollLeftMax)
                    {
                        this._scrollMc.x = this._scrollMc.x + SCROLL_VALUE;
                    }
                    break;
                }
                case BUTTON_SCROLL_RIGHT:
                {
                    if (this._scrollMc.x > this._scrollRightMax)
                    {
                        this._scrollMc.x = this._scrollMc.x - SCROLL_VALUE;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._bScroll = true;
            this._bPushBtn = true;
            this.checkDisableIconButton();
            this.setDisableScroll(false);
            return;
        }// end function

        private function cbDrag(event:MouseEvent) : void
        {
            this._posScrollDragBase = new Point(this._scrollMc.x, this._scrollMc.y);
            this._bDragInit = false;
            return;
        }// end function

        private function cbMove(event:MouseEvent) : void
        {
            var _loc_2:* = new Point(event.stageX - this._scrollInputDrag.startPos.x, event.stageY - this._scrollInputDrag.startPos.y);
            this._scrollMc.x = this._posScrollDragBase.x + _loc_2.x;
            this._scrollMc.y = this._posScrollDragBase.y + _loc_2.y;
            if (this._scrollMc.y > this._scrollTopMax)
            {
                this._scrollMc.y = this._scrollTopMax;
            }
            if (this._scrollMc.y < this._scrollBottomMax)
            {
                this._scrollMc.y = this._scrollBottomMax;
            }
            if (this._scrollMc.x > this._scrollLeftMax)
            {
                this._scrollMc.x = this._scrollLeftMax;
            }
            if (this._scrollMc.x < this._scrollRightMax)
            {
                this._scrollMc.x = this._scrollRightMax;
            }
            if (!this._bDragInit)
            {
                this._bDragInit = true;
                this.setDisableIconButton();
            }
            this.setDisableScroll(false);
            return;
        }// end function

        private function cbDrop(event:MouseEvent) : void
        {
            this.checkDisableIconButton();
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            this.setPhase(PHASE_CLOSE);
            return;
        }// end function

        private function errorMessageNotFoundCharactor(param1:int) : void
        {
            var _loc_2:* = "存在しないキャラクターを取得しようとしました。ID:" + param1;
            DebugLog.print(_loc_2);
            Assert.print(_loc_2);
            return;
        }// end function

    }
}
