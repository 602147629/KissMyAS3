package history
{
    import button.*;
    import correlation.*;
    import develop.*;
    import flash.display.*;
    import home.*;
    import layer.*;
    import message.*;
    import network.*;
    import player.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class HistoryMain extends Object
    {
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;
        private var _isoMainMc:InStayOut;
        private var _cbOpenEmperor:Function;
        private var _cbCloseEmperor:Function;
        private var _emperor:Emperor;
        private var _closeBtn:ButtonBase;
        private var _chronologyList:HistoryList;
        private var _historyList:HistoryList;
        private var _chronologyRecord:HistoryRecord;
        private var _selectInfomation:HistoryInfomation;
        private var _aChronology:Array;
        private var _aHistory:Array;
        private var _aButton:Array;
        private var _aUpdatePlayerUniqueId:Array;
        private var _phase:int;
        private var _nextPhase:int;
        private var _selectType:int;
        private var _tabLabel:String;
        private static const PHASE_WAIT:int = 0;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_CLOSE:int = 2;
        private static const PHASE_CHRONOLOGY:int = 10;
        private static const PHASE_HISTORY:int = 11;
        private static const PHASE_CHARACTER_LOADING:int = 20;
        private static const PHASE_DISPLAY_QUEST:int = 30;
        private static const PHASE_EQUIPMENT_CHANGE:int = 90;
        private static const PHASE_END:int = 99;
        private static const TAB_CHRONOLOGY:int = 1;
        private static const TAB_HISTORY:int = 2;
        private static const TAB_STATUS_CHRONOLOGY:String = "chronologicalOn";
        private static const TAB_STATUS_HISTORY:String = "historyOn";

        public function HistoryMain(param1:LayerHome, param2:Emperor, param3:Function, param4:Function)
        {
            this._layer = param1;
            this._emperor = param2;
            this._cbCloseEmperor = param4;
            this._cbOpenEmperor = param3;
            this.init();
            NetManager.getInstance().request(new NetTaskChronology(this.cbReceive));
            return;
        }// end function

        public function release() : void
        {
            this.removeTabButton();
            this._aButton = null;
            if (this._closeBtn)
            {
                ButtonManager.getInstance().removeButton(this._closeBtn);
            }
            this._closeBtn = null;
            if (this._chronologyList)
            {
                this._chronologyList.release();
            }
            this._chronologyList = null;
            if (this._historyList)
            {
                this._historyList.release();
            }
            this._historyList = null;
            if (this._chronologyRecord)
            {
                this._chronologyRecord.release();
            }
            this._chronologyRecord = null;
            if (this._isoMainMc)
            {
                this._isoMainMc.release();
            }
            this._isoMainMc = null;
            if (this._baseMc && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
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
                case PHASE_CHRONOLOGY:
                {
                    this.controlChronology();
                    break;
                }
                case PHASE_HISTORY:
                {
                    this.controlHistory();
                    break;
                }
                case PHASE_CHARACTER_LOADING:
                {
                    this.controlCharacterLoading();
                    break;
                }
                case PHASE_DISPLAY_QUEST:
                {
                    this.controlDisplayQuest(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._emperor)
            {
                this._emperor.control();
            }
            if (this._chronologyList)
            {
                this._chronologyList.control(param1);
            }
            if (this._historyList)
            {
                this._historyList.control(param1);
            }
            return;
        }// end function

        public function get bOpened() : Boolean
        {
            return this._phase != PHASE_OPEN && this._phase != PHASE_CLOSE && (this._isoMainMc == null || this._isoMainMc && this._isoMainMc.bOpened);
        }// end function

        public function get bEnd() : Boolean
        {
            return this._phase == PHASE_END;
        }// end function

        private function init() : void
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.HOME_PATH + "UI_Chronology.swf", "chronologicalMainMc");
            this._isoMainMc = new InStayOut(this._baseMc);
            this._layer.getLayer(LayerHome.MAIN).addChild(this._baseMc);
            this._aButton = [];
            this._aUpdatePlayerUniqueId = [];
            var _loc_1:* = new ButtonBase(this._baseMc.chronologicalTableMc.chronoTabMc, this.cbTabChange);
            _loc_1.setId(TAB_CHRONOLOGY);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_1);
            _loc_1 = new ButtonBase(this._baseMc.chronologicalTableMc.histoTabMc, this.cbTabChange);
            _loc_1.setId(TAB_HISTORY);
            _loc_1.enterSeId = ButtonBase.SE_CURSOR_ID;
            this._aButton.push(_loc_1);
            this._closeBtn = ButtonManager.getInstance().addButton(this._baseMc.returnBtnMc, this.cbCloseButton);
            this._closeBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            TextControl.setIdText(this._baseMc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this.btnEnable(false);
            this._tabLabel = TAB_STATUS_CHRONOLOGY;
            this._baseMc.chronologicalTableMc.gotoAndStop(this._tabLabel);
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                this._nextPhase = Constant.UNDECIDED;
                switch(this._phase)
                {
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
                    case PHASE_CHRONOLOGY:
                    {
                        this.phaseChronology();
                        break;
                    }
                    case PHASE_HISTORY:
                    {
                        this.phaseHistory();
                        break;
                    }
                    case PHASE_CHARACTER_LOADING:
                    {
                        this.phaseCharacterLoading();
                        break;
                    }
                    case PHASE_DISPLAY_QUEST:
                    {
                        this.phaseDisplayQuest();
                        break;
                    }
                    case PHASE_EQUIPMENT_CHANGE:
                    {
                        this.phaseEquipmentChange();
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
            this._chronologyList = new HistoryList(this._baseMc.chronologicalTableMc.chronologicalSetMc, this._aChronology, this.cbBarClick);
            this._historyList = new HistoryList(this._baseMc.chronologicalTableMc.historySetMc, this._aHistory, this.cbBarClick);
            this._isoMainMc.setIn();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoMainMc.bOpened)
            {
                this.setPhase(PHASE_CHRONOLOGY);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoMainMc.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoMainMc.bEnd)
            {
                if (this._aUpdatePlayerUniqueId.length == 0)
                {
                    this.setPhase(PHASE_END);
                }
                else
                {
                    this.setPhase(PHASE_EQUIPMENT_CHANGE);
                }
            }
            return;
        }// end function

        private function phaseChronology() : void
        {
            this.removeTabButton();
            this.addTabButton();
            this._chronologyList.removeButton();
            this._chronologyList.addButton();
            this._historyList.removeButton();
            this.btnEnable(true);
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_CHRONOLOGY))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MYPAGE_CHRONOLOGY);
            }
            return;
        }// end function

        private function controlChronology() : void
        {
            return;
        }// end function

        private function phaseHistory() : void
        {
            this.removeTabButton();
            this.addTabButton();
            this._historyList.removeButton();
            this._historyList.addButton();
            this._chronologyList.removeButton();
            this.btnEnable(true);
            return;
        }// end function

        private function controlHistory() : void
        {
            return;
        }// end function

        private function phaseCharacterLoading() : void
        {
            this.removeTabButton();
            this._chronologyList.removeButton();
            this._historyList.removeButton();
            this.btnEnable(false);
            return;
        }// end function

        private function controlCharacterLoading() : void
        {
            if (ResourceManager.getInstance().isLoaded())
            {
                this.setPhase(PHASE_DISPLAY_QUEST);
            }
            return;
        }// end function

        private function phaseDisplayQuest() : void
        {
            this._chronologyRecord = new HistoryRecord(this._layer, this._selectInfomation, this._selectType, this.cbCloseStatus);
            this._chronologyList.removeButton();
            this._historyList.removeButton();
            if (this._selectType == HistoryList.TYPE_NOW_CYCLE)
            {
                this._nextPhase = PHASE_CHRONOLOGY;
            }
            if (this._selectType == HistoryList.TYPE_PAST_CYCLE)
            {
                this._emperor.close();
                this._nextPhase = PHASE_HISTORY;
            }
            return;
        }// end function

        private function controlDisplayQuest(param1:Number) : void
        {
            if (this._chronologyRecord)
            {
                this._chronologyRecord.control(param1);
                if (this._chronologyRecord.bEnd)
                {
                    this._chronologyRecord.release();
                    this._chronologyRecord = null;
                    if (this._nextPhase == Constant.UNDECIDED)
                    {
                        DebugLog.print("リスト表示中以外でクエスト詳細が呼ばれています");
                        return;
                    }
                    if (this._selectType == HistoryList.TYPE_PAST_CYCLE)
                    {
                        this._emperor.open();
                    }
                }
            }
            else if (this._emperor.bOpend)
            {
                this.setPhase(this._nextPhase);
            }
            return;
        }// end function

        private function phaseEquipmentChange() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_1:* = [];
            var _loc_2:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            for each (_loc_3 in this._aUpdatePlayerUniqueId)
            {
                
                _loc_4 = new Object();
                for each (_loc_5 in _loc_2)
                {
                    
                    if (_loc_5.uniqueId == _loc_3)
                    {
                        _loc_4.uniqueId = _loc_3;
                        _loc_4.aSkill = _loc_5.aSetSkillId;
                        _loc_4.aItem = _loc_5.aSetItemId;
                        break;
                    }
                }
                _loc_1.push(_loc_4);
            }
            NetManager.getInstance().request(new NetTaskEquipmentChange(_loc_1, this.cbReceiveEquipmentChange));
            return;
        }// end function

        private function addTabButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().addButtonBase(_loc_1);
            }
            return;
        }// end function

        private function removeTabButton() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeArray(_loc_1);
            }
            return;
        }// end function

        private function cbReceive(param1:NetResult) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aChronology = [];
            this._aHistory = [];
            for each (_loc_2 in param1.data.aChronology)
            {
                
                _loc_3 = new HistoryInfomation();
                _loc_3.setParameter(_loc_2);
                this._aChronology.push(_loc_3);
            }
            this._aChronology.sortOn("year", Array.NUMERIC);
            for each (_loc_2 in param1.data.aHistory)
            {
                
                _loc_3 = new HistoryInfomation();
                _loc_3.setParameter(_loc_2);
                this._aHistory.push(_loc_3);
            }
            this._aHistory.sortOn("questId", Array.NUMERIC);
            this.setPhase(PHASE_OPEN);
            return;
        }// end function

        private function cbReceiveEquipmentChange(param1:NetResult) : void
        {
            this.setPhase(PHASE_END);
            return;
        }// end function

        private function cbBarClick(param1:HistoryInfomation, param2:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (param1 != null)
            {
                this._selectType = param2;
                this._selectInfomation = param1;
                for each (_loc_4 in this._selectInfomation.aParty)
                {
                    
                    if (_loc_4 != null)
                    {
                        ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_4.swf);
                        ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_4.bustUpFileName);
                        _loc_3 = PlayerManager.getInstance().getPlayerInformation(_loc_4.playerId);
                        for each (_loc_5 in _loc_3.aDiagramCharaId)
                        {
                            
                            if (_loc_5 == 0)
                            {
                                continue;
                            }
                            _loc_6 = UserDataManager.getInstance().userData.getCorrelationInfo(_loc_5);
                            _loc_7 = "";
                            if (_loc_6 != null)
                            {
                                _loc_7 = _loc_6.swf;
                            }
                            else
                            {
                                _loc_8 = PlayerManager.getInstance().getPlayerInformationByCharacterId(_loc_5);
                                _loc_7 = _loc_8.swf;
                            }
                            ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_7);
                        }
                    }
                }
                ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
                ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Correlation.swf");
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(this._selectInfomation.emperorId);
                if (_loc_3 != null)
                {
                    ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf);
                    ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
                }
                this.setPhase(PHASE_CHARACTER_LOADING);
            }
            return;
        }// end function

        private function cbCloseStatus(param1:int) : void
        {
            if (this._aUpdatePlayerUniqueId.indexOf(param1) == -1)
            {
                this._aUpdatePlayerUniqueId.push(param1);
            }
            return;
        }// end function

        private function cbCloseButton(param1:int) : void
        {
            if (this._phase != PHASE_CLOSE)
            {
                this._chronologyList.removeButton();
                this._historyList.removeButton();
                this.btnEnable(false);
                this.setPhase(PHASE_CLOSE);
            }
            return;
        }// end function

        private function cbTabChange(param1:int) : void
        {
            var _loc_2:* = null;
            this._nextPhase = PHASE_WAIT;
            if (param1 == TAB_CHRONOLOGY)
            {
                this._tabLabel = TAB_STATUS_CHRONOLOGY;
                this._nextPhase = PHASE_CHRONOLOGY;
            }
            if (param1 == TAB_HISTORY)
            {
                this._tabLabel = TAB_STATUS_HISTORY;
                this._nextPhase = PHASE_HISTORY;
            }
            if (this._nextPhase == PHASE_WAIT)
            {
                Assert.print("タブの切り替え失敗");
            }
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setMouseOut();
            }
            this._baseMc.chronologicalTableMc.gotoAndStop(this._tabLabel);
            this.setPhase(this._nextPhase);
            return;
        }// end function

        private function btnEnable(param1:Boolean) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = !param1;
            this._closeBtn.setDisable(_loc_2);
            for each (_loc_3 in this._aButton)
            {
                
                if (_loc_3)
                {
                    _loc_3.setDisableFlag(_loc_2);
                }
            }
            return;
        }// end function

    }
}
