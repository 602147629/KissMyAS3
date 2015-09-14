package album
{
    import PlayerCard.*;
    import button.*;
    import character.*;
    import correlation.*;
    import dropdownList.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import input.*;
    import message.*;
    import player.*;
    import resource.*;
    import status.*;
    import user.*;
    import window.*;

    public class AlbumList extends Object
    {
        private var _baseMc:MovieClip;
        private var _aPlayerAllId:Array;
        private var _aPlayerId:Array;
        private var _aAlbumList:Array;
        private var _aUpdateAlbumList:Array;
        private const _EMPEROR_EXCLUSIVE_FLAG:int = 10000;
        private const _CARD_PER_PAGE:int = 12;
        private var _aPlayerCardNull:Array;
        private var _aAlbumCard:Array;
        private var _aButton:Array;
        private var _seriesBtn:ButtonBase;
        private var _rarityBtn:ButtonBase;
        private var _skillBtn:ButtonBase;
        private var _sortBtn:ButtonBase;
        private var _pageIndex:int = 0;
        private var _pageIndexMax:int;
        private var _detailStatus:PlayerDetailStatus;
        private var _listCreateEnd:Boolean;
        private var _resourceLoadEnd:Boolean;
        private const _ALBUMLIST_START:int = 0;
        private const _ALBUMLIST_CREATE_START:int = 1;
        private const _ALBUMLIST_CREATE_END:int = 2;
        private const _ALBUMLIST_LOAD_START:int = 3;
        private const _ALBUMLIST_LOAD_END:int = 4;
        private const _ALBUMLIST_MAIN:int = 5;
        private const _ALBUMLIST_UPDATA:int = 6;
        private var _phase:int;
        private var _selectSeriesId:int = 0;
        private var _seriesWindowMenu:WindowMenu;
        private var _aSeriesList:Array;
        private var _selectRarityId:int = 0;
        private var _rarityWindowMenu:WindowMenu;
        private var _aRarityList:Array;
        private var _selectSkillId:int = 0;
        private var _skillWindowMenu:WindowMenu;
        private var _aSkillList:Array;
        private var _selectSortId:int = 0;
        private var _sortWindowMenu:WindowMenu;
        private const _SORT_ID_CARD:int = 0;
        private const _SORT_ID_NAME:int = 1;
        private const _SORT_ID_RARE_HI:int = 2;
        private const _SORT_ID_RARE_LO:int = 3;
        private const _SORT_ID_SERIES_OLD:int = 4;
        private const _SORT_ID_SERIES_NEW:int = 5;
        private var _aSortText:Array;
        private var _cbStatusClose:Function;
        private var _albumListCreate:AlbumListCreate;
        private var _returnBtn:ButtonBase;
        private var _page:PageButton;
        private var _pageInLoad:int = 0;
        private var _pageInLoadMax:int = 12;

        public function AlbumList(param1:MovieClip, param2:Array, param3:Array, param4:Function, param5:ButtonBase)
        {
            var _loc_6:* = null;
            this._aSortText = [TextControl.formatIdText(MessageId.ALBUM_SORT_CARD_ORDER), TextControl.formatIdText(MessageId.ALBUM_SORT_NAME_ORDER), TextControl.formatIdText(MessageId.ALBUM_SORT_RARITY_HIGH_ORDER), TextControl.formatIdText(MessageId.ALBUM_SORT_RARITY_LOW_ORDER), TextControl.formatIdText(MessageId.ALBUM_SORT_SERIES_ORDER), TextControl.formatIdText(MessageId.ALBUM_SORT_SERIES_REVERSE_ORDER)];
            this._baseMc = param1;
            this._cbStatusClose = param4;
            this._returnBtn = param5;
            this._returnBtn.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._aSeriesList = DropdownTemplate.getSeriesFilterList();
            this._aRarityList = DropdownTemplate.getRarityFilterList();
            this._aSkillList = DropdownTemplate.getSkillFilterList();
            this._aAlbumCard = [new AlbumCard(this._baseMc.albumBgMc.cardSetNull1, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull2, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull3, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull4, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull5, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull6, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull7, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull8, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull9, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull10, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull11, this.cbButton), new AlbumCard(this._baseMc.albumBgMc.cardSetNull12, this.cbButton)];
            this._aPlayerAllId = param2;
            this._aPlayerId = param3;
            this._aButton = [];
            this._seriesBtn = ButtonManager.getInstance().addButton(this._baseMc.sortSet1Mc.sortBtnMc, this.cbSeriesClick);
            this._rarityBtn = ButtonManager.getInstance().addButton(this._baseMc.sortSet2Mc.sortBtnMc, this.cbRarityClick);
            this._skillBtn = ButtonManager.getInstance().addButton(this._baseMc.sortSet3Mc.sortBtnMc, this.cbSkillClick);
            this._sortBtn = ButtonManager.getInstance().addButton(this._baseMc.sortSet4Mc.sortBtnMc, this.cbSortClick);
            this._aButton.push(this._seriesBtn);
            this._aButton.push(this._rarityBtn);
            this._aButton.push(this._skillBtn);
            this._aButton.push(this._sortBtn);
            this._page = new PageButton(this._baseMc.albumBgMc, this.cbChangePage, 0, 14);
            for each (_loc_6 in this._aButton)
            {
                
                _loc_6.enterSeId = ButtonBase.SE_CURSOR_ID;
            }
            TextControl.setText(this._baseMc.sortSet1Mc.sortTextMc.textDt, this._aSeriesList[this._selectSeriesId].text, true);
            TextControl.setText(this._baseMc.sortSet2Mc.sortTextMc.textDt, this._aRarityList[this._selectRarityId].text, true);
            TextControl.setText(this._baseMc.sortSet3Mc.sortTextMc.textDt, this._aSkillList[this._selectSkillId].text, true);
            TextControl.setText(this._baseMc.sortSet4Mc.sortTextMc.textDt, this._aSortText[this._selectSortId], true);
            InputManager.getInstance().addMouseCallback(this, null, this.cbMouseClick, null, null, 0);
            this._albumListCreate = new AlbumListCreate();
            return;
        }// end function

        public function get bListCreateEnd() : Boolean
        {
            return this._listCreateEnd;
        }// end function

        public function get bResourceLoadEnd() : Boolean
        {
            return this._resourceLoadEnd;
        }// end function

        public function createAlbumList() : void
        {
            this._aAlbumList = [];
            this._aAlbumList = this._albumListCreate.createList(this._aPlayerAllId, this._aPlayerId);
            this._phase = this._ALBUMLIST_CREATE_END;
            return;
        }// end function

        public function resourceAlbumLoad(param1:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this._page.btnEnable(false);
            var _loc_2:* = this._aAlbumList;
            if (param1)
            {
                _loc_2 = this._aUpdateAlbumList;
            }
            this._phase = this._ALBUMLIST_LOAD_START;
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Correlation.swf");
            PlayerSmallCard.loadResource();
            var _loc_3:* = this._pageInLoad;
            while (_loc_3 < this._pageInLoadMax)
            {
                
                if (_loc_2[_loc_3])
                {
                    if (_loc_2[_loc_3].bCard)
                    {
                        _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_2[_loc_3].id);
                        ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_4.swf);
                        ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + _loc_4.bustUpFileName);
                        ResourceManager.getInstance().loadResource(ResourcePath.CARD_SMALL_PATH + CharacterConstant.ID_CARD + _loc_4.cardFileName);
                        for each (_loc_5 in _loc_4.aDiagramCharaId)
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
                _loc_3++;
            }
            return;
        }// end function

        public function updateAlbumList() : void
        {
            this._aUpdateAlbumList = [];
            this._aUpdateAlbumList = this._aAlbumList;
            this.updateScreen();
            return;
        }// end function

        private function updateScreen() : void
        {
            var _loc_2:* = 0;
            this._pageIndexMax = this._aUpdateAlbumList.length / this._CARD_PER_PAGE;
            if (this._aUpdateAlbumList.length % this._CARD_PER_PAGE)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._pageIndexMax + 1;
                _loc_3._pageIndexMax = _loc_4;
            }
            this._page.setMaxPage(this._pageIndexMax);
            var _loc_1:* = 0;
            while (_loc_1 < this._CARD_PER_PAGE)
            {
                
                _loc_2 = this._pageIndex * this._CARD_PER_PAGE + _loc_1;
                if (_loc_2 >= this._aUpdateAlbumList.length)
                {
                    this._aAlbumCard[_loc_1].setUnknown(Constant.UNDECIDED);
                }
                else if (!this._aUpdateAlbumList[_loc_2].bCard)
                {
                    this._aAlbumCard[_loc_1].setUnknown(Constant.UNDECIDED);
                }
                else
                {
                    this._aAlbumCard[_loc_1].setPlayerId(this._aUpdateAlbumList[_loc_2].id);
                }
                _loc_1++;
            }
            this._page.btnEnable(true);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            for each (_loc_1 in this._aButton)
            {
                
                if (_loc_1 != null)
                {
                    ButtonManager.getInstance().removeButton(_loc_1);
                    _loc_1 = null;
                }
            }
            this._aButton = [];
            if (this._detailStatus)
            {
                this._detailStatus.release();
            }
            this._detailStatus = null;
            for each (_loc_2 in this._aAlbumCard)
            {
                
                _loc_2.release();
            }
            this._aAlbumCard = null;
            InputManager.getInstance().delMouseCallback(this);
            return;
        }// end function

        private function cbButton(param1:int) : void
        {
            this.setDisableButton(true);
            StatusManager.getInstance().addStatusDetail(PlayerDetailStatus.STATUS_TYPE_ALBUM, this._baseMc, this.cbDetailStatusClose, null, null, param1);
            return;
        }// end function

        private function cbDetailStatusClose(param1:int = 0, param2:Boolean = false) : void
        {
            if (param1 != Constant.EMPTY_ID && param2)
            {
                this._cbStatusClose(param1);
            }
            if (StatusManager.getInstance().aDetailLength == 0)
            {
                this.setDisableButton(false);
            }
            return;
        }// end function

        private function cbSeriesClick(param1:int) : void
        {
            var _loc_5:* = null;
            this.setDisableButton(true);
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aSeriesList.length)
            {
                
                _loc_5 = new WindowTextButton(this._aSeriesList[_loc_3].text, this.cbSeriesSelect, _loc_3);
                _loc_2.push(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = new WindowStyle();
            if (this._seriesWindowMenu)
            {
                WindowManager.getInstance().removeWindow(this._seriesWindowMenu);
            }
            this._seriesWindowMenu = null;
            this._seriesWindowMenu = WindowManager.getInstance().createMenuWindow(this._baseMc, _loc_2, _loc_4, new Point(this._baseMc.sortSet1Mc.x - this._baseMc.sortSet1Mc.width / 2, this._baseMc.sortSet1Mc.y + this._baseMc.sortSet1Mc.height / 2));
            return;
        }// end function

        private function cbSeriesSelect(param1:int) : void
        {
            this._selectSeriesId = param1;
            TextControl.setText(this._baseMc.sortSet1Mc.sortTextMc.textDt, this._aSeriesList[this._selectSeriesId].text, true);
            this._seriesWindowMenu = null;
            this.sort();
            return;
        }// end function

        private function cbRarityClick(param1:int) : void
        {
            var _loc_5:* = null;
            this.setDisableButton(true);
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aRarityList.length)
            {
                
                _loc_5 = new WindowTextButton(this._aRarityList[_loc_3].text, this.cbRaritySelect, _loc_3);
                _loc_2.push(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = new WindowStyle();
            if (this._rarityWindowMenu)
            {
                WindowManager.getInstance().removeWindow(this._rarityWindowMenu);
            }
            this._rarityWindowMenu = null;
            this._rarityWindowMenu = WindowManager.getInstance().createMenuWindow(this._baseMc, _loc_2, _loc_4, new Point(this._baseMc.sortSet2Mc.x - this._baseMc.sortSet2Mc.width / 2, this._baseMc.sortSet2Mc.y + this._baseMc.sortSet2Mc.height / 2));
            return;
        }// end function

        private function cbRaritySelect(param1:int) : void
        {
            this._selectRarityId = param1;
            TextControl.setText(this._baseMc.sortSet2Mc.sortTextMc.textDt, this._aRarityList[this._selectRarityId].text, true);
            this._rarityWindowMenu = null;
            this.sort();
            return;
        }// end function

        private function cbSkillClick(param1:int) : void
        {
            var _loc_5:* = null;
            this.setDisableButton(true);
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aSkillList.length)
            {
                
                _loc_5 = new WindowTextButton(this._aSkillList[_loc_3].text, this.cbSkillSelect, _loc_3);
                _loc_2.push(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = new WindowStyle();
            if (this._skillWindowMenu)
            {
                WindowManager.getInstance().removeWindow(this._skillWindowMenu);
            }
            this._skillWindowMenu = null;
            this._skillWindowMenu = WindowManager.getInstance().createMenuWindow(this._baseMc, _loc_2, _loc_4, new Point(this._baseMc.sortSet3Mc.x - this._baseMc.sortSet3Mc.width / 2, this._baseMc.sortSet3Mc.y + this._baseMc.sortSet3Mc.height / 2));
            return;
        }// end function

        private function cbSkillSelect(param1:int) : void
        {
            this._selectSkillId = param1;
            TextControl.setText(this._baseMc.sortSet3Mc.sortTextMc.textDt, this._aSkillList[this._selectSkillId].text, true);
            this._skillWindowMenu = null;
            this.sort();
            return;
        }// end function

        private function cbSortClick(param1:int) : void
        {
            var _loc_5:* = null;
            this.setDisableButton(true);
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._aSortText.length)
            {
                
                _loc_5 = new WindowTextButton(this._aSortText[_loc_3], this.cbSortSelect, _loc_3);
                _loc_2.push(_loc_5);
                _loc_3++;
            }
            var _loc_4:* = new WindowStyle();
            if (this._sortWindowMenu)
            {
                WindowManager.getInstance().removeWindow(this._sortWindowMenu);
            }
            this._sortWindowMenu = null;
            this._sortWindowMenu = WindowManager.getInstance().createMenuWindow(this._baseMc, _loc_2, _loc_4, new Point(this._baseMc.sortSet4Mc.x - this._baseMc.sortSet4Mc.width / 2, this._baseMc.sortSet4Mc.y + this._baseMc.sortSet4Mc.height / 2));
            return;
        }// end function

        private function cbSortSelect(param1:int) : void
        {
            this._selectSortId = param1;
            TextControl.setText(this._baseMc.sortSet4Mc.sortTextMc.textDt, this._aSortText[this._selectSortId], true);
            this._sortWindowMenu = null;
            this.sort();
            return;
        }// end function

        private function sort() : void
        {
            var _loc_2:* = null;
            this._pageIndex = 0;
            this.setDisableButton(false);
            var _loc_1:* = [];
            this._aUpdateAlbumList = this._aAlbumList;
            if (this._selectSeriesId == 0)
            {
                _loc_1 = this._aUpdateAlbumList;
            }
            else
            {
                for each (_loc_2 in this._aUpdateAlbumList)
                {
                    
                    if (this._aSeriesList[this._selectSeriesId].id == _loc_2.series)
                    {
                        _loc_1.push(_loc_2);
                    }
                }
            }
            this._aUpdateAlbumList = _loc_1;
            _loc_1 = [];
            if (this._selectRarityId == 0)
            {
                _loc_1 = this._aUpdateAlbumList;
            }
            else
            {
                for each (_loc_2 in this._aUpdateAlbumList)
                {
                    
                    if (this._aRarityList[this._selectRarityId].id == _loc_2.rarity)
                    {
                        _loc_1.push(_loc_2);
                    }
                }
            }
            this._aUpdateAlbumList = _loc_1;
            _loc_1 = [];
            if (this._selectSkillId == 0)
            {
                _loc_1 = this._aUpdateAlbumList;
            }
            else
            {
                for each (_loc_2 in this._aUpdateAlbumList)
                {
                    
                    if (this._aSkillList[this._selectSkillId].id == _loc_2.wepon)
                    {
                        _loc_1.push(_loc_2);
                    }
                }
            }
            this._aUpdateAlbumList = _loc_1;
            switch(this._selectSortId)
            {
                case this._SORT_ID_CARD:
                {
                    this._aUpdateAlbumList.sortOn("id", Array.NUMERIC);
                    break;
                }
                case this._SORT_ID_NAME:
                {
                    this._aUpdateAlbumList.sortOn(["name", "id"], [0, Array.NUMERIC]);
                    break;
                }
                case this._SORT_ID_RARE_HI:
                {
                    this._aUpdateAlbumList.sortOn(["rarityValue", "id"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
                    break;
                }
                case this._SORT_ID_RARE_LO:
                {
                    this._aUpdateAlbumList.sortOn(["rarityValue", "id"], [Array.NUMERIC, Array.NUMERIC]);
                    break;
                }
                case this._SORT_ID_SERIES_OLD:
                {
                    this._aUpdateAlbumList.sortOn(["series", "id"], [Array.NUMERIC, Array.NUMERIC]);
                    break;
                }
                case this._SORT_ID_SERIES_NEW:
                {
                    this._aUpdateAlbumList.sortOn(["series", "id"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._aUpdateAlbumList.length < this._CARD_PER_PAGE)
            {
                this._pageInLoadMax = this._aUpdateAlbumList.length;
            }
            else
            {
                this._pageInLoadMax = this._CARD_PER_PAGE;
            }
            this._pageInLoad = 0;
            this._page.setPage(this._pageInLoad, this._pageIndexMax);
            this.resourceAlbumLoad(true);
            this._phase = this._ALBUMLIST_UPDATA;
            return;
        }// end function

        private function cbMouseClick(event:MouseEvent) : void
        {
            if (this._seriesWindowMenu != null)
            {
                if (!this._seriesWindowMenu.hitTestPoint(event.stageX, event.stageY) && !this._seriesBtn.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._seriesWindowMenu);
                    this._seriesWindowMenu = null;
                    this.setDisableButton(false);
                }
            }
            if (this._rarityWindowMenu != null)
            {
                if (!this._rarityWindowMenu.hitTestPoint(event.stageX, event.stageY) && !this._rarityBtn.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._rarityWindowMenu);
                    this._rarityWindowMenu = null;
                    this.setDisableButton(false);
                }
            }
            if (this._skillWindowMenu != null)
            {
                if (!this._skillWindowMenu.hitTestPoint(event.stageX, event.stageY) && !this._skillBtn.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._skillWindowMenu);
                    this._skillWindowMenu = null;
                    this.setDisableButton(false);
                }
            }
            if (this._sortWindowMenu != null)
            {
                if (!this._sortWindowMenu.hitTestPoint(event.stageX, event.stageY) && !this._sortBtn.getHitMoveClip().hitTestPoint(event.stageX, event.stageY))
                {
                    WindowManager.getInstance().removeWindow(this._sortWindowMenu);
                    this._sortWindowMenu = null;
                    this.setDisableButton(false);
                }
            }
            return;
        }// end function

        private function setDisableButton(param1:Boolean) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this._aAlbumCard)
            {
                
                if (param1)
                {
                    _loc_2.offMouseClick();
                }
                _loc_2.setDisableButton(param1);
            }
            this._returnBtn.setDisable(param1);
            this._page.btnDisable(param1);
            for each (_loc_3 in this._aButton)
            {
                
                _loc_3.setDisableFlag(param1);
            }
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = 0;
            this._pageIndex = param1;
            switch(param2)
            {
                case PageButton.PAGE_BUTTON_ID_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_LEFT:
                {
                    this._pageInLoadMax = (this._pageIndex + 1) * this._CARD_PER_PAGE;
                    this._pageInLoad = this._pageInLoadMax - this._CARD_PER_PAGE;
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_LEFT_END:
                {
                    this._pageInLoadMax = this._CARD_PER_PAGE;
                    this._pageInLoad = Constant.EMPTY_ID;
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_END:
                {
                    this._pageInLoadMax = (this._pageIndex + 1) * this._CARD_PER_PAGE;
                    this._pageInLoad = this._pageInLoadMax - this._CARD_PER_PAGE;
                    _loc_3 = this._aUpdateAlbumList.length % this._CARD_PER_PAGE;
                    if (_loc_3 != 0 && this._pageIndex == this._pageIndexMax || this._pageIndex == this._pageIndexMax)
                    {
                        this._pageInLoadMax = this._aUpdateAlbumList.length;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            this.resourceAlbumLoad(true);
            this._phase = this._ALBUMLIST_UPDATA;
            return true;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._ALBUMLIST_CREATE_START:
                {
                    this._listCreateEnd = false;
                    break;
                }
                case this._ALBUMLIST_CREATE_END:
                {
                    this._listCreateEnd = true;
                    break;
                }
                case this._ALBUMLIST_LOAD_START:
                {
                    this._listCreateEnd = false;
                    this._resourceLoadEnd = false;
                    if (ResourceManager.getInstance().isLoaded())
                    {
                        this._phase = this._ALBUMLIST_LOAD_END;
                    }
                    break;
                }
                case this._ALBUMLIST_LOAD_END:
                {
                    this._phase = this._ALBUMLIST_MAIN;
                    this._resourceLoadEnd = true;
                    break;
                }
                case this._ALBUMLIST_MAIN:
                {
                    this._resourceLoadEnd = false;
                    break;
                }
                case this._ALBUMLIST_UPDATA:
                {
                    if (ResourceManager.getInstance().isLoaded())
                    {
                        this.updateScreen();
                        this._phase = this._ALBUMLIST_MAIN;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._detailStatus)
            {
                this._detailStatus.control(param1);
            }
            return;
        }// end function

    }
}
