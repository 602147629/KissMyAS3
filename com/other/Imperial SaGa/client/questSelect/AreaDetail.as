package questSelect
{
    import area.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import message.*;
    import quest.*;
    import utility.*;

    public class AreaDetail extends Object
    {
        private var _aWeeklyLabel:Array;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _questInfoMc:MovieClip;
        private var _isoQuestInfo:InStayOut;
        private var _questNameMc:MovieClip;
        private var _isoQuestName:InStayOut;
        private var _aBmp:Object;
        private var _timer:Timer;
        private var _displayIndex:int;
        private var _aAreaInfo:Array;
        private var _aQuestInfo:Array;
        private var _aQuestListMc:Array;
        private var _aQuestInfoLampMc:Array;

        public function AreaDetail(param1:MovieClip, param2:Array)
        {
            this._aWeeklyLabel = ["weekly6", "weekly1", "weekly2", "weekly3", "weekly4", "weekly5", "weekly6"];
            this._mc = param1;
            this._questNameMc = this._mc.areaDetailMoveMc.questName2Mc;
            this._questInfoMc = this._mc.areaDetailMoveMc.areaDetailMc;
            this._aAreaInfo = param2;
            this._isoMain = new InStayOut(this._mc);
            this._isoQuestName = new InStayOut(this._questNameMc);
            this._isoQuestInfo = new InStayOut(this._questInfoMc);
            this._aQuestInfo = [];
            this._aQuestListMc = [param1.areaDetailMoveMc.areaDetailMc.questListMc.quest01, param1.areaDetailMoveMc.areaDetailMc.questListMc.quest02, param1.areaDetailMoveMc.areaDetailMc.questListMc.quest03, param1.areaDetailMoveMc.areaDetailMc.questListMc.quest04];
            this._aQuestInfoLampMc = [this._questInfoMc.InfoPageMc.infoPage_Lamp1Mc, this._questInfoMc.InfoPageMc.infoPage_Lamp2Mc, this._questInfoMc.InfoPageMc.infoPage_Lamp3Mc, this._questInfoMc.InfoPageMc.infoPage_Lamp4Mc];
            TextControl.setIdText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText1.nameTextMc.textDt, MessageId.AREA_DETAIL_QUEST_COUNT);
            TextControl.setIdText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText2.nameTextMc.textDt, MessageId.AREA_DETAIL_QUEST_CLEAR_COUNT);
            TextControl.setIdText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText3.nameTextMc.textDt, MessageId.AREA_DETAIL_QUEST_COMPLETE_COUNT);
            TextControl.setIdText(this._mc.areaDetailMoveMc.areaDetailMc.questListTitleMc.textDt, MessageId.AREA_DETAIL_QUEST);
            this.setDisplayNotSelect();
            return;
        }// end function

        public function isOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function isClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function release() : void
        {
            this._aBmp = null;
            if (this._timer)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimerComplete);
            }
            this._timer = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoQuestName)
            {
                this._isoQuestName.release();
            }
            this._isoQuestName = null;
            if (this._isoQuestInfo)
            {
                this._isoQuestInfo.release();
            }
            this._isoQuestInfo = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            if (this._questNameMc && this._questNameMc.parent)
            {
                this._questNameMc.parent.removeChild(this._questNameMc);
            }
            this._questNameMc = null;
            if (this._questInfoMc && this._questInfoMc.parent)
            {
                this._questInfoMc.parent.removeChild(this._questInfoMc);
            }
            this._questInfoMc = null;
            return;
        }// end function

        public function setIn() : void
        {
            this._isoMain.setIn();
            this._isoQuestInfo.setIn();
            return;
        }// end function

        public function setOut() : void
        {
            this._isoMain.setOut();
            this._isoQuestInfo.setOut();
            return;
        }// end function

        public function setDisplayNotSelect() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aQuestInfoLampMc)
            {
                
                _loc_1.gotoAndStop("off");
            }
            this._questInfoMc.InfoPageMc.visible = false;
            this._aQuestInfo = [];
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.citynameTextMc.textDt, "-");
            TextControl.setIdText(this._mc.areaDetailMoveMc.areaDetailMc.questListMc.noquestTextMc.textDt, MessageId.AREA_DETAIL_NO_QUEST);
            TextControl.setText(this._questNameMc.textMc.textDt, "");
            TextControl.setText(this._questInfoMc.cityDescriptionTextMc.textDt, "");
            this.clearQuestBar();
            this._mc.areaDetailMoveMc.areaDetailMc.questListMc.gotoAndStop("no");
            if (this._timer)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimerComplete);
            }
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText1.numTextMc.textDt, "-");
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText2.numTextMc.textDt, "-");
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText3.numTextMc.textDt, "-");
            return;
        }// end function

        public function setDisplayArea(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_15:* = null;
            var _loc_2:* = null;
            for each (_loc_3 in this._aAreaInfo)
            {
                
                if (_loc_3.areaId == param1)
                {
                    _loc_2 = _loc_3;
                    break;
                }
            }
            if (_loc_2 == null)
            {
                throw new Error("無効なエリアIDです");
            }
            var _loc_4:* = AreaManager.getInstance().getArea(_loc_2.areaId);
            if (AreaManager.getInstance().getArea(_loc_2.areaId) == null)
            {
                throw new Error("エリア情報が見つかりません");
            }
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.citynameTextMc.textDt, _loc_4.name);
            for each (_loc_5 in this._aQuestInfoLampMc)
            {
                
                _loc_5.gotoAndStop("off");
            }
            _loc_6 = AreaQuestSort.sortAreaQuest(_loc_2.aQuest, AreaQuestSort.getInstance().sortId, param1);
            _loc_7 = _loc_6.length == 4 ? (4) : (3);
            this._aQuestInfo = [];
            for each (_loc_8 in _loc_6)
            {
                
                if (this._aQuestInfo.length < _loc_7)
                {
                    this._aQuestInfo.push(_loc_8);
                    continue;
                }
                break;
            }
            if (this._aQuestInfo.length > 0)
            {
                this._questInfoMc.InfoPageMc.gotoAndStop("infoPage" + this._aQuestInfo.length);
                _loc_5 = this._aQuestInfoLampMc[0];
                _loc_5.gotoAndStop("on");
                this._questInfoMc.InfoPageMc.visible = true;
            }
            else
            {
                this._questInfoMc.InfoPageMc.visible = false;
            }
            var _loc_9:* = "no";
            var _loc_14:* = "";
            if (_loc_6.length == 0)
            {
                this.clearQuestBar();
                _loc_9 = "no";
            }
            if (_loc_6.length >= 1 && _loc_6.length <= 4)
            {
                _loc_10 = 0;
                while (_loc_10 < this._aQuestListMc.length)
                {
                    
                    this.setQuestBar(_loc_10, _loc_6);
                    _loc_10++;
                }
                _loc_9 = "4set";
            }
            if (_loc_6.length >= 5)
            {
                _loc_10 = 0;
                while (_loc_10 < 3)
                {
                    
                    this.setQuestBar(_loc_10, _loc_6);
                    _loc_10++;
                }
                _loc_9 = "5set";
            }
            this._mc.areaDetailMoveMc.areaDetailMc.questListMc.gotoAndStop(_loc_9);
            this._displayIndex = 0;
            var _loc_16:* = this._aQuestInfo[this._displayIndex];
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText1.numTextMc.textDt, _loc_2.questCount.toString());
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText2.numTextMc.textDt, _loc_2.questClearCount.toString());
            TextControl.setText(this._mc.areaDetailMoveMc.areaDetailMc.questNumText3.numTextMc.textDt, _loc_2.questCompleteCount.toString());
            if (_loc_16 != null)
            {
                TextControl.setText(this._questNameMc.textMc.textDt, _loc_16.questTitle);
                TextControl.setText(this._questInfoMc.cityDescriptionTextMc.textDt, _loc_16.explanation);
            }
            else
            {
                TextControl.setText(this._questNameMc.textMc.textDt, "");
                TextControl.setText(this._questInfoMc.cityDescriptionTextMc.textDt, "");
            }
            this._isoQuestInfo.setIn(this.cbSetIn);
            this._isoQuestName.setIn();
            return;
        }// end function

        private function clearQuestBar() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < this._aQuestListMc.length)
            {
                
                _loc_2 = this._aQuestListMc[_loc_1];
                _loc_2.newmarkMc.visible = false;
                _loc_2.dailyIconMc.visible = false;
                _loc_2.clearIconMc.visible = false;
                _loc_2.questLvStarMc.visible = false;
                _loc_2.eventwakuMc.gotoAndStop(QuestConstant.AREA_QUEST_TYPE_NORMAL);
                TextControl.setText(_loc_2.textMc.textDt, "");
                _loc_1++;
            }
            return;
        }// end function

        private function setQuestBar(param1:int, param2:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_3:* = this._aQuestListMc[param1];
            _loc_5 = "";
            if (param1 < param2.length)
            {
                _loc_4 = param2[param1];
                _loc_5 = _loc_4.questTitle;
                _loc_6 = "";
                _loc_3.newmarkMc.visible = _loc_4.bNewQuest;
                switch(_loc_4.questType)
                {
                    case CommonConstant.QUEST_TYPE_DAILY:
                    {
                        _loc_9 = TimeClock.getNowTimeDate();
                        _loc_6 = this._aWeeklyLabel[int(_loc_9.getDay())];
                        break;
                    }
                    case CommonConstant.QUEST_TYPE_GUERRILLA:
                    {
                        _loc_6 = QuestConstant.AREA_QUEST_TYPE_GUERRILLA;
                        break;
                    }
                    case CommonConstant.QUEST_TYPE_CHALLENGE:
                    {
                        _loc_6 = QuestConstant.AREA_QUEST_TYPE_DAILY;
                        break;
                    }
                    case CommonConstant.QUEST_TYPE_CAMPAIGN:
                    {
                        _loc_6 = QuestConstant.AREA_QUEST_TYPE_CAMPAIGN;
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                if (_loc_6 == "")
                {
                    _loc_3.dailyIconMc.visible = false;
                    _loc_3.eventwakuMc.gotoAndStop(QuestConstant.AREA_QUEST_TYPE_NORMAL);
                }
                else
                {
                    _loc_3.dailyIconMc.visible = true;
                    _loc_3.dailyIconMc.gotoAndStop(_loc_6);
                    _loc_3.eventwakuMc.gotoAndStop(QuestConstant.AREA_QUEST_TYPE_DAILY);
                }
                _loc_7 = QuestManager.questClearRankLabel(_loc_4.achievementRate, _loc_4.bCurrentCycleClear);
                _loc_3.clearIconMc.gotoAndStop(_loc_7);
                _loc_3.clearIconMc.visible = _loc_4.achievementRate != 0;
                _loc_8 = _loc_4.questLv;
                _loc_3.questLvStarMc.gotoAndStop(QuestSelectManager.getLabelNameQuestLv(_loc_4));
                _loc_3.questLvStarMc.visible = true;
                _loc_3.visible = true;
            }
            else
            {
                _loc_3.visible = false;
            }
            TextControl.setText(_loc_3.textMc.textDt, _loc_5);
            return;
        }// end function

        private function cbSetIn() : void
        {
            if (this._timer != null)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimerComplete);
            }
            if (this._aQuestInfo.length == 0)
            {
                return;
            }
            if (this._aQuestInfo.length > 1)
            {
                this._timer = new Timer(2500, 1);
                this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimerComplete);
                this._timer.start();
            }
            return;
        }// end function

        private function cbTimerComplete(event:TimerEvent) : void
        {
            if (this._timer)
            {
                this._timer.stop();
                this._timer.reset();
                this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.cbTimerComplete);
            }
            if (this._aQuestInfo.length > 1)
            {
                if (this._isoQuestInfo)
                {
                    this._isoQuestInfo.setOut(this.cbSetOut);
                }
                if (this._isoQuestName)
                {
                    this._isoQuestName.setOut();
                }
            }
            return;
        }// end function

        private function cbSetOut() : void
        {
            var _loc_1:* = this._aQuestInfoLampMc[this._displayIndex];
            if (_loc_1 != null)
            {
                _loc_1.gotoAndStop("off");
            }
            var _loc_3:* = this;
            var _loc_4:* = this._displayIndex + 1;
            _loc_3._displayIndex = _loc_4;
            if (this._aQuestInfo.length <= this._displayIndex)
            {
                this._displayIndex = 0;
            }
            _loc_1 = this._aQuestInfoLampMc[this._displayIndex];
            if (_loc_1 != null)
            {
                _loc_1.gotoAndStop("on");
            }
            var _loc_2:* = this._aQuestInfo[this._displayIndex];
            if (_loc_2 != null)
            {
                TextControl.setText(this._questNameMc.textMc.textDt, _loc_2.questTitle);
                TextControl.setText(this._questInfoMc.cityDescriptionTextMc.textDt, _loc_2.explanation);
            }
            else
            {
                TextControl.setText(this._questNameMc.textMc.textDt, "");
                TextControl.setText(this._questInfoMc.cityDescriptionTextMc.textDt, "");
            }
            this._isoQuestInfo.setIn(this.cbSetIn);
            this._isoQuestName.setIn();
            return;
        }// end function

    }
}
