package emperorSelect
{
    import button.*;
    import dropdownList.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import icon.*;
    import input.*;
    import layer.*;
    import message.*;
    import player.*;
    import playerList.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import status.*;
    import user.*;
    import utility.*;

    public class NewEmperorSelect extends Object
    {
        private var _layer:LayerEmperorSelect;
        private var _phase:int;
        private var _dispIndex:int;
        private var _selectMc:MovieClip;
        private var _baseMc:MovieClip;
        private var _isoMainMc:InStayOut;
        private var _listMc:MovieClip;
        private var _listMc3:MovieClip;
        private var _listMc2:MovieClip;
        private var _dispMc:MovieClip;
        private var _newEmperorMc:MovieClip;
        private var _aEmperorPersonal:Array;
        private var _aSortedLispPlayer:Array;
        private var _aEmperorMc:Array;
        private var _setupedEmperorMcType:int;
        private var _aDisplayPersonal:Array;
        private var _aUpdatePlayerUniqueId:Array;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _selectEmperorCheck:SelectEmperorCheck;
        private var _selectEmperorPersonal:PlayerPersonal;
        private var _bmBustUp:Bitmap;
        private var _seriesDropdown:DropdownList;
        private var _rarityDropdown:DropdownList;
        private var _skillDropdown:DropdownList;
        private var _sortDropdown:DropdownList;
        private var _ascendBtn:SortAscendButton;
        private var _page:PageButton;
        private var _pageAnim:PageAnim;
        private var _pageIndex:int;
        private var _nextBtn:ButtonBase;
        private var _isoBtnMc:InStayOut;
        private static const PHASE_OPEN:int = 1;
        private static const PHASE_CLOSE:int = 2;
        private static const PHASE_SELECT:int = 10;
        private static const PHASE_SELECT_CHECK:int = 11;
        private static const PHASE_SORT:int = 12;
        private static const PHASE_FADE_IN:int = 20;
        private static const PHASE_PAGE_CHANGE:int = 30;
        private static const PHASE_LIST_CLOSE:int = 40;
        private static const PHASE_NEW_EMPEROR_EFFECT:int = 50;
        private static const PHASE_NEW_EMPEROR:int = 51;
        private static const PHASE_END:int = 99;
        private static const LABEL_MOUSE_ON:String = "onMouse";
        private static const LABEL_MOUSE_OFF:String = "offMouse";
        private static const LIST_COUNT:int = 4;
        private static const BLACK_OUT:Number = 0.4;
        private static const LIGHT_ON:Number = 1;
        private static const SETUPED_EMPEROR_MC_TYPE_1:int = 1;
        private static const SETUPED_EMPEROR_MC_TYPE_2:int = 2;
        private static const SETUPED_EMPEROR_MC_TYPE_3:int = 3;
        private static const SETUPED_EMPEROR_MC_TYPE_4:int = 4;

        public function NewEmperorSelect(param1:LayerEmperorSelect, param2:Array)
        {
            var layer:* = param1;
            var aEmperorPersonal:* = param2;
            this._layer = layer;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.EMPEROR_SELECT_PATH + "UI_EmperorSelect.swf", "SuccessorSelectMainMc");
            this._layer.getLayer(LayerEmperorSelect.MAIN).addChild(this._baseMc);
            this._isoMainMc = new InStayOut(this._baseMc);
            this._nextBtn = ButtonManager.getInstance().addButton(this._baseMc.nextBtnMoveMc.nextBtnMc, this.cbBtnClick);
            this._isoBtnMc = new InStayOut(this._baseMc.nextBtnMoveMc);
            TextControl.setIdText(this._baseMc.nextBtnMoveMc.nextBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NEXT);
            this._newEmperorMc = this._baseMc.successorSetMc.successorMc;
            this._listMc = this._baseMc.successorSetMc.successorListMc;
            this._listMc3 = this._baseMc.successorSetMc.successorList3Mc;
            this._listMc2 = this._baseMc.successorSetMc.successorList2Mc;
            this._dispMc = this._baseMc.successorSetMc.successorMc;
            this._aUpdatePlayerUniqueId = [];
            this._aEmperorMc = [];
            this._setupedEmperorMcType = Constant.UNDECIDED;
            this._simpleStatus = new PlayerSimpleStatus(this._baseMc.successorSetMc, PlayerSimpleStatus.LABEL_MAIN);
            this._simpleStatus.setMouseEventEnable(false);
            this._simpleStatus.hide();
            this._aEmperorPersonal = aEmperorPersonal;
            this._seriesDropdown = new DropdownList(this._baseMc.successorSetMc.sortSet1Mc, this._baseMc.successorSetMc.sortSet1Mc.textMc, this._baseMc.successorSetMc.sortSet1Mc.sortBtnMc, null, DropdownTemplate.getSeriesFilterList(), this.cbSortMenuOpen, this.cbSortMenuSeries, this.cbSortMenuClose);
            this._rarityDropdown = new DropdownList(this._baseMc.successorSetMc.sortSet2Mc, this._baseMc.successorSetMc.sortSet2Mc.textMc, this._baseMc.successorSetMc.sortSet2Mc.sortBtnMc, null, DropdownTemplate.getEmperorSelectRarityFilterList(), this.cbSortMenuOpen, this.cbSortMenuRarity, this.cbSortMenuClose);
            this._skillDropdown = new DropdownList(this._baseMc.successorSetMc.sortSet3Mc, this._baseMc.successorSetMc.sortSet3Mc.textMc, this._baseMc.successorSetMc.sortSet3Mc.sortBtnMc, null, DropdownTemplate.getSkillFilterList(), this.cbSortMenuOpen, this.cbSortMenuSkill, this.cbSortMenuClose);
            this._sortDropdown = new DropdownList(this._baseMc.successorSetMc.sortSet4Mc, this._baseMc.successorSetMc.sortSet4Mc.textMc, this._baseMc.successorSetMc.sortSet4Mc.sortBtn1Mc, null, DropdownTemplate.getSortList(), this.cbSortMenuOpen, this.cbSortMenuSort, this.cbSortMenuClose);
            this._sortDropdown.setSelectIndex(this._sortDropdown.searchIndex(ListPlayerSort.SORT_ID_NEW));
            this._ascendBtn = new SortAscendButton(this._baseMc.successorSetMc.sortSet4Mc.sortBtn2Mc, this.cbAscendBtn);
            ButtonManager.getInstance().addButtonBase(this._ascendBtn);
            this._page = new PageButton(this._baseMc.successorSetMc.pageBtnSetGuidMc, this.cbChangePage);
            this._pageAnim = new PageAnim(this._listMc, this.changePage, this.cbPageAnimEnd);
            this._pageIndex = Constant.UNDECIDED;
            this.setEmperorSelect();
            this._isoMainMc.setIn(function () : void
            {
                if (UserDataManager.getInstance().userData.chapter != 4)
                {
                    CommonPopup.getInstance().openEmperorSelectnAlertPopup(CommonPopup.POPUP_TYPE_NORMAL, MessageManager.getInstance().getMessage(MessageId.EMPEROR_SELECT_POPUP_MESSAGE01), MessageManager.getInstance().getMessage(MessageId.EMPEROR_SELECT_POPUP_MESSAGE02), null, MessageManager.getInstance().getMessage(MessageId.EMPEROR_SELECT_POPUP_BUTTON));
                }
                return;
            }// end function
            );
            this.setPhase(PHASE_FADE_IN);
            return;
        }// end function

        public function get selectPlayerPersonal() : PlayerPersonal
        {
            return this._selectEmperorPersonal;
        }// end function

        public function get aUpdatePlayerUniqueId() : Array
        {
            return this._aUpdatePlayerUniqueId;
        }// end function

        public function get bOpen() : Boolean
        {
            return this._isoMainMc.bOpened;
        }// end function

        public function get bSelect() : Boolean
        {
            return this._phase == PHASE_NEW_EMPEROR;
        }// end function

        public function get bClose() : Boolean
        {
            return this._phase == PHASE_END;
        }// end function

        public function release() : void
        {
            this.releaseEmperorMc();
            this._aEmperorMc = null;
            if (this._selectEmperorCheck)
            {
                this._selectEmperorCheck.release();
            }
            this._selectEmperorCheck = null;
            if (this._pageAnim)
            {
                this._pageAnim.release();
            }
            this._pageAnim = null;
            if (this._page)
            {
                this._page.release();
            }
            this._page = null;
            if (this._ascendBtn)
            {
                ButtonManager.getInstance().removeButton(this._ascendBtn);
            }
            this._ascendBtn = null;
            if (this._sortDropdown)
            {
                this._sortDropdown.release();
            }
            this._sortDropdown = null;
            if (this._skillDropdown)
            {
                this._skillDropdown.release();
            }
            this._skillDropdown = null;
            if (this._rarityDropdown)
            {
                this._rarityDropdown.release();
            }
            this._rarityDropdown = null;
            if (this._seriesDropdown)
            {
                this._seriesDropdown.release();
            }
            this._seriesDropdown = null;
            if (this._nextBtn != null)
            {
                ButtonManager.getInstance().removeArray(this._nextBtn);
                this._nextBtn.release();
            }
            this._nextBtn = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            this._aSortedLispPlayer = null;
            this._aEmperorPersonal = null;
            this._dispMc = null;
            this._listMc2 = null;
            this._listMc3 = null;
            this._listMc = null;
            this._newEmperorMc = null;
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
                case PHASE_SELECT:
                {
                    this.controlSelect();
                    break;
                }
                case PHASE_SELECT_CHECK:
                {
                    this.controlSelectCheck();
                    break;
                }
                case PHASE_FADE_IN:
                {
                    this.controlFadeIn();
                    break;
                }
                case PHASE_PAGE_CHANGE:
                {
                    this.controlPageChange();
                    break;
                }
                case PHASE_NEW_EMPEROR_EFFECT:
                {
                    this.controlNewEmperorEffect();
                    break;
                }
                case PHASE_NEW_EMPEROR:
                {
                    this.controlNewEmperor();
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._selectEmperorCheck)
            {
                this._selectEmperorCheck.control(param1);
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    case PHASE_SELECT:
                    {
                        this.phaseSelect();
                        break;
                    }
                    case PHASE_SELECT_CHECK:
                    {
                        this.phaseSelectCheck();
                        break;
                    }
                    case PHASE_FADE_IN:
                    {
                        this.phaseFadeIn();
                        break;
                    }
                    case PHASE_PAGE_CHANGE:
                    {
                        this.phasePageChange();
                        break;
                    }
                    case PHASE_LIST_CLOSE:
                    {
                        this.phaseListClose();
                        break;
                    }
                    case PHASE_NEW_EMPEROR_EFFECT:
                    {
                        this.phaseNewEmperorEffect();
                        break;
                    }
                    case PHASE_NEW_EMPEROR:
                    {
                        this.phaseNewEmperor();
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

        private function controlOpen() : void
        {
            if (this._isoMainMc.bOpened)
            {
                this.setPhase(PHASE_SELECT);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoMainMc.setOut();
            this._isoBtnMc.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            if (this._isoMainMc.bEnd && this._isoBtnMc.bEnd)
            {
                this.setPhase(PHASE_END);
            }
            return;
        }// end function

        private function phaseSelect() : void
        {
            this.setColorTransform(LIGHT_ON);
            return;
        }// end function

        private function controlSelect() : void
        {
            return;
        }// end function

        private function phaseSelectCheck() : void
        {
            var _loc_1:* = StatusManager.getInstance().getOwnItemList(UserDataManager.getInstance().userData.getOwnItem(CommonConstant.ITEM_KIND_ACCESSORIES), this._aEmperorPersonal);
            this.setColorTransform(BLACK_OUT);
            this._selectEmperorCheck = new SelectEmperorCheck(this._layer, this._selectEmperorPersonal, _loc_1, this.cbEmperorSelectCheckYes, this.cbEmperorSelectCheckNo, this.cbStatusClose);
            return;
        }// end function

        private function controlSelectCheck() : void
        {
            return;
        }// end function

        private function phaseFadeIn() : void
        {
            return;
        }// end function

        private function controlFadeIn() : void
        {
            if (this._isoMainMc.bOpened)
            {
                this.setPhase(PHASE_SELECT);
            }
            return;
        }// end function

        private function phasePageChange() : void
        {
            return;
        }// end function

        private function controlPageChange() : void
        {
            return;
        }// end function

        private function phaseListClose() : void
        {
            this.setColorTransform(LIGHT_ON);
            this._isoMainMc.setOut(this.cbEmperorSelectEnd);
            return;
        }// end function

        private function phaseNewEmperorEffect() : void
        {
            this.setEmperorDisplay();
            this._isoMainMc.setIn();
            return;
        }// end function

        private function controlNewEmperorEffect() : void
        {
            if (this._isoMainMc.bOpened)
            {
                this.setPhase(PHASE_NEW_EMPEROR);
            }
            return;
        }// end function

        private function phaseNewEmperor() : void
        {
            this._nextBtn.setDisableFlag(false);
            this._isoBtnMc.setIn();
            this._dispMc.gotoAndPlay("in");
            return;
        }// end function

        private function controlNewEmperor() : void
        {
            return;
        }// end function

        private function getEmperorPersonal(param1:Array) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aEmperorPersonal = [];
            for each (_loc_2 in param1)
            {
                
                _loc_3 = new PlayerPersonal();
                _loc_3.setParameter(_loc_2);
                this._aEmperorPersonal.push(_loc_3);
            }
            return;
        }// end function

        private function setEmperorSelect() : void
        {
            this.changeFilter();
            TextControl.setIdText(this._baseMc.successorSetMc.textMc.textDt, MessageId.EMPEROR_SELECT_TITLE);
            this._nextBtn.setDisableFlag(true);
            return;
        }// end function

        private function setEmperorDisplay() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._newEmperorMc.visible = true;
            for each (_loc_1 in this._aEmperorMc)
            {
                
                _loc_1.visible = false;
            }
            this._baseMc.successorSetMc.pageBtnSetGuidMc.visible = false;
            _loc_2 = PlayerManager.getInstance().getPlayerInformation(this._selectEmperorPersonal.playerId);
            _loc_3 = MessageManager.getInstance().getMessage(MessageId.EMPEROR_SELECT_NAME);
            _loc_3 = _loc_3.replace("%d", _loc_2.name);
            TextControl.setText(this._baseMc.successorSetMc.textMc.textDt, _loc_3);
            this.setSelectCharacter(this._dispMc.successor1Mc, this._selectEmperorPersonal);
            return;
        }// end function

        private function changeFilter() : void
        {
            var _loc_5:* = null;
            var _loc_1:* = this._seriesDropdown.selectId;
            var _loc_2:* = this._rarityDropdown.selectId;
            var _loc_3:* = this._skillDropdown.selectId;
            this._aSortedLispPlayer = [];
            var _loc_4:* = 0;
            while (_loc_4 < this._aEmperorPersonal.length)
            {
                
                _loc_5 = new ListPlayerData(this._aEmperorPersonal[_loc_4]);
                if (_loc_1 != 0 && _loc_1 != _loc_5.info.series)
                {
                }
                else if (_loc_2 != 0 && _loc_2 != _loc_5.info.rarity)
                {
                }
                else if (_loc_3 != 0 && _loc_3 != _loc_5.info.weaponType)
                {
                }
                else
                {
                    this._aSortedLispPlayer.push(_loc_5);
                }
                _loc_4++;
            }
            this.changeSort();
            this.setupEmperorMc();
            this._pageIndex = Constant.UNDECIDED;
            this._dispIndex = 0;
            this._newEmperorMc.visible = false;
            this._pageAnim.stop();
            this._page.setPage(0, Math.ceil(this._aSortedLispPlayer.length / LIST_COUNT));
            this.changePage(0);
            return;
        }// end function

        private function changeSort() : void
        {
            ListPlayerSort.sortListPlayer(this._aSortedLispPlayer, this._sortDropdown.selectId, this._ascendBtn.bAscend);
            return;
        }// end function

        private function setupEmperorMc() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = SETUPED_EMPEROR_MC_TYPE_4;
            switch(this._aSortedLispPlayer.length)
            {
                case 1:
                {
                    _loc_1 = SETUPED_EMPEROR_MC_TYPE_1;
                    break;
                }
                case 2:
                {
                    _loc_1 = SETUPED_EMPEROR_MC_TYPE_2;
                    break;
                }
                case 3:
                {
                    _loc_1 = SETUPED_EMPEROR_MC_TYPE_3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._setupedEmperorMcType == _loc_1)
            {
                return;
            }
            this.releaseEmperorMc();
            this._setupedEmperorMcType = _loc_1;
            if (_loc_1 == SETUPED_EMPEROR_MC_TYPE_1)
            {
                this._listMc3.gotoAndStop("stay");
                this._listMc3.successor1Mc.visible = false;
                this._listMc3.successor3Mc.visible = false;
                this._aEmperorMc = [this._listMc3.successor2Mc];
            }
            else if (_loc_1 == SETUPED_EMPEROR_MC_TYPE_2)
            {
                this._listMc2.gotoAndStop("stay");
                this._aEmperorMc = [this._listMc2.successor1Mc, this._listMc2.successor2Mc];
            }
            else if (_loc_1 == SETUPED_EMPEROR_MC_TYPE_3)
            {
                this._listMc3.gotoAndStop("stay");
                this._aEmperorMc = [this._listMc3.successor1Mc, this._listMc3.successor2Mc, this._listMc3.successor3Mc];
            }
            else
            {
                this._aEmperorMc = [this._listMc.successor1Mc, this._listMc.successor2Mc, this._listMc.successor3Mc, this._listMc.successor4Mc];
            }
            this._baseMc.successorSetMc.successorListMc.visible = _loc_1 == SETUPED_EMPEROR_MC_TYPE_4;
            this._baseMc.successorSetMc.successorList3Mc.visible = _loc_1 == SETUPED_EMPEROR_MC_TYPE_3 || _loc_1 == SETUPED_EMPEROR_MC_TYPE_1;
            this._baseMc.successorSetMc.successorList2Mc.visible = _loc_1 == SETUPED_EMPEROR_MC_TYPE_2;
            for each (_loc_2 in this._aEmperorMc)
            {
                
                _loc_2.addEventListener(MouseEvent.CLICK, this.cbEmperorLisrClick);
                _loc_2.addEventListener(MouseEvent.MOUSE_MOVE, this.cbEmperorListMouseMove);
                _loc_2.addEventListener(MouseEvent.ROLL_OUT, this.cbEmperorListRollOut);
            }
            return;
        }// end function

        private function releaseEmperorMc() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aEmperorMc)
            {
                
                _loc_1.removeEventListener(MouseEvent.CLICK, this.cbEmperorLisrClick);
                _loc_1.removeEventListener(MouseEvent.MOUSE_MOVE, this.cbEmperorListMouseMove);
                _loc_1.removeEventListener(MouseEvent.MOUSE_OUT, this.cbEmperorListRollOut);
            }
            this._aEmperorMc = null;
            this._setupedEmperorMcType = Constant.UNDECIDED;
            return;
        }// end function

        private function changePage(param1:int) : void
        {
            if (this._pageIndex == param1)
            {
                return;
            }
            this._pageIndex = param1;
            this._dispIndex = LIST_COUNT * this._pageIndex;
            this._page.changePage(this._pageIndex);
            this.setEmperorList();
            return;
        }// end function

        private function setEmperorList() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = 0;
            this._aDisplayPersonal = [];
            var _loc_2:* = this._dispIndex;
            while (_loc_2 < this._dispIndex + LIST_COUNT)
            {
                
                _loc_3 = this._aEmperorMc[_loc_1];
                _loc_4 = this._aSortedLispPlayer[_loc_2];
                if (_loc_3 == null)
                {
                    break;
                }
                if (_loc_4 != null)
                {
                    this.setSelectCharacter(_loc_3, _loc_4.personal);
                    this._aDisplayPersonal.push(_loc_4.personal);
                    _loc_3.visible = true;
                }
                else
                {
                    _loc_3.visible = false;
                }
                _loc_1++;
                _loc_2++;
            }
            return;
        }// end function

        private function setSelectCharacter(param1:MovieClip, param2:PlayerPersonal) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(param2.playerId);
            var _loc_4:* = new PlayerRarityIcon(param1.charaRankMc, _loc_3.rarity);
            if (BuildSwitch.SW_EMPEROR_SKILL)
            {
                _loc_7 = PlayerManager.getInstance().getEmperorSkill(_loc_3.characterId);
                _loc_8 = PlayerManager.getInstance().getEmperorSkillEffectsBonus(param2, _loc_3, _loc_7);
                TextControl.setText(param1.LeaderSkill.skilltextMc.textDt, PlayerManager.getInstance().getEmperorSkillEffectsText(_loc_3, _loc_8, _loc_7));
            }
            else
            {
                TextControl.setText(param1.LeaderSkill.skilltextMc.textDt, "");
                param1.LeaderSkill.visible = false;
            }
            this._bmBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_3.bustUpFileName);
            this._bmBustUp.smoothing = true;
            this._bmBustUp.x = this._bmBustUp.x - this._bmBustUp.width / 2;
            this._bmBustUp.y = this._bmBustUp.y - this._bmBustUp.height;
            if (param1.bigCharacterNull.numChildren > 0)
            {
                _loc_9 = 0;
                while (_loc_9 < param1.bigCharacterNull.numChildren)
                {
                    
                    param1.bigCharacterNull.removeChildAt(_loc_9);
                    _loc_9++;
                }
            }
            param1.bigCharacterNull.addChild(this._bmBustUp);
            TextControl.setText(param1.charaNameMc.textDt, _loc_3.name);
            if (param2.uniqueId < 0)
            {
                TextControl.setIdText(param1.spotEntryMc.textDt, MessageId.EMPEROR_SELECT_FREE_RARE);
                param1.spotEntryMc.visible = true;
            }
            else
            {
                param1.spotEntryMc.visible = false;
            }
            var _loc_5:* = new WeaponTypeIcon(param1.weaponTypeMc, _loc_3.weaponType);
            var _loc_6:* = new MagicTypeIcon(param1.attributeTypeSetMc, _loc_3.magicType);
            return;
        }// end function

        private function setColorTransform(param1:Number) : void
        {
            this._baseMc.transform.colorTransform = new ColorTransform(param1, param1, param1);
            return;
        }// end function

        private function cbSortMenuOpen() : void
        {
            this.setPhase(PHASE_SORT);
            return;
        }// end function

        private function cbSortMenuClose() : void
        {
            this.setPhase(PHASE_SELECT);
            return;
        }// end function

        private function cbSortMenuSeries(param1:int) : void
        {
            this.changeFilter();
            this.cbSortMenuClose();
            return;
        }// end function

        private function cbSortMenuRarity(param1:int) : void
        {
            this.changeFilter();
            this.cbSortMenuClose();
            return;
        }// end function

        private function cbSortMenuSkill(param1:int) : void
        {
            this.changeFilter();
            this.cbSortMenuClose();
            return;
        }// end function

        private function cbSortMenuSort(param1:int) : void
        {
            this.changeSort();
            this.setEmperorList();
            this.cbSortMenuClose();
            return;
        }// end function

        private function cbAscendBtn(param1:int) : void
        {
            this.changeSort();
            this.setEmperorList();
            return;
        }// end function

        private function cbChangePage(param1:int, param2:int) : Boolean
        {
            this.setPhase(PHASE_PAGE_CHANGE);
            switch(param2)
            {
                case PageButton.PAGE_BUTTON_ID_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_LEFT:
                case PageButton.PAGE_BUTTON_ID_LEFT_END:
                {
                    this._pageAnim.setRight(param1);
                    break;
                }
                case PageButton.PAGE_BUTTON_ID_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_RIGHT:
                case PageButton.PAGE_BUTTON_ID_RIGHT_END:
                {
                    this._pageAnim.setLeft(param1);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        private function cbPageAnimEnd() : void
        {
            this.setPhase(PHASE_SELECT);
            return;
        }// end function

        private function cbEmperorListMouseMove(event:MouseEvent) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (this._phase != PHASE_SELECT)
            {
                return;
            }
            var _loc_2:* = InputManager.getInstance().corsor;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = false;
            var _loc_6:* = 0;
            while (_loc_6 < this._aEmperorMc.length)
            {
                
                _loc_7 = this._aEmperorMc[_loc_6];
                if (_loc_7.hitTestPoint(_loc_2.x, _loc_2.y, true))
                {
                    _loc_5 = true;
                    if (_loc_7.currentLabel != LABEL_MOUSE_ON)
                    {
                        SoundManager.getInstance().playSe(ButtonBase.SE_SELECT_ID);
                        _loc_3 = _loc_7;
                        _loc_4 = this._aDisplayPersonal[_loc_6];
                    }
                    _loc_7.gotoAndStop(LABEL_MOUSE_ON);
                }
                else
                {
                    _loc_7.gotoAndStop(LABEL_MOUSE_OFF);
                }
                _loc_6++;
            }
            if (_loc_3 && _loc_4)
            {
                _loc_8 = _loc_3.BalloonAmbitNull;
                _loc_9 = new Point();
                _loc_9.x = _loc_8.x;
                _loc_9.y = _loc_8.y;
                _loc_9 = _loc_8.parent.localToGlobal(_loc_9);
                _loc_9 = this._baseMc.successorSetMc.globalToLocal(_loc_9);
                _loc_8 = _loc_3.BalloonNull;
                _loc_10 = new Point();
                _loc_10.x = _loc_8.x;
                _loc_10.y = _loc_8.y;
                _loc_10 = _loc_8.parent.localToGlobal(_loc_10);
                this._simpleStatus.show();
                this._simpleStatus.setStatus(_loc_4);
                this._simpleStatus.setPosition(_loc_9);
                this._simpleStatus.setArrowTargetPosition(_loc_10);
            }
            else if (_loc_5 == false)
            {
                if (this._simpleStatus.isShow())
                {
                    this._simpleStatus.hide();
                }
            }
            return;
        }// end function

        private function cbEmperorListRollOver(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            if (this._selectMc == _loc_2 || this._phase != PHASE_SELECT)
            {
                return;
            }
            if (_loc_2 != null)
            {
                _loc_2.gotoAndStop(LABEL_MOUSE_ON);
                this._selectMc = _loc_2;
            }
            return;
        }// end function

        private function cbEmperorListRollOut(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as MovieClip;
            if (_loc_2 != null)
            {
                _loc_2.gotoAndStop(LABEL_MOUSE_OFF);
                this._selectMc = null;
            }
            if (this._simpleStatus.isShow())
            {
                this._simpleStatus.hide();
            }
            return;
        }// end function

        private function cbEmperorLisrClick(event:MouseEvent) : void
        {
            if (this._phase != PHASE_SELECT)
            {
                return;
            }
            var _loc_2:* = event.currentTarget as MovieClip;
            var _loc_3:* = this._aEmperorMc.indexOf(_loc_2);
            this._selectEmperorPersonal = this._aDisplayPersonal[_loc_3];
            if (this._selectEmperorPersonal != null)
            {
                SoundManager.getInstance().playSe(ButtonBase.SE_DECIDE_ID);
                this.setButtonEnable(false);
                this.setPhase(PHASE_SELECT_CHECK);
            }
            return;
        }// end function

        private function setButtonEnable(param1:Boolean) : void
        {
            this._seriesDropdown.setEnable(param1);
            this._rarityDropdown.setEnable(param1);
            this._skillDropdown.setEnable(param1);
            this._sortDropdown.setEnable(param1);
            this._ascendBtn.setDisable(!param1);
            if (param1)
            {
                this._page.btnEnable(true);
                this._page.update();
            }
            else
            {
                this._page.btnEnable(false);
            }
            return;
        }// end function

        private function cbEmperorSelectCheckYes() : void
        {
            this._selectEmperorCheck.release();
            this._selectEmperorCheck = null;
            this.setPhase(PHASE_LIST_CLOSE);
            return;
        }// end function

        private function cbEmperorSelectCheckNo() : void
        {
            this._selectEmperorCheck.release();
            this._selectEmperorCheck = null;
            this._baseMc.successorSetMc.pageBtnSetGuidMc.visible = true;
            this.setButtonEnable(true);
            this.setPhase(PHASE_SELECT);
            return;
        }// end function

        private function cbEmperorSelectEnd() : void
        {
            this.setPhase(PHASE_CLOSE);
            return;
        }// end function

        private function cbBtnClick(param1:int) : void
        {
            this._nextBtn.setDisableFlag(true);
            this.setPhase(PHASE_CLOSE);
            return;
        }// end function

        private function cbStatusClose(param1:int) : void
        {
            var _loc_2:* = null;
            if (this._aUpdatePlayerUniqueId.indexOf(param1) == -1)
            {
                this._aUpdatePlayerUniqueId.push(param1);
            }
            if (this._selectEmperorCheck.displayPlayerUniqueId == param1)
            {
                for each (_loc_2 in this._aEmperorPersonal)
                {
                    
                    if (param1 == _loc_2.uniqueId)
                    {
                        this._selectEmperorCheck.updateStatus(_loc_2);
                        break;
                    }
                }
            }
            return;
        }// end function

    }
}
