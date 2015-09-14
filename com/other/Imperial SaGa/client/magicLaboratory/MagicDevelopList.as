package magicLaboratory
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import home.*;
    import input.*;
    import message.*;
    import status.*;
    import tutorial.*;
    import user.*;
    import window.*;

    public class MagicDevelopList extends MagicDevelopBase
    {
        private var _aSortText:Array;
        private var _SORT_KEY_SKILL_ID:String = "skillId";
        private var _SORT_KEY_SKILL_NAME:String = "skillName";
        private var _SORT_KEY_SKILL_DEVELOP_LV:String = "skillDevelopLevel";
        private var _SORT_KEY_SKILL_TYPE:String = "skillType";
        private var _SORT_KEY_SKILL_IS_DEVELOPED:String = "isDeveloped";
        private var _btnPage:PageButton;
        private var _aMagicPlate:Array;
        private var _aMagicList:Array;
        private var _aMagicDispList:Array;
        private var _btnSort:ButtonBase;
        private var _sortWindow:WindowMenu;
        private var _skillSimpleStatus:SkillSimpleStatus;
        private var _overSkillId:int;
        private static const _SORT_MAGIC_ID:int = 0;
        private static const _SORT_MAGIC_NAME:int = 1;
        public static const SORT_MAGIC_ALL:int = 0;
        public static const SORT_MAGIC_FIRE:int = 1;
        public static const SORT_MAGIC_WATER:int = 2;
        public static const SORT_MAGIC_EARTH:int = 3;
        public static const SORT_MAGIC_WIND:int = 4;
        public static const SORT_MAGIC_LIGHT:int = 5;
        public static const SORT_MAGIC_HADES:int = 6;

        public function MagicDevelopList(param1:MovieClip)
        {
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            this._aSortText = [MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_FILTER_MAGIC_ALL), MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_FILTER_MAGIC_FIRE), MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_FILTER_MAGIC_WATER), MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_FILTER_MAGIC_EARTH), MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_FILTER_MAGIC_WIND), MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_FILTER_MAGIC_LIGHT), MessageManager.getInstance().getMessage(MessageId.MAGIC_DEVELOP_FILTER_MAGIC_ABYSS)];
            super(param1, true);
            var _loc_2:* = _mc.reserveListMc.skillNull1.y;
            var _loc_3:* = _mc.reserveListMc.BalloonAmbitLeftNull;
            var _loc_4:* = _mc.reserveListMc.BalloonAmbitRightNull;
            this._aMagicPlate = [new MagicPlate(_mc.reserveListMc.skillNull1, _loc_4, _mc.reserveListMc.skillNull1.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull2, _loc_3, _mc.reserveListMc.skillNull2.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull3, _loc_4, _mc.reserveListMc.skillNull3.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull4, _loc_3, _mc.reserveListMc.skillNull4.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull5, _loc_4, _mc.reserveListMc.skillNull5.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull6, _loc_3, _mc.reserveListMc.skillNull6.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull7, _loc_4, _mc.reserveListMc.skillNull7.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull8, _loc_3, _mc.reserveListMc.skillNull8.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull9, _loc_4, _mc.reserveListMc.skillNull9.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull10, _loc_3, _mc.reserveListMc.skillNull10.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull11, _loc_4, _mc.reserveListMc.skillNull11.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull12, _loc_3, _mc.reserveListMc.skillNull12.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull13, _loc_4, _mc.reserveListMc.skillNull13.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull14, _loc_3, _mc.reserveListMc.skillNull14.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull15, _loc_4, _mc.reserveListMc.skillNull15.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate), new MagicPlate(_mc.reserveListMc.skillNull16, _loc_3, _mc.reserveListMc.skillNull16.y - _loc_2, this.cbMouseOverPlate, this.cbMouseOutPlate)];
            this._aMagicList = [];
            for each (_loc_5 in MagicLabolatoryManager.getInstance().aLearningSkillId)
            {
                
                _loc_6 = new MagicListData(_loc_5, true, false);
                this._aMagicList.push(_loc_6);
            }
            for each (_loc_5 in MagicLabolatoryManager.getInstance().aDevelopSkillId)
            {
                
                if (MagicLabolatoryManager.getInstance().aLearningSkillId.indexOf(_loc_5) != -1)
                {
                    continue;
                }
                _loc_6 = new MagicListData(_loc_5, false, false);
                this._aMagicList.push(_loc_6);
            }
            for each (_loc_5 in MagicLabolatoryManager.getInstance().aImpossibleSkillId)
            {
                
                if (MagicLabolatoryManager.getInstance().aLearningSkillId.indexOf(_loc_5) != -1)
                {
                    continue;
                }
                _loc_6 = new MagicListData(_loc_5, false, true);
                this._aMagicList.push(_loc_6);
            }
            this._btnPage = new PageButton(_mc.reserveListMc.pageBtnSetGuidMc, this.cbChangePage, 0, Math.ceil(this._aMagicList.length / this._aMagicPlate.length));
            TextControl.setIdText(_mc.reserveListMc.listTitleMc.textDt, MessageId.MAGIC_DEVELOP_LIST_TITLE);
            _loc_7 = _SORT_MAGIC_ID;
            this._btnSort = ButtonManager.getInstance().addButton(_mc.reserveListMc.sortBtnMc, this.cbSortClick, _loc_7);
            this._btnSort.enterSeId = ButtonBase.SE_CURSOR_ID;
            TextControl.setIdText(_mc.reserveListMc.sortBtnMc.textMc.textDt, MessageId.MAGIC_DEVELOP_FILTER_BUTTON);
            this.setSort(_loc_7);
            this._skillSimpleStatus = new SkillSimpleStatus(_mc.parent, null, false);
            this._skillSimpleStatus.hide();
            this._overSkillId = Constant.EMPTY_ID;
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick);
            return;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            if (this._skillSimpleStatus)
            {
                this._skillSimpleStatus.release();
            }
            this._skillSimpleStatus = null;
            if (this._btnSort)
            {
                ButtonManager.getInstance().removeButton(this._btnSort);
            }
            this._btnSort = null;
            if (this._btnPage)
            {
                this._btnPage.release();
            }
            this._btnPage = null;
            for each (_loc_1 in this._aMagicPlate)
            {
                
                _loc_1.release();
            }
            this._aMagicPlate = [];
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            return;
        }// end function

        public function setDeveloped(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aMagicList)
            {
                
                if (_loc_2.skillId == param1)
                {
                    _loc_2.isDeveloped = true;
                    this.setSort(this._btnSort.id);
                    break;
                }
            }
            return;
        }// end function

        public function setSortText(param1:int) : void
        {
            TextControl.setText(_mc.reserveListMc.sortTextMc.textDt, this._aSortText[param1]);
            return;
        }// end function

        public function cbSortClick(param1:int) : void
        {
            ButtonManager.getInstance().push();
            var _loc_2:* = [new WindowTextButton(this._aSortText[SORT_MAGIC_ALL], this.cbSortSelect, SORT_MAGIC_ALL), new WindowTextButton(this._aSortText[SORT_MAGIC_FIRE], this.cbSortSelect, SORT_MAGIC_FIRE), new WindowTextButton(this._aSortText[SORT_MAGIC_WATER], this.cbSortSelect, SORT_MAGIC_WATER), new WindowTextButton(this._aSortText[SORT_MAGIC_EARTH], this.cbSortSelect, SORT_MAGIC_EARTH), new WindowTextButton(this._aSortText[SORT_MAGIC_WIND], this.cbSortSelect, SORT_MAGIC_WIND), new WindowTextButton(this._aSortText[SORT_MAGIC_LIGHT], this.cbSortSelect, SORT_MAGIC_LIGHT), new WindowTextButton(this._aSortText[SORT_MAGIC_HADES], this.cbSortSelect, SORT_MAGIC_HADES)];
            var _loc_3:* = new Point(_mc.reserveListMc.sortTextMc.x, _mc.reserveListMc.sortTextMc.y + 25);
            this._sortWindow = WindowManager.getInstance().createMenuWindow(_mc.reserveListMc, _loc_2, new WindowStyle(), _loc_3);
            return;
        }// end function

        private function cbSortSelect(param1:int) : void
        {
            this.removeSortWindow();
            this._btnSort.setId(param1);
            this.setSort(param1);
            return;
        }// end function

        private function setSort(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            this.setSortText(param1);
            this._aMagicDispList = [];
            var _loc_2:* = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAGIC_DEVELOP);
            for each (_loc_3 in this._aMagicList)
            {
                
                if (_loc_3.skillDevelopLevel > _loc_2.grade)
                {
                    continue;
                }
                if (param1 == SORT_MAGIC_ALL || _loc_3.skillType == param1)
                {
                    this._aMagicDispList.push(_loc_3);
                }
            }
            this._aMagicDispList.sortOn([this._SORT_KEY_SKILL_TYPE, this._SORT_KEY_SKILL_DEVELOP_LV, this._SORT_KEY_SKILL_ID, this._SORT_KEY_SKILL_IS_DEVELOPED], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC, Array.NUMERIC | Array.DESCENDING]);
            _loc_4 = Math.ceil(this._aMagicDispList.length / this._aMagicPlate.length);
            _loc_5 = Math.min(this._btnPage.pageIndex, (_loc_4 - 1));
            this._btnPage.setPage(Math.max(0, _loc_5), _loc_4);
            this.setPage(this._btnPage.pageIndex);
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._sortWindow == null)
            {
                return;
            }
            if (this._sortWindow.bOpened && this._sortWindow.hitTestPoint(event.stageX, event.stageY) == false)
            {
                this.removeSortWindow();
            }
            return;
        }// end function

        private function removeSortWindow() : void
        {
            if (this._sortWindow)
            {
                WindowManager.getInstance().removeWindow(this._sortWindow);
                this._sortWindow = null;
                ButtonManager.getInstance().pop();
            }
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : void
        {
            this.setPage(param1);
            this._btnPage.update();
            return;
        }// end function

        private function cbMouseOverPlate(param1:int) : void
        {
            if (MagicLabolatoryManager.getInstance().aLearningSkillId.indexOf(param1) == -1)
            {
                this.setSkillExplanation(Constant.EMPTY_ID);
            }
            else
            {
                this.setSkillExplanation(param1);
            }
            return;
        }// end function

        private function cbMouseOutPlate(param1:int) : void
        {
            if (this._skillSimpleStatus.isShow() && this._overSkillId == param1)
            {
                this._skillSimpleStatus.hide();
                this._overSkillId = Constant.EMPTY_ID;
            }
            return;
        }// end function

        private function setSkillExplanation(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (this._overSkillId != param1)
            {
                this._overSkillId = param1;
                _loc_2 = this.searchPlate(this._overSkillId);
                if (_loc_2 != null)
                {
                    this._skillSimpleStatus.setSkillData(this._overSkillId);
                    _loc_3 = _loc_2.balloonAmbitNull;
                    _loc_4 = new Point(_loc_3.x, _loc_3.y + _loc_2.ambitOffs);
                    _loc_4 = _loc_3.parent.localToGlobal(_loc_4);
                    this._skillSimpleStatus.setPosition(_loc_4);
                    _loc_3 = _loc_2.balloonNull;
                    _loc_5 = new Point(_loc_3.x, _loc_3.y);
                    _loc_5 = _loc_3.parent.localToGlobal(_loc_5);
                    this._skillSimpleStatus.setArrowTargetPosition(_loc_5);
                    this._skillSimpleStatus.show();
                }
                else if (this._skillSimpleStatus.isShow())
                {
                    this._skillSimpleStatus.hide();
                }
            }
            return;
        }// end function

        private function searchPlate(param1:int) : MagicPlate
        {
            var _loc_2:* = null;
            if (param1 != Constant.EMPTY_ID)
            {
                for each (_loc_2 in this._aMagicPlate)
                {
                    
                    if (_loc_2.skillId == param1)
                    {
                        return _loc_2;
                    }
                }
            }
            return null;
        }// end function

        private function setPage(param1:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_2:* = param1 * this._aMagicPlate.length;
            _loc_3 = _loc_3;
            while (_loc_3 < this._aMagicPlate.length)
            {
                
                _loc_4 = this._aMagicPlate[_loc_3];
                if (_loc_2 + _loc_3 >= 0 && _loc_2 + _loc_3 < this._aMagicDispList.length)
                {
                    _loc_5 = this._aMagicDispList[_loc_2 + _loc_3];
                    _loc_6 = MagicLabolatoryManager.getInstance().aLearningSkillId.indexOf(_loc_5.skillId) != -1;
                    _loc_7 = MagicLabolatoryManager.getInstance().aImpossibleSkillId.indexOf(_loc_5.skillId) != -1;
                    _loc_4.setSkillId(_loc_5.skillId, _loc_6, _loc_7);
                }
                else
                {
                    _loc_4.setSkillId(Constant.EMPTY_ID, false, false);
                }
                _loc_3++;
            }
            return;
        }// end function

        public function updateList(param1:int) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aMagicList)
            {
                
                if (_loc_2.skillId == param1)
                {
                    _loc_2.isDeveloped = true;
                    this.setSort(this._btnSort.id);
                    break;
                }
            }
            return;
        }// end function

        override protected function cbMainIn() : void
        {
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP))
            {
                TutorialManager.getInstance().facilityTutorialPopup(TutorialManager.FACILITY_TUTORIAL_FLAG_MAGIC_LABO_DEVELOP);
            }
            return;
        }// end function

        public function setButtonEnable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            this._btnPage.btnEnable(param1);
            this._btnSort.setDisable(!param1);
            InputManager.getInstance().enableMouseCallback(this, param1);
            for each (_loc_2 in this._aMagicPlate)
            {
                
                _loc_2.setDisable(!param1);
            }
            if (!param1)
            {
                if (this._skillSimpleStatus.isShow())
                {
                    this._skillSimpleStatus.hide();
                }
                this._overSkillId = Constant.EMPTY_ID;
            }
            return;
        }// end function

        override public function setButtonDisable() : void
        {
            super.setButtonDisable();
            this.setButtonEnable(false);
            return;
        }// end function

    }
}
