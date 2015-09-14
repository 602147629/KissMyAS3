package skillInitiate
{
    import button.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import player.*;
    import playerList.*;
    import status.*;
    import user.*;
    import window.*;

    public class SICharacterList extends PlayerListBase
    {
        private const _A_FILTER_TEXT:Array;
        private var _aFilterId:Array;
        private var _filterWindowMenu:WindowMenu;
        private var _filterButton:ButtonBase;
        private var _siManager:SkillInitiateManager;
        private var _cbRemainPlayerNum:Function;
        private var _overlay:Shape;
        private var _filterId:int;

        public function SICharacterList(param1:MovieClip, param2:SkillInitiateManager)
        {
            var _loc_5:* = null;
            this._A_FILTER_TEXT = ["すべて", MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_SMALL_SWORD), MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_SWORD), MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_LARGE_SWORD), MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_SPEAR), MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_AX), MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_STICK), MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_GRAPPLE), MessageManager.getInstance().getMessage(MessageId.WEAPON_TYPE_BOW)];
            this._aFilterId = [Constant.EMPTY_ID, CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD, CommonConstant.CHARACTER_WEAPONTYPE_SWORD, CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD, CommonConstant.CHARACTER_WEAPONTYPE_SPEAR, CommonConstant.CHARACTER_WEAPONTYPE_AX, CommonConstant.CHARACTER_WEAPONTYPE_CLUB, CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS, CommonConstant.CHARACTER_WEAPONTYPE_BOW];
            var _loc_3:* = [];
            var _loc_4:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            for each (_loc_5 in _loc_4)
            {
                
                _loc_3.push(new ListPlayerData(_loc_5));
            }
            this._siManager = param2;
            super(param1, _loc_3);
            this._filterButton = ButtonManager.getInstance().addButton(param1.filterBtnMc, this.cbOpenFilterWindow);
            this._filterButton.enterSeId = ButtonBase.SE_CURSOR_ID;
            TextControl.setIdText(param1.reserveListTitleMc.textDt, MessageId.CORRELATION_TITLE);
            TextControl.setIdText(param1.filterBtnMc.textMc.textDt, MessageId.SKILL_INITIATE_BUTTON_FILTER);
            this.cbFilterSelect(Constant.EMPTY_ID);
            this.updateList();
            this._cbRemainPlayerNum = null;
            this._overlay = new Shape();
            this._overlay.graphics.beginFill(4473924);
            this._overlay.graphics.drawRect(0, 0, 486, 456);
            this._overlay.graphics.endFill();
            this._overlay.alpha = 0.5;
            _mcBase.addChild(this._overlay);
            this._overlay.visible = false;
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick);
            return;
        }// end function

        override public function release() : void
        {
            this._siManager = null;
            if (this._filterButton)
            {
                ButtonManager.getInstance().removeButton(this._filterButton);
            }
            super.release();
            this._cbRemainPlayerNum = null;
            return;
        }// end function

        public function resetCharacterList() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = [];
            var _loc_2:* = UserDataManager.getInstance().userData.aPlayerPersonal;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1.push(new ListPlayerData(_loc_3));
            }
            this.setPlayerList(_loc_1);
            return;
        }// end function

        public function overlayVisible(param1:Boolean) : void
        {
            this._overlay.visible = param1;
            return;
        }// end function

        override public function setSelectEnable(param1:Boolean) : void
        {
            super.setSelectEnable(param1);
            this._filterButton.setDisable(!param1);
            return;
        }// end function

        public function setListData(param1:Array) : void
        {
            var _loc_2:* = this.createListData(param1);
            this.setPlayerList(_loc_2);
            this.filterCharacter();
            this._page.setPage(0, _page.pageMax);
            this.updateList();
            return;
        }// end function

        override protected function onSelectPlayer(param1:int, param2:ListPlayerDisplay, param3:ListPlayerDisplay) : void
        {
            var _loc_4:* = 0;
            if (this._siManager.studentId)
            {
                _loc_4 = 0;
                if (this._siManager.teacherId != Constant.EMPTY_ID)
                {
                    _loc_4 = 1 + this._siManager.aSupportId.length;
                }
                if (UserDataManager.getInstance().checkRemainPlayerNum((_loc_4 + 1)) == false)
                {
                    if (this._cbRemainPlayerNum != null)
                    {
                        this._cbRemainPlayerNum(param1, param2.playerData);
                    }
                    resetSelect();
                    return;
                }
            }
            super.onSelectPlayer(param1, param2, param3);
            return;
        }// end function

        public function setRemainPlayerNumCallback(param1:Function) : void
        {
            this._cbRemainPlayerNum = param1;
            return;
        }// end function

        private function createListData(param1:Array) : Array
        {
            var _loc_3:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1)
            {
                
                _loc_2.push(new ListPlayerData(_loc_3));
            }
            return _loc_2;
        }// end function

        public function filterCharacter() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this._siManager.aSelectedId;
            for each (_loc_2 in this._aListPlayerData)
            {
                
                _loc_3 = _loc_2.personal;
                if (!_loc_3)
                {
                    continue;
                }
                if (_loc_1.indexOf(_loc_3.uniqueId) != -1)
                {
                    continue;
                }
                if (_loc_3.isUseFacility())
                {
                    _loc_1.push(_loc_3.uniqueId);
                    continue;
                }
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerId);
                if (this._filterId != Constant.EMPTY_ID && _loc_4.weaponType != this._filterId)
                {
                    _loc_1.push(_loc_3.uniqueId);
                    continue;
                }
            }
            this.setNotDisplayPlayer(_loc_1);
            this._page.setPage(0, this._page.pageMax);
            this.updateList();
            this.checkEmptyInformation();
            return;
        }// end function

        private function cbOpenFilterWindow(param1:int) : void
        {
            var _loc_5:* = null;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aFilterId.length)
            {
                
                _loc_5 = new WindowTextButton(this._A_FILTER_TEXT[_loc_3], this.cbFilterSelect, this._aFilterId[_loc_3]);
                _loc_2.push(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = new WindowStyle();
            if (this._filterWindowMenu)
            {
                WindowManager.getInstance().removeWindow(this._filterWindowMenu);
            }
            this._filterWindowMenu = null;
            this._filterWindowMenu = WindowManager.getInstance().createMenuWindow(_mcBase, _loc_2, _loc_4, new Point(_mcBase.filterTextMc.x, _mcBase.filterTextMc.y + 25));
            this.setPlayerSelectEnable(false);
            return;
        }// end function

        private function cbFilterSelect(param1:int) : void
        {
            this._filterId = param1;
            this._filterWindowMenu = null;
            TextControl.setText(_mcBase.filterTextMc.textDt, this._A_FILTER_TEXT[this._aFilterId.indexOf(param1)]);
            this.setPlayerSelectEnable(true);
            this.filterCharacter();
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._filterWindowMenu != null)
            {
                if (!this._filterWindowMenu.hitTestPoint(event.stageX, event.stageY) && !this._filterButton.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._filterWindowMenu);
                    this._filterWindowMenu = null;
                    this.setPlayerSelectEnable(true);
                    return;
                }
            }
            return;
        }// end function

        public static function loadResource() : void
        {
            loadSoundResourceBase();
            PlayerSimpleStatus.loadResource();
            return;
        }// end function

    }
}
