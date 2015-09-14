package questSelect
{
    import area.*;
    import flash.display.*;
    import flash.events.*;
    import message.*;
    import quest.*;
    import utility.*;

    public class AreaQuestListInformation extends Object
    {
        private var _LABEL_SELECT:String = "select";
        private var _LABEL_NOT_SELECT:String = "nomal";
        private var _LABEL_DISABLE:String = "disable";
        private var _aWeeklyLabel:Array;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _quest:AreaQuest;
        private var _waitTime:Number;
        private var _bInWait:Boolean;
        private var _bOutWait:Boolean;
        private var _bHit:Boolean;
        private var _bActive:Boolean;
        private var _bEnable:Boolean;
        private var _cbLineMouseOver:Function;
        private var _cbLineMouseOut:Function;
        private var _cbLineClick:Function;

        public function AreaQuestListInformation(param1:MovieClip, param2:Function, param3:Function, param4:Function)
        {
            this._aWeeklyLabel = ["weekly6", "weekly1", "weekly2", "weekly3", "weekly4", "weekly5", "weekly6"];
            this._mc = param1;
            this._cbLineMouseOver = param2;
            this._cbLineMouseOut = param3;
            this._cbLineClick = param4;
            this._bActive = false;
            this._isoMain = new InStayOut(this._mc);
            this._bEnable = true;
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get quest() : AreaQuest
        {
            return this._quest;
        }// end function

        public function isQuestFound() : Boolean
        {
            return this._quest != null;
        }// end function

        public function isSelect() : Boolean
        {
            var _loc_1:* = false;
            if (this._quest != null && this._quest.bSelect)
            {
                _loc_1 = true;
            }
            return _loc_1;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function get bInWait() : Boolean
        {
            return this._bInWait;
        }// end function

        public function get bOutWait() : Boolean
        {
            return this._bOutWait;
        }// end function

        public function get bHit() : Boolean
        {
            return this._bHit && this._bActive;
        }// end function

        public function get bEnable() : Boolean
        {
            return this._bEnable;
        }// end function

        public function set bEnable(param1:Boolean) : void
        {
            this._bEnable = param1;
            return;
        }// end function

        private function cbClick(event:MouseEvent) : void
        {
            var _loc_2:* = 0;
            if (this._bEnable == false)
            {
                return;
            }
            if (this._bActive == false)
            {
                return;
            }
            if (this._quest == null)
            {
                return;
            }
            if (this._cbLineClick != null)
            {
                this._cbLineClick(this._quest.no);
            }
            return;
        }// end function

        public function release() : void
        {
            this.setMouseOut();
            var _loc_1:* = this._mc.hitNullMc;
            if (_loc_1.hasEventListener(MouseEvent.CLICK))
            {
                _loc_1.removeEventListener(MouseEvent.CLICK, this.cbClick);
            }
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._quest == null)
            {
                return;
            }
            if (this._bActive)
            {
                _loc_2 = this._mc.hitNullMc;
                if (_loc_2.hitTestPoint(Main.GetProcess().stage.mouseX, Main.GetProcess().mouseY))
                {
                    this.setMouseOver();
                }
                else
                {
                    this.setMouseOut();
                }
            }
            if (this._bInWait || this._bOutWait)
            {
                this._waitTime = this._waitTime - param1;
                if (this._waitTime <= 0)
                {
                    this._waitTime = 0;
                    if (this._bInWait)
                    {
                        this._isoMain.setIn(this.cbIn);
                        this._bInWait = false;
                    }
                    if (this._bOutWait)
                    {
                        this._isoMain.setOut(this.cbOut);
                        this._bOutWait = false;
                    }
                }
            }
            return;
        }// end function

        public function setIn(param1:AreaQuest, param2:Number) : void
        {
            var _loc_18:* = null;
            this._quest = param1;
            this._waitTime = param2;
            var _loc_3:* = "";
            var _loc_4:* = "";
            var _loc_5:* = 0;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = false;
            var _loc_9:* = false;
            var _loc_10:* = false;
            var _loc_11:* = false;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = 1;
            if (this._quest != null)
            {
                _loc_3 = this._quest.questTitle;
                _loc_4 = "no:" + this._quest.no;
                _loc_5 = this._quest.questType;
                _loc_6 = this._quest.bNewQuest;
                _loc_7 = this._quest.bEasyQuest && this._quest.bStoryQuest == false;
                _loc_8 = this._quest.bStoryQuest;
                _loc_9 = this._quest.achievementRate != 0;
                _loc_12 = this._quest.achievementRate;
                _loc_10 = this._quest.bCurrentCycleClear;
                _loc_13 = this._quest.endTime;
                _loc_14 = this._quest.questLv;
                this._bInWait = true;
            }
            this._mc.questListMc.questLvStarMc.gotoAndStop(QuestSelectManager.getLabelNameQuestLv(this._quest));
            var _loc_15:* = QuestManager.questClearRankLabel(_loc_12, _loc_10);
            this._mc.questListMc.clearIconMc.gotoAndStop(_loc_15);
            var _loc_16:* = QuestConstant.AREA_QUEST_TYPE_NORMAL;
            var _loc_17:* = "";
            switch(_loc_5)
            {
                case CommonConstant.QUEST_TYPE_DAILY:
                {
                    _loc_16 = QuestConstant.AREA_QUEST_TYPE_WEEKLY;
                    _loc_18 = TimeClock.getNowTimeDate();
                    _loc_17 = this._aWeeklyLabel[int(_loc_18.getDay())];
                    break;
                }
                case CommonConstant.QUEST_TYPE_GUERRILLA:
                {
                    _loc_16 = QuestConstant.AREA_QUEST_TYPE_GUERRILLA;
                    _loc_17 = QuestConstant.AREA_QUEST_TYPE_GUERRILLA;
                    break;
                }
                case CommonConstant.QUEST_TYPE_CHALLENGE:
                {
                    _loc_16 = QuestConstant.AREA_QUEST_TYPE_DAILY;
                    _loc_17 = QuestConstant.AREA_QUEST_TYPE_DAILY;
                    break;
                }
                case CommonConstant.QUEST_TYPE_CAMPAIGN:
                {
                    _loc_16 = QuestConstant.AREA_QUEST_TYPE_CAMPAIGN;
                    _loc_17 = QuestConstant.AREA_QUEST_TYPE_CAMPAIGN;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (_loc_16 == QuestConstant.AREA_QUEST_TYPE_NORMAL || _loc_17 == "")
            {
                this._mc.dailyIconMc.visible = false;
                this._mc.questListMc.clearIconMc.visible = _loc_9;
            }
            else
            {
                this._mc.dailyIconMc.visible = true;
                this._mc.questListMc.clearIconMc.visible = _loc_9;
                this._mc.dailyIconMc.gotoAndStop(_loc_17);
            }
            this._mc.questListMc.questListMc.gotoAndStop(_loc_16);
            TextControl.setText(this._mc.questListMc.questTitleMc.textDt, _loc_3);
            if (this._mc.questListMc.questNumMc != null)
            {
                this._mc.questListMc.questNumMc.visible = false;
            }
            this._mc.newmarkMc.visible = _loc_6;
            this._mc.easymarkMc.visible = _loc_7;
            this._mc.storymarkMc.visible = _loc_8;
            var _loc_19:* = "";
            if (_loc_13 > 0)
            {
                _loc_19 = MessageManager.getInstance().getMessage(MessageId.AREA_QUEST_END_TIME);
                _loc_19 = _loc_19.replace("%d", this._quest.endTimeMsg);
            }
            TextControl.setText(this._mc.questListMc.questTimeMc.textDt, _loc_19);
            return;
        }// end function

        private function cbIn() : void
        {
            var _loc_1:* = this._mc.hitNullMc;
            if (_loc_1.hasEventListener(MouseEvent.CLICK) == false)
            {
                _loc_1.addEventListener(MouseEvent.CLICK, this.cbClick);
            }
            return;
        }// end function

        private function cbOut() : void
        {
            return;
        }// end function

        public function removeEvent() : void
        {
            var _loc_1:* = this._mc.hitNullMc;
            if (_loc_1.hasEventListener(MouseEvent.CLICK))
            {
                _loc_1.removeEventListener(MouseEvent.CLICK, this.cbClick);
            }
            return;
        }// end function

        public function setOut(param1:Number) : void
        {
            if (this._quest == null)
            {
                return;
            }
            this._waitTime = param1;
            this._bOutWait = true;
            this.setHitDisable();
            return;
        }// end function

        public function setEnd() : void
        {
            this._quest = null;
            this._isoMain.setEnd();
            return;
        }// end function

        public function setHitEnable() : void
        {
            this._bActive = true;
            return;
        }// end function

        public function setHitDisable() : void
        {
            this._bActive = false;
            this.setMouseOut();
            return;
        }// end function

        private function setMouseOver() : void
        {
            if (this._bEnable == false)
            {
                return;
            }
            if (this._bHit == false)
            {
                this._mc.questListMc.gotoAndStop(this._LABEL_SELECT);
                if (this._cbLineMouseOver != null && this._quest != null)
                {
                    this._cbLineMouseOver(this._quest.no);
                }
            }
            this._bHit = true;
            return;
        }// end function

        private function setMouseOut() : void
        {
            if (this._bEnable == false)
            {
                return;
            }
            if (this._bHit)
            {
                this._mc.questListMc.gotoAndStop(this._LABEL_NOT_SELECT);
                if (this._cbLineMouseOut != null && this._quest != null)
                {
                    this._cbLineMouseOut(this._quest.no);
                }
            }
            this._bHit = false;
            return;
        }// end function

        public function setMouseOverDisplay() : void
        {
            this._mc.questListMc.gotoAndStop(this._LABEL_SELECT);
            return;
        }// end function

        public function setMouseOutDisplay() : void
        {
            this._mc.questListMc.gotoAndStop(this._LABEL_NOT_SELECT);
            return;
        }// end function

        public function setEnable() : void
        {
            this._mc.questListMc.gotoAndStop(this._LABEL_NOT_SELECT);
            var _loc_1:* = this._mc.hitNullMc;
            if (_loc_1.hasEventListener(MouseEvent.CLICK) == false)
            {
                _loc_1.addEventListener(MouseEvent.CLICK, this.cbClick);
            }
            this._bActive = true;
            return;
        }// end function

        public function setDisable() : void
        {
            this._mc.questListMc.gotoAndStop(this._LABEL_DISABLE);
            var _loc_1:* = this._mc.hitNullMc;
            if (_loc_1.hasEventListener(MouseEvent.CLICK))
            {
                _loc_1.removeEventListener(MouseEvent.CLICK, this.cbClick);
            }
            this._bActive = false;
            return;
        }// end function

    }
}
