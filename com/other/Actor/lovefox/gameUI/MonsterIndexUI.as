package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import lovefox.component.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class MonsterIndexUI extends Window
    {
        private var _searchIT:InputText;
        private var _searchPB:PushButton;
        private var _recommendPB:PushButton;
        private var _currentMapPB:PushButton;
        private var _allMonsterPB:PushButton;
        private var _hangPB:PushButton;
        private var _hangMode0:RadioButton;
        public var _hangMode1:RadioButton;
        public var _hangTimeTf:TextField;
        public var _eliteCB:CheckBox;
        private var _monsterList:List;
        private var _hangPanel:Sprite;
        private var _detailPanel:Sprite;
        public var _setupPanel:HangUI;
        private var _descriptionTitleLB:Label;
        private var _dropTitleLB:Label;
        private var _dropCanvas:CanvasUI;
        private var _dropListLB:Label;
        private var _dropProbLB:Label;
        private var _mapTitleLB:Label;
        private var _mapListLB:Label;
        private var _mapGoLB:Label;
        private var _avatarPanel:Panel;
        private var _avatarClip:UnitClip;
        private var _panelArray:Array;
        private var _panelLabelArray:Array;
        private var _panelCheckBoxArray:Array;
        private var _panelClipArray:Array;
        private var _selectedAvatarPB:PushButton;
        private var _selectedMonster:Object;
        private var _detailPB:Label;
        private var _setupPB:Label;
        private var _topNav:ButtonBar;
        private var _hanging:Boolean = false;
        private var _monsterListBig:Array;
        private var _page:uint;
        private var _listMap:Object;
        private var _preMonsterList:Array;
        private var _preAvatarId:Object;
        private var _hangStartTime:int = -1;
        private var _flyBtnArray:Array;
        private var _tempTxt:TextField;

        public function MonsterIndexUI(param1)
        {
            this._panelArray = [];
            this._panelLabelArray = [];
            this._panelCheckBoxArray = [];
            this._panelClipArray = [];
            this._listMap = {};
            this._flyBtnArray = [];
            super(param1);
            resize(580, 340);
            title = Config.language("MonsterIndexUI", 1);
            this.initDraw();
            this.cacheAsBitmap = false;
            Config.map.addEventListener("complete", this.handleMapComplete);
            return;
        }// end function

        private function handleMapComplete(param1)
        {
            Config.startLoop(this.subMapComplete);
            return;
        }// end function

        private function subMapComplete(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            Config.stopLoop(this.subMapComplete);
            if (isCanHang())
            {
                _loc_2 = this.getMonsterNear(true, true);
                if (_opening && this._preMonsterList != null)
                {
                    this.clear();
                    if (this._page == 0 || this._page == 1)
                    {
                        if (_loc_2.length != 0 && Config.map.data.type != 0)
                        {
                            this.setMonsterList(_loc_2, true);
                        }
                    }
                    else if (this._page == 2)
                    {
                        this.setMonsterList(this._preMonsterList, false);
                        if (this._preAvatarId != null)
                        {
                            this.setAvatar(this._preAvatarId, true);
                        }
                    }
                }
                _loc_3 = 0;
                while (_loc_3 < this._panelCheckBoxArray.length)
                {
                    
                    this._panelCheckBoxArray[_loc_3].selected = true;
                    _loc_3 = _loc_3 + 1;
                }
            }
            else if (_opening)
            {
                this.clear();
            }
            return;
        }// end function

        private function handleNav(param1, param2)
        {
            this.changePage(param2);
            return;
        }// end function

        public function initDraw()
        {
            var _loc_1:* = null;
            this._topNav = new ButtonBar(this, 15, 25);
            this._topNav.addTab(Config.language("MonsterIndexUI", 1), Config.create(this.handleNav, 0));
            this._topNav.addTab(Config.language("MonsterIndexUI", 2), Config.create(this.handleNav, 1));
            this._topNav.addTab(Config.language("MonsterIndexUI", 3), Config.create(this.handleNav, 2));
            this._setupPanel = new HangUI();
            this._setupPanel.y = 30;
            this._hangPanel = new Sprite();
            this._hangPanel.y = 20;
            this._hangMode0 = new RadioButton(this._hangPanel, 210, 240, Config.language("MonsterIndexUI", 19), true, this.handleHangMode);
            this._hangMode0.tip = Config.language("MonsterIndexUI", 20);
            this._hangMode1 = new RadioButton(this._hangPanel, 300, 240, Config.language("MonsterIndexUI", 21), false, this.handleHangMode);
            this._hangMode1.tip = Config.language("MonsterIndexUI", 22);
            var _loc_2:* = "monsaterindexui_mode";
            this._hangMode1.group = "monsaterindexui_mode";
            this._hangMode0.group = _loc_2;
            this._hangMode0.selected = true;
            this._hangPB = new PushButton(this._hangPanel, 175 + 65, 270, Config.language("MonsterIndexUI", 4), this.handleHangClick);
            this._hangPB.setTable("table13", "table14");
            if (Hang.limitedHang)
            {
                this._hangTimeTf = Config.getSimpleTextField();
                this._hangTimeTf.autoSize = TextFieldAutoSize.CENTER;
                this._hangTimeTf.x = 290;
                this._hangTimeTf.y = 280;
                this._hangTimeTf.textColor = Style.WINDOW_FONT;
                this._hangPanel.addChild(this._hangTimeTf);
            }
            this._eliteCB = new CheckBox(this._hangPanel, 300 + 50, 280, Config.language("MonsterIndexUI", 17), this.handleEliteCB);
            this._eliteCB.selected = true;
            this._detailPanel = new Sprite();
            this._detailPanel.x = 10;
            this._detailPanel.y = 55;
            this._searchIT = new InputText(this._detailPanel, 0, 0, "");
            this._searchIT.width = 220;
            this._searchPB = new PushButton(this._detailPanel, 225, 0, Config.language("MonsterIndexUI", 5), this.handleSearchClick);
            this._searchPB.width = 80;
            this._allMonsterPB = new PushButton(this._detailPanel, 310, 0, Config.language("MonsterIndexUI", 6), this.handleAllMonsterClick);
            this._allMonsterPB.width = 80;
            this._monsterList = new List(this._detailPanel, 0, 30, this.handleMonsterSelect);
            this._monsterList.width = 120;
            this._monsterList.height = 240;
            this._monsterList.autoHeight = false;
            this._descriptionTitleLB = new Label(this._detailPanel, 220, 35, "");
            this._dropTitleLB = new Label(this._detailPanel, 320, 65, Config.language("MonsterIndexUI", 7));
            new Label(this._detailPanel, 490, 65, Config.language("MonsterIndexUI", 18));
            this._dropListLB = new Label(null, 0, 0, "", this.handleItemSelect);
            this._dropListLB.html = true;
            this._dropListLB.mouseEnabled = true;
            this._dropProbLB = new Label(null, 0, 0, "");
            this._dropCanvas = new CanvasUI(this._detailPanel, 320, 90, 240, 180);
            this._dropCanvas.addChildUI(this._dropListLB);
            this._dropCanvas.addChildUI(this._dropProbLB);
            this._dropProbLB.x = 180;
            this._mapTitleLB = new Label(this._detailPanel, 130, 120, Config.language("MonsterIndexUI", 8));
            this._mapListLB = new Label(this._detailPanel, 130, 140, "", this.handleMapSelect);
            this._mapListLB.html = true;
            this._mapListLB.mouseEnabled = true;
            this._mapGoLB = new Label(this._detailPanel, 255, 140, "", this.handleMapGo);
            this._mapGoLB.html = true;
            this._mapGoLB.mouseEnabled = true;
            this._avatarPanel = new Panel(this._detailPanel, 130, 35);
            this._avatarPanel.roundCorner = 4;
            this._avatarPanel.shadow = 4;
            var _loc_2:* = 80;
            this._avatarPanel.height = 80;
            this._avatarPanel.width = _loc_2;
            this.changePage(0);
            return;
        }// end function

        private function handleHangMode(param1)
        {
            var _loc_2:* = undefined;
            if (this._hangMode1.selected)
            {
                _loc_2 = 0;
                while (_loc_2 < this._panelCheckBoxArray.length)
                {
                    
                    this._panelCheckBoxArray[_loc_2].enabled = false;
                    _loc_2 = _loc_2 + 1;
                }
            }
            else
            {
                _loc_2 = 0;
                while (_loc_2 < this._panelCheckBoxArray.length)
                {
                    
                    this._panelCheckBoxArray[_loc_2].enabled = true;
                    _loc_2 = _loc_2 + 1;
                }
            }
            this._setupPanel.setCookie();
            return;
        }// end function

        private function handleEliteCB(param1)
        {
            if (this.hanging)
            {
                Hang.start(true);
            }
            this._setupPanel.setCookie();
            return;
        }// end function

        private function handlePanelNameClick(param1)
        {
            var _loc_2:* = param1.currentTarget.data;
            this.setMonsterList(this.getMonsterByFuzzy(""));
            this.setAvatar(_loc_2, true);
            return;
        }// end function

        private function handlePanelNameRollOver(param1)
        {
            var _loc_2:* = param1.currentTarget.data.monsterid;
            var _loc_3:* = param1.currentTarget.parent;
            Holder.showInfo(this.getDropStr(_loc_2), new Rectangle(_loc_3.x + _loc_3.parent.x + _loc_3.parent.parent.x + 3, _loc_3.y + _loc_3.parent.y + _loc_3.parent.parent.y, _loc_3.width, 0), false, 2);
            return;
        }// end function

        private function handlePanelNameRollOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleBuffSkillDrag(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (Holder.item == null)
            {
                if (_loc_2.skill != null)
                {
                    Holder.other = {obj:_loc_2.skill, bmpd:_loc_2.skill.getIcon()};
                    _loc_2.skill = null;
                }
            }
            return;
        }// end function

        private function handleBuffSkillClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (Holder.other is Skill)
            {
                _loc_2.skill = Holder.other;
                Holder.other = null;
            }
            return;
        }// end function

        public function refreshMonsterList()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < this._monsterList.itemArray.length)
            {
                
                _loc_2 = this._monsterList.getRow(this._monsterList.itemArray[_loc_1]);
                _loc_5 = Config.player.level - Number(Config._monsterMap[this._monsterList.itemArray[_loc_1].data].level);
                if (_loc_5 > 5)
                {
                    _loc_2.data.forceColor = 16777215;
                    _loc_2.color = 16777215;
                }
                else if (_loc_5 <= 5 && _loc_5 > -1)
                {
                    _loc_2.data.forceColor = 16750848;
                    _loc_2.color = 16750848;
                }
                else if (_loc_5 <= -1 && _loc_5 > -10)
                {
                    _loc_2.data.forceColor = 13369344;
                    _loc_2.color = 13369344;
                }
                else
                {
                    this._monsterList.itemArray[_loc_1]._bindingLabel.text = "???";
                    _loc_2.data.forceColor = 13369344;
                    _loc_2.color = 13369344;
                }
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function changePage(param1:uint)
        {
            this._page = param1;
            if (this._detailPanel.parent != null)
            {
                this._detailPanel.parent.removeChild(this._detailPanel);
            }
            if (this._hangPanel.parent != null)
            {
                this._hangPanel.parent.removeChild(this._hangPanel);
            }
            if (this._setupPanel.parent != null)
            {
                this._setupPanel.parent.removeChild(this._setupPanel);
            }
            this._topNav.selectpage = param1;
            if (param1 == 0)
            {
                addChild(this._hangPanel);
            }
            else if (param1 == 1)
            {
                addChild(this._setupPanel);
            }
            else if (param1 == 2)
            {
                addChild(this._detailPanel);
            }
            return;
        }// end function

        public function searchItem(param1)
        {
            var _loc_2:* = this.getMonsterByItem(param1);
            if (_loc_2.length > 0)
            {
                this.setMonsterList(_loc_2);
                this.setAvatar(_loc_2[0]);
                super.open();
            }
            else if (!this.searchItemID(param1))
            {
                Config.message(Config.language("MonsterIndexUI", 9));
            }
            return;
        }// end function

        public function searchItemID(param1:int) : Boolean
        {
            var _loc_3:* = undefined;
            var _loc_2:* = false;
            for (_loc_3 in Config._buy)
            {
                
                if (Config._buy[_loc_3].itemId == param1)
                {
                    if (Config._buy[_loc_3].shopsid == 10050)
                    {
                        Config.ui._shopUI.getitemlist(30015);
                        Config.ui._shopUI.scrollToItem(param1);
                        return true;
                    }
                    if (Config._buy[_loc_3].shopsid == 20050)
                    {
                        Config.ui._shopUI.btntop.selectpage = Config._buy[_loc_3].type;
                        Config.ui._shopUI.getitemlist222(20050);
                        Config.ui._shopUI.scrollToItem(param1);
                        return true;
                    }
                    if (Config._buy[_loc_3].shopsid == 10001)
                    {
                        Config.ui._blackmarket.open();
                        Config.ui._blackmarket.scrollToItem(param1);
                        return true;
                    }
                    if (Config._buy[_loc_3].shopsid == 10010)
                    {
                        _loc_2 = true;
                    }
                }
                if (Config.ui._shopmail._itemExistMap[param1])
                {
                    Config.ui._shopmail.openListPanel(0);
                    Config.ui._shopmail.scrollToItem(param1);
                    return true;
                }
                if (_loc_2)
                {
                    Config.ui._shopmail.giftcoupons();
                    Config.ui._shopmail.open();
                    Config.ui._shopmail.scrollToItemGift(param1);
                    return true;
                }
            }
            return false;
        }// end function

        override public function open(event:MouseEvent = null)
        {
            super.open();
            this.clear(true);
            var _loc_2:* = this.getMonsterNear(true, true);
            if (_loc_2.length == 0 || !isCanHang())
            {
                this.changePage(1);
            }
            else
            {
                this.setMonsterList(_loc_2, true);
                GuideUI.testDoId(41, this._panelArray[0]);
            }
            return;
        }// end function

        override public function close()
        {
            this.clear();
            if (this._avatarClip != null)
            {
                this._avatarClip.destroy();
                if (this._avatarClip.parent != null)
                {
                    this._avatarClip.parent.removeChild(this._avatarClip);
                }
                this._avatarClip = null;
            }
            super.close();
            return;
        }// end function

        private function handleAllMonsterClick(param1)
        {
            this.setMonsterList(this.getMonsterByFuzzy(""));
            return;
        }// end function

        private function setAvatar(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = undefined;
            var _loc_23:* = undefined;
            var _loc_25:* = undefined;
            var _loc_26:* = undefined;
            var _loc_27:* = undefined;
            var _loc_28:* = undefined;
            var _loc_29:* = undefined;
            var _loc_30:* = undefined;
            this._preAvatarId = param1;
            if (this._searchIT.text != "")
            {
                _loc_3 = this._searchIT.text;
            }
            var _loc_4:* = Config._monsterMap[param1];
            if (this._avatarClip != null)
            {
                this._avatarClip.destroy();
                if (this._avatarClip.parent != null)
                {
                    this._avatarClip.parent.removeChild(this._avatarClip);
                }
            }
            _loc_13 = this._listMap[param1];
            if (param2)
            {
                this._monsterList.setSelectedItem(_loc_13);
                this._monsterList.scrollToItem(_loc_13);
            }
            this._avatarClip = UnitClip.newUnitClip(Config._model[Number(_loc_4.model)]);
            this._avatarClip.setHue(Number(_loc_4.hue));
            this._avatarClip.changeStateTo("idle");
            this._avatarPanel.content.addChild(this._avatarClip);
            this._avatarClip.x = this._avatarPanel.width / 2;
            this._avatarClip.y = this._avatarPanel.height / 2 - this._avatarClip._yOff - this._avatarClip._height / 2;
            _loc_5 = DistrictMap.findMapFromMonster(Number(_loc_4.id));
            var _loc_14:* = {};
            if (_loc_5.length == 0)
            {
                for (_loc_6 in Config._monsterMap)
                {
                    
                    _loc_25 = Config._monsterMap[_loc_6];
                    _loc_7 = 1;
                    while (_loc_7 < 4)
                    {
                        
                        _loc_18 = Number(_loc_25["drop" + _loc_7]);
                        if (_loc_18 != 0 && _loc_18 == param1)
                        {
                            _loc_26 = DistrictMap.findMapFromMonster(_loc_25.id);
                            _loc_9 = 0;
                            while (_loc_9 < _loc_26.length)
                            {
                                
                                if (_loc_14[_loc_26[_loc_9]] != true)
                                {
                                    _loc_14[_loc_26[_loc_9]] = true;
                                    _loc_5.push(_loc_26[_loc_9]);
                                }
                                _loc_9 = _loc_9 + 1;
                            }
                        }
                        if (_loc_18 != 0 && Config._sonMap[_loc_18] != null)
                        {
                            for (_loc_8 in Config._sonMap[_loc_18])
                            {
                                
                                if (Number(Config._sonMap[_loc_18][_loc_8].item) == param1)
                                {
                                    _loc_26 = DistrictMap.findMapFromMonster(_loc_25.id);
                                    _loc_9 = 0;
                                    while (_loc_9 < _loc_26.length)
                                    {
                                        
                                        if (_loc_14[_loc_26[_loc_9]] != true)
                                        {
                                            _loc_14[_loc_26[_loc_9]] = true;
                                            _loc_5.push(_loc_26[_loc_9]);
                                        }
                                        _loc_9 = _loc_9 + 1;
                                    }
                                }
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
            }
            _loc_11 = "";
            _loc_12 = "";
            this.clearFlyBtn();
            for (_loc_6 in _loc_5)
            {
                
                _loc_15 = DistrictMap.realToMap(_loc_5[_loc_6]);
                _loc_10 = String(Config._mapMap[_loc_15].mapData.name);
                if (_loc_10 == "")
                {
                    _loc_10 = String(Config._mapMap[_loc_15].mapData.id);
                }
                if (_loc_3 == null || _loc_10.indexOf(_loc_3) == -1)
                {
                    _loc_11 = _loc_11 + (TextLink.link(_loc_10, _loc_15) + "\n");
                }
                else
                {
                    _loc_11 = _loc_11 + (TextLink.link(_loc_10, _loc_15, 13369344) + "\n");
                }
                _loc_12 = _loc_12 + (TextLink.link(Config.language("MonsterIndexUI", 10), _loc_15) + "\n");
                _loc_16 = Number(Config._mapMap[_loc_15].mapData.type);
                if (_loc_16 == 0 || _loc_16 == 1 || _loc_16 == 2 || _loc_16 == 6)
                {
                    _loc_17 = this.getFlyBtn(_loc_15);
                    this._detailPanel.addChild(_loc_17);
                    _loc_17.x = this._mapGoLB.x + 30;
                    _loc_17.y = this._mapGoLB.y + _loc_6 * 15 + 2;
                }
            }
            this._mapListLB.text = _loc_11;
            this._mapGoLB.text = _loc_12;
            _loc_11 = "";
            _loc_12 = "";
            _loc_23 = {};
            _loc_6 = 1;
            while (_loc_6 < 4)
            {
                
                _loc_18 = Number(_loc_4["drop" + _loc_6]);
                if (_loc_18 != 0 && Config._dropMap[_loc_18] != null)
                {
                    _loc_7 = 0;
                    while (_loc_7 < Config._dropMap[_loc_18].length)
                    {
                        
                        _loc_22 = Config._dropMap[_loc_18][_loc_7];
                        _loc_20 = Number(_loc_22.item);
                        _loc_13 = Config._itemMap[_loc_20];
                        if (_loc_13 != null)
                        {
                            if (!_loc_23[_loc_20] && _loc_20 != 90002 && _loc_20 != 90001)
                            {
                                _loc_23[_loc_20] = true;
                                _loc_19 = String(_loc_13.name);
                                if (_loc_3 == null || _loc_19.indexOf(_loc_3) == -1)
                                {
                                    _loc_11 = _loc_11 + (TextLink.link(_loc_19, _loc_20) + "\n");
                                }
                                else
                                {
                                    _loc_11 = _loc_11 + (TextLink.link(_loc_19, _loc_20, 13369344) + "\n");
                                }
                                _loc_21 = Number(_loc_22.prob);
                                if (_loc_21 < 1000)
                                {
                                    _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 11) + "\n");
                                }
                                else if (_loc_21 < 10000)
                                {
                                    _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 12) + "\n");
                                }
                                else if (_loc_21 < 50000)
                                {
                                    _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 13) + "\n");
                                }
                                else
                                {
                                    _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 14) + "\n");
                                }
                            }
                        }
                        _loc_7 = _loc_7 + 1;
                    }
                }
                _loc_6 = _loc_6 + 1;
            }
            var _loc_24:* = Config._toEliteMap[param1];
            if (Config._toEliteMap[param1] != null)
            {
                _loc_9 = 0;
                while (_loc_9 < _loc_24.length)
                {
                    
                    _loc_27 = _loc_24[_loc_9];
                    _loc_28 = Config._monsterMap[_loc_27];
                    _loc_29 = false;
                    if (_loc_27 != null)
                    {
                        _loc_6 = 1;
                        while (_loc_6 < 4)
                        {
                            
                            _loc_18 = Number(_loc_28["drop" + _loc_6]);
                            if (_loc_18 != 0 && Config._dropMap[_loc_18] != null)
                            {
                                _loc_7 = 0;
                                while (_loc_7 < Config._dropMap[_loc_18].length)
                                {
                                    
                                    _loc_22 = Config._dropMap[_loc_18][_loc_7];
                                    _loc_20 = Number(_loc_22.item);
                                    _loc_13 = Config._itemMap[_loc_20];
                                    if (_loc_13 != null)
                                    {
                                        if (!_loc_23[_loc_20] && _loc_20 != 90002 && _loc_20 != 90001)
                                        {
                                            if (!_loc_29)
                                            {
                                                _loc_29 = true;
                                                _loc_11 = _loc_11 + ("\n" + Config.language("MonsterIndexUI", 15) + "\n");
                                                _loc_12 = _loc_12 + "\n\n";
                                            }
                                            _loc_23[_loc_20] = true;
                                            _loc_19 = String(_loc_13.name);
                                            if (_loc_3 == null || _loc_19.indexOf(_loc_3) == -1)
                                            {
                                                _loc_11 = _loc_11 + (TextLink.link(_loc_19, _loc_20) + "\n");
                                            }
                                            else
                                            {
                                                _loc_11 = _loc_11 + (TextLink.link(_loc_19, _loc_20, 13369344) + "\n");
                                            }
                                            _loc_21 = Number(_loc_22.prob);
                                            if (_loc_21 < 1000)
                                            {
                                                _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 11) + "\n");
                                            }
                                            else if (_loc_21 < 10000)
                                            {
                                                _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 12) + "\n");
                                            }
                                            else if (_loc_21 < 50000)
                                            {
                                                _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 13) + "\n");
                                            }
                                            else
                                            {
                                                _loc_12 = _loc_12 + (Config.language("MonsterIndexUI", 14) + "\n");
                                            }
                                        }
                                    }
                                    _loc_7 = _loc_7 + 1;
                                }
                            }
                            _loc_6 = _loc_6 + 1;
                        }
                    }
                    _loc_9 = _loc_9 + 1;
                }
            }
            if (Config.player.level - Number(_loc_4.level) > -10)
            {
                this._dropListLB.text = _loc_11;
                this._dropProbLB.text = _loc_12;
            }
            else
            {
                this._dropListLB.text = "???";
                this._dropProbLB.text = "";
            }
            this._dropCanvas.verticalScrollPosition = 0;
            if (this._dropListLB.height > 13)
            {
                this._dropCanvas.verticalScrollPolicy = true;
            }
            else
            {
                this._dropCanvas.verticalScrollPolicy = false;
            }
            if (_loc_3 == null || String(_loc_4.name).indexOf(_loc_3) == -1)
            {
                this._descriptionTitleLB.textColor = Style.WINDOW_FONT;
            }
            else
            {
                this._descriptionTitleLB.textColor = 13369344;
            }
            if (Config.player.level - Number(_loc_4.level) > -10)
            {
                this._descriptionTitleLB.text = String(_loc_4.name) + "\nLv." + String(_loc_4.level) + "\nHP:" + Number(_loc_4.hp);
            }
            else
            {
                this._descriptionTitleLB.text = "???\nLv." + String(_loc_4.level);
                _loc_30 = new ColorMatrixFilter([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
                this._avatarClip.filters = [_loc_30];
            }
            this._selectedMonster = _loc_4;
            return;
        }// end function

        private function getDropStr(param1)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = null;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_2:* = Config._monsterMap[param1];
            var _loc_3:* = "";
            var _loc_11:* = {};
            if (this._tempTxt == null)
            {
                _loc_16 = Config.getSimpleTextField();
                this._tempTxt = _loc_16;
            }
            else
            {
                _loc_16 = this._tempTxt;
            }
            _loc_12 = 1;
            while (_loc_12 < 4)
            {
                
                _loc_5 = Number(_loc_2["drop" + _loc_12]);
                if (_loc_5 != 0 && Config._dropMap[_loc_5] != null)
                {
                    _loc_13 = 0;
                    while (_loc_13 < Config._dropMap[_loc_5].length)
                    {
                        
                        _loc_10 = Config._dropMap[_loc_5][_loc_13];
                        _loc_8 = Number(_loc_10.item);
                        _loc_7 = Config._itemMap[_loc_8];
                        if (_loc_7 != null)
                        {
                            if (!_loc_11[_loc_8] && _loc_8 != 90002 && _loc_8 != 90001)
                            {
                                _loc_11[_loc_8] = true;
                                _loc_6 = String(_loc_7.name);
                                _loc_4 = "<u><font color=\'#0099ff\'>" + _loc_6 + "</font></u>";
                                _loc_3 = _loc_3 + _loc_4;
                                _loc_16.htmlText = _loc_4;
                                _loc_15 = (_loc_16.width - 4) / 12 * 4;
                                while (_loc_15 < 40)
                                {
                                    
                                    _loc_3 = _loc_3 + " ";
                                    _loc_15 = _loc_15 + 1;
                                }
                                _loc_9 = Number(_loc_10.prob);
                                if (_loc_9 < 1000)
                                {
                                    _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 11) + "\n");
                                }
                                else if (_loc_9 < 10000)
                                {
                                    _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 12) + "\n");
                                }
                                else if (_loc_9 < 50000)
                                {
                                    _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 13) + "\n");
                                }
                                else
                                {
                                    _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 14) + "\n");
                                }
                            }
                        }
                        _loc_13 = _loc_13 + 1;
                    }
                }
                _loc_12 = _loc_12 + 1;
            }
            var _loc_17:* = Config._toEliteMap[param1];
            if (Config._toEliteMap[param1] != null)
            {
                _loc_14 = 0;
                while (_loc_14 < _loc_17.length)
                {
                    
                    _loc_18 = _loc_17[_loc_14];
                    _loc_19 = Config._monsterMap[_loc_18];
                    _loc_20 = false;
                    if (_loc_18 != null)
                    {
                        _loc_12 = 1;
                        while (_loc_12 < 4)
                        {
                            
                            _loc_5 = Number(_loc_19["drop" + _loc_12]);
                            if (_loc_5 != 0 && Config._dropMap[_loc_5] != null)
                            {
                                _loc_13 = 0;
                                while (_loc_13 < Config._dropMap[_loc_5].length)
                                {
                                    
                                    _loc_10 = Config._dropMap[_loc_5][_loc_13];
                                    _loc_8 = Number(_loc_10.item);
                                    _loc_7 = Config._itemMap[_loc_8];
                                    if (_loc_7 != null)
                                    {
                                        if (!_loc_11[_loc_8] && _loc_8 != 90002 && _loc_8 != 90001)
                                        {
                                            if (!_loc_20)
                                            {
                                                _loc_20 = true;
                                                _loc_3 = _loc_3 + ("\n" + Config.language("MonsterIndexUI", 15) + "\n");
                                            }
                                            _loc_11[_loc_8] = true;
                                            _loc_6 = String(_loc_7.name);
                                            _loc_4 = "<u><font color=\'#0099ff\'>" + _loc_6 + "</font></u>";
                                            _loc_3 = _loc_3 + _loc_4;
                                            _loc_16.htmlText = _loc_4;
                                            _loc_15 = (_loc_16.width - 4) / 12 * 4;
                                            while (_loc_15 < 40)
                                            {
                                                
                                                _loc_3 = _loc_3 + " ";
                                                _loc_15 = _loc_15 + 1;
                                            }
                                            _loc_9 = Number(_loc_10.prob);
                                            if (_loc_9 < 1000)
                                            {
                                                _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 11) + "\n");
                                            }
                                            else if (_loc_9 < 10000)
                                            {
                                                _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 12) + "\n");
                                            }
                                            else if (_loc_9 < 50000)
                                            {
                                                _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 13) + "\n");
                                            }
                                            else
                                            {
                                                _loc_3 = _loc_3 + (Config.language("MonsterIndexUI", 14) + "\n");
                                            }
                                        }
                                    }
                                    _loc_13 = _loc_13 + 1;
                                }
                            }
                            _loc_12 = _loc_12 + 1;
                        }
                    }
                    _loc_14 = _loc_14 + 1;
                }
            }
            if (_loc_3.length > 0)
            {
                _loc_3 = _loc_3.substring(0, (_loc_3.length - 1));
            }
            return _loc_3;
        }// end function

        private function clearFlyBtn() : void
        {
            var _loc_1:* = undefined;
            for (_loc_1 in this._flyBtnArray)
            {
                
                this._flyBtnArray[_loc_1].removeEventListener(MouseEvent.CLICK, this.flycheck);
                if (this._flyBtnArray[_loc_1].parent != null)
                {
                    this._flyBtnArray[_loc_1].parent.removeChild(this._flyBtnArray[_loc_1]);
                }
            }
            this._flyBtnArray = [];
            return;
        }// end function

        private function getFlyBtn(param1) : Sprite
        {
            var _loc_2:* = new Sprite();
            var _loc_3:* = new Bitmap();
            var _loc_4:* = Config.ui._mousepointer._cursorStack["jump"];
            _loc_3.bitmapData = _loc_4.bmpd;
            _loc_2.addChild(_loc_3);
            _loc_2.buttonMode = true;
            _loc_2.name = param1;
            _loc_2.addEventListener(MouseEvent.CLICK, this.flycheck);
            this._flyBtnArray.push(_loc_2);
            return _loc_2;
        }// end function

        private function flycheck(param1)
        {
            var _loc_2:* = param1.currentTarget.name;
            Config.ui._zoommap.flyMapAlert(_loc_2);
            return;
        }// end function

        private function mapFilter(param1:Array)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_6:* = [];
            _loc_2 = 0;
            while (_loc_2 < param1.length)
            {
                
                _loc_7 = 5;
                _loc_8 = false;
                _loc_9 = [];
                _loc_4 = "";
                _loc_3 = _loc_2 + 1;
                while (_loc_3 < param1.length)
                {
                    
                    if (param1[_loc_2] != param1[_loc_3])
                    {
                        while (param1[_loc_2].substring(0, _loc_7) == param1[_loc_3].substring(0, _loc_7) && _loc_7 < param1[_loc_2].length && _loc_7 < param1[_loc_3].length)
                        {
                            
                            _loc_4 = param1[_loc_2].substring(0, _loc_7);
                            _loc_8 = true;
                            _loc_7 = _loc_7 + 1;
                        }
                        if (_loc_8)
                        {
                            if (param1[_loc_3].indexOf(_loc_4) == 0)
                            {
                                param1.splice(_loc_3, 1);
                                _loc_3 = _loc_3 - 1;
                            }
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
                if (_loc_8)
                {
                    _loc_6.push(_loc_4.substring(0, (_loc_4.length - 1)));
                    param1.splice(_loc_2, 1);
                    _loc_2 = _loc_2 - 1;
                }
                else
                {
                    _loc_6.push(param1[_loc_2]);
                }
                _loc_2 = _loc_2 + 1;
            }
            return _loc_6;
        }// end function

        private function handleMonsterSelect(param1)
        {
            this.setAvatar(this._monsterList.selectedItem.data);
            return;
        }// end function

        private function handleSearchClick(param1)
        {
            this.setMonsterList(this.getMonsterByFuzzy(this._searchIT.text));
            return;
        }// end function

        public function get hanging()
        {
            return this._hanging;
        }// end function

        public function flagAllMonster()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = this.getMonsterNear(true, true);
            this.setMonsterList(_loc_2, true);
            if (this._monsterListBig != null)
            {
                _loc_1 = 0;
                while (_loc_1 < this._monsterListBig.length)
                {
                    
                    this._panelCheckBoxArray[_loc_1].selected = true;
                    _loc_1 = _loc_1 + 1;
                }
            }
            return;
        }// end function

        public function set hanging(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            if (this._hanging != param1)
            {
                this._hanging = param1;
                _loc_4 = [];
                if (this._monsterListBig != null && this._monsterListBig.length > 0)
                {
                    _loc_3 = 0;
                    while (_loc_3 < this._monsterListBig.length)
                    {
                        
                        if (this._panelCheckBoxArray[_loc_3].selected || this._hangMode1.selected)
                        {
                            _loc_4.push(this._monsterListBig[_loc_3]);
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
                if (_loc_4.length == 0)
                {
                    this._hanging = false;
                }
                Config.player.autoPickPath = Config.player.autoPickPath;
                if (this._hanging)
                {
                    Config.player.autoPick();
                    Config.player.clearHate();
                    GuideUI.testDoId(43);
                    Config.ui._taskpanel.stopAuto();
                    Config.player.addHalo(1172, 0, 1);
                    this._hangStartTime = getTimer();
                    Hang.selectedMap = DistrictMap.realMapId;
                    Hang.selectedTarget = _loc_4;
                    Hang.selectedTargetType = UNIT_TYPE_ENUM.TYPEID_UNIT;
                    Hang.lockPoint();
                    Hang.start(true);
                    if (this._hangMode1.selected)
                    {
                        Config.message(Config.language("MonsterIndexUI", 23));
                    }
                    Config.doingCookie = {act:"hangstart", selectedTarget:_loc_4};
                    this._hangPB.label = Config.language("MonsterIndexUI", 16);
                }
                else
                {
                    Config.player.removeHalo(1172);
                    if (this._hangStartTime != -1)
                    {
                        if (getTimer() - this._hangStartTime > 600000)
                        {
                            RollNotice.loop();
                        }
                        this._hangStartTime = -1;
                    }
                    Hang.stop(true);
                    this._hangPB.label = Config.language("MonsterIndexUI", 4);
                }
            }
            return;
        }// end function

        public function setHangState(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (this._monsterListBig == null)
            {
                this.setMonsterList(this.getMonsterNear(true, true), true);
            }
            _loc_2 = 0;
            while (_loc_2 < this._monsterListBig.length)
            {
                
                _loc_3 = 0;
                while (_loc_3 < param1.length)
                {
                    
                    if (this._monsterListBig[_loc_2] == param1[_loc_3])
                    {
                        this._panelCheckBoxArray[_loc_2].selected = true;
                    }
                    _loc_3 = _loc_3 + 1;
                }
                _loc_2 = _loc_2 + 1;
            }
            Config.player.addHalo(1172, 0, 1);
            this._hangStartTime = getTimer();
            this._hangPB.label = Config.language("MonsterIndexUI", 16);
            Config.doingCookie = {act:"hangstart", selectedTarget:param1};
            return;
        }// end function

        private function handleHangClick(param1)
        {
            if (isCanHang())
            {
                this.hanging = !this.hanging;
            }
            return;
        }// end function

        private function handleItemSelect(param1)
        {
            this.setMonsterList(this.getMonsterByItem(Number(param1.text)));
            return;
        }// end function

        private function handleMapGo(param1)
        {
            var _loc_2:* = param1.text;
            DistrictMap.goMap(_loc_2);
            return;
        }// end function

        private function handleMapSelect(param1)
        {
            this._searchIT.text = param1.text;
            this.setMonsterList(this.getMonsterByMap(Number(param1.text)));
            return;
        }// end function

        private function clear(param1 = true)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (param1)
            {
                _loc_2 = 0;
                while (_loc_2 < this._panelArray.length)
                {
                    
                    if (this._panelArray[_loc_2].parent != null)
                    {
                        this._panelArray[_loc_2].parent.removeChild(this._panelArray[_loc_2]);
                    }
                    if (this._panelClipArray[_loc_2] != null)
                    {
                        if (this._panelClipArray[_loc_2].parent != null)
                        {
                            this._panelClipArray[_loc_2].parent.removeChild(this._panelClipArray[_loc_2]);
                        }
                        this._panelClipArray[_loc_2].buttonMode = false;
                        this._panelClipArray[_loc_2].mouseEnabled = false;
                        this._panelClipArray[_loc_2].mouseChildren = false;
                        this._panelClipArray[_loc_2].removeEventListener(MouseEvent.CLICK, this.panelClipClick);
                        this._panelClipArray[_loc_2].destroy();
                        this._panelClipArray[_loc_2] = null;
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            if (this._setupPanel.parent == this)
            {
                removeChild(this._setupPanel);
            }
            if (this._detailPanel.parent == this)
            {
                removeChild(this._detailPanel);
            }
            if (this._hangPanel.parent == this)
            {
                removeChild(this._hangPanel);
            }
            this._selectedMonster = null;
            return;
        }// end function

        public function setMonsterList(param1:Array, param2 = false) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            if (param1.length == 0)
            {
                this._monsterListBig = [];
                if (param2)
                {
                    this.changePage(0);
                }
                else
                {
                    this.changePage(2);
                }
                return;
            }
            this._preMonsterList = param1;
            if (param2)
            {
                this.clear(true);
                this._monsterListBig = param1;
                _loc_8 = 0;
                _loc_9 = false;
                _loc_11 = (_width - param1.length * 80) / (param1.length + 1);
                for (_loc_3 in param1)
                {
                    
                    _loc_4 = this.getMonsterIcon(param1[_loc_3], _loc_8);
                    _loc_4.x = _loc_11 + _loc_8 * (80 + _loc_11);
                    _loc_4.y = 60;
                    _loc_8 = _loc_8 + 1;
                }
                this.changePage(0);
            }
            else
            {
                this.clear(false);
                _loc_12 = [];
                this._listMap = [];
                for (_loc_3 in param1)
                {
                    
                    _loc_7 = Config._monsterMap[param1[_loc_3]];
                    if (String(_loc_7.title) == "0")
                    {
                        _loc_12.push({label:_loc_7.name, data:param1[_loc_3], level:Number(_loc_7.level)});
                    }
                    else
                    {
                        _loc_12.push({label:_loc_7.title + " " + _loc_7.name, data:param1[_loc_3], level:Number(_loc_7.level)});
                    }
                    this._listMap[param1[_loc_3]] = _loc_12[(_loc_12.length - 1)];
                }
                _loc_12.sortOn("level", Array.NUMERIC);
                this._monsterList.itemArray = _loc_12;
                this.refreshMonsterList();
                this.changePage(2);
            }
            return;
        }// end function

        private function handleAvatarPbClick(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (this._selectedAvatarPB != _loc_2)
            {
                if (this._selectedAvatarPB != null)
                {
                    this._selectedAvatarPB.highlight = false;
                }
                this._selectedAvatarPB = _loc_2;
                this._selectedMonster = this._selectedAvatarPB.data;
                this._selectedAvatarPB.highlight = true;
            }
            return;
        }// end function

        private function handleAvatarPbDblClick(param1)
        {
            this.handleAvatarPbClick(param1);
            if (this._selectedMonster != null)
            {
                Hang.launchMonster(this._selectedMonster);
            }
            return;
        }// end function

        private function getMonsterIcon(param1, param2)
        {
            var _loc_3:* = Config._monsterMap[param1];
            if (param2 >= this._panelArray.length)
            {
                this._panelArray[param2] = new Panel(this._hangPanel);
                this._panelArray[param2].width = 80;
                this._panelArray[param2].height = 150;
                this._panelCheckBoxArray[param2] = new CheckBox(this._panelArray[param2], 35, 130, "", this.panelCheckChange);
                if (this._hangMode1.selected)
                {
                    this._panelCheckBoxArray[param2].enabled = false;
                }
                this._panelLabelArray[param2] = new ClickLabel(this._panelArray[param2], 0, 100, "");
                this._panelLabelArray[param2].addEventListener(MouseEvent.CLICK, this.handlePanelNameClick);
                this._panelLabelArray[param2].clickColor([39423, 52428]);
                this._panelLabelArray[param2].textColor = 16777215;
                this._panelLabelArray[param2].html = true;
                this._panelLabelArray[param2].mouseEnabled = true;
            }
            this._panelLabelArray[param2].text = "<u>" + TextLink.link("Lv." + _loc_3.level, param1) + "</u>";
            this._panelLabelArray[param2].x = (80 - this._panelLabelArray[param2].width) / 2;
            this._panelLabelArray[param2].data = param1;
            var _loc_4:* = UnitClip.newUnitClip(Config._model[Number(_loc_3.model)]);
            UnitClip.newUnitClip(Config._model[Number(_loc_3.model)]).changeStateTo("idle");
            if (_loc_3.hasOwnProperty("hue"))
            {
                _loc_4.setHue(Number(_loc_3.hue));
            }
            this._panelArray[param2].addChild(_loc_4);
            _loc_4.x = 40;
            _loc_4.y = 80;
            _loc_4.mouseEnabled = true;
            _loc_4.mouseChildren = true;
            _loc_4.buttonMode = true;
            _loc_4.data.checkBox = this._panelCheckBoxArray[param2];
            _loc_4.data.monsterid = param1;
            _loc_4.removeEventListener(MouseEvent.CLICK, this.panelClipClick);
            _loc_4.addEventListener(MouseEvent.CLICK, this.panelClipClick);
            _loc_4.addEventListener(MouseEvent.ROLL_OVER, this.handlePanelNameRollOver);
            _loc_4.addEventListener(MouseEvent.ROLL_OUT, this.handlePanelNameRollOut);
            this._panelClipArray[param2] = _loc_4;
            this._hangPanel.addChild(this._panelArray[param2]);
            return this._panelArray[param2];
        }// end function

        private function panelCheckChange(param1)
        {
            if (GuideUI.testId(42))
            {
                GuideUI.doId(42, this._hangPB);
            }
            else if (GuideUI.testId(158))
            {
                GuideUI.doId(158, this._hangPB);
            }
            if (this.hanging)
            {
                this._hanging = false;
                this.hanging = true;
            }
            return;
        }// end function

        private function panelClipClick(param1)
        {
            if (GuideUI.testId(42))
            {
                GuideUI.doId(42, this._hangPB);
            }
            else if (GuideUI.testId(158))
            {
                GuideUI.doId(158, this._hangPB);
            }
            if (!this._hangMode1.selected)
            {
                param1.currentTarget.data.checkBox.selected = !param1.currentTarget.data.checkBox.selected;
                if (this.hanging)
                {
                    this._hanging = false;
                    this.hanging = true;
                }
            }
            return;
        }// end function

        private function handleMapLink(event:TextEvent)
        {
            this.setMonsterList(this.getMonsterByMap(Number(event.text)));
            return;
        }// end function

        public function getMonsterByFuzzy(param1:String, param2:Boolean = false) : Array
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            this._searchIT.text = param1;
            var _loc_5:* = {};
            var _loc_6:* = [];
            _loc_3 = this.getMonsterByName(param1, param2);
            if (_loc_3.length != 0)
            {
                if (_loc_3.length > 0)
                {
                    for (_loc_4 in _loc_3)
                    {
                        
                        if (_loc_5[_loc_3[_loc_4]] != true)
                        {
                            _loc_5[_loc_3[_loc_4]] = true;
                            _loc_6.push(_loc_3[_loc_4]);
                        }
                    }
                }
            }
            if (param1 == "")
            {
                return _loc_6;
            }
            if (param1.length > 0)
            {
                _loc_3 = this.getMonsterByMapName(param1, param2);
                if (_loc_3.length != 0)
                {
                    for (_loc_4 in _loc_3)
                    {
                        
                        if (_loc_5[_loc_3[_loc_4]] != true)
                        {
                            _loc_5[_loc_3[_loc_4]] = true;
                            _loc_6.push(_loc_3[_loc_4]);
                        }
                    }
                }
            }
            if (param1.length > 0)
            {
                _loc_3 = this.getMonsterByItemName(param1, param2);
                if (_loc_3.length != 0)
                {
                    for (_loc_4 in _loc_3)
                    {
                        
                        if (_loc_5[_loc_3[_loc_4]] != true)
                        {
                            _loc_5[_loc_3[_loc_4]] = true;
                            _loc_6.push(_loc_3[_loc_4]);
                        }
                    }
                }
            }
            return _loc_6;
        }// end function

        public function getMonsterByItem(param1, param2:Boolean = false) : Array
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_13:* = undefined;
            this._searchIT.text = String(Config._itemMap[param1].name);
            var _loc_6:* = [];
            var _loc_11:* = {};
            var _loc_12:* = [];
            for (_loc_4 in Config._monsterMap)
            {
                
                _loc_8 = Config._monsterMap[_loc_4];
                if (String(_loc_8.name) != "0" && Number(_loc_8.model) != 0)
                {
                    if (Number(_loc_8.type) == 0 || Number(_loc_8.type) == 2 || !param2 && (Number(_loc_8.type) == 3 || Number(_loc_8.type) == 4))
                    {
                        _loc_5 = 1;
                        while (_loc_5 < 4)
                        {
                            
                            _loc_9 = Number(_loc_8["drop" + _loc_5]);
                            if (_loc_9 != 0)
                            {
                                _loc_10 = Config._dropMap[_loc_9];
                                if (_loc_10 != null)
                                {
                                    _loc_3 = 0;
                                    while (_loc_3 < _loc_10.length)
                                    {
                                        
                                        if (Number(_loc_10[_loc_3].item) == param1)
                                        {
                                            if (Number(_loc_8.type) == 2)
                                            {
                                                _loc_13 = Config._eliteToMap[_loc_4];
                                                if (_loc_13 != null)
                                                {
                                                    if (_loc_11[_loc_13] != true)
                                                    {
                                                        _loc_11[_loc_13] = true;
                                                        _loc_12.push(_loc_13);
                                                    }
                                                }
                                            }
                                            else if (_loc_11[_loc_4] != true)
                                            {
                                                _loc_11[_loc_4] = true;
                                                _loc_12.push(_loc_4);
                                            }
                                        }
                                        _loc_3 = _loc_3 + 1;
                                    }
                                }
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                    }
                }
            }
            return _loc_12;
        }// end function

        public function getMonsterByItemName(param1:String, param2:Boolean = false) : Array
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_13:* = undefined;
            this._searchIT.text = param1;
            var _loc_6:* = [];
            var _loc_11:* = {};
            var _loc_12:* = [];
            for (_loc_4 in Config._monsterMap)
            {
                
                _loc_8 = Config._monsterMap[_loc_4];
                if (String(_loc_8.name) != "0" && Number(_loc_8.model) != 0)
                {
                    if (Number(_loc_8.type) == 0 || Number(_loc_8.type) == 2 || !param2 && (Number(_loc_8.type) == 3 || Number(_loc_8.type) == 4))
                    {
                        _loc_5 = 1;
                        while (_loc_5 < 4)
                        {
                            
                            _loc_9 = Number(_loc_8["drop" + _loc_5]);
                            if (_loc_9 != 0)
                            {
                                _loc_10 = Config._dropMap[_loc_9];
                                if (_loc_10 != null)
                                {
                                    _loc_3 = 0;
                                    while (_loc_3 < _loc_10.length)
                                    {
                                        
                                        if (Config._itemMap[Number(_loc_10[_loc_3].item)] != null)
                                        {
                                            if (String(Config._itemMap[Number(_loc_10[_loc_3].item)].name).indexOf(param1) != -1)
                                            {
                                                if (Number(_loc_8.type) == 2)
                                                {
                                                    _loc_13 = Config._eliteToMap[_loc_4];
                                                    if (_loc_13 != null)
                                                    {
                                                        if (_loc_11[_loc_13] != true)
                                                        {
                                                            _loc_11[_loc_13] = true;
                                                            _loc_12.push(_loc_13);
                                                        }
                                                    }
                                                }
                                                else if (_loc_11[_loc_4] != true)
                                                {
                                                    _loc_11[_loc_4] = true;
                                                    _loc_12.push(_loc_4);
                                                }
                                            }
                                        }
                                        _loc_3 = _loc_3 + 1;
                                    }
                                }
                            }
                            _loc_5 = _loc_5 + 1;
                        }
                    }
                }
            }
            return _loc_12;
        }// end function

        public function getMonsterNear(param1:Boolean = false, param2 = false) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            if (isCanHang())
            {
                _loc_3 = DistrictMap.findMonsterNear();
                _loc_5 = [];
                for (_loc_4 in _loc_3)
                {
                    
                    if (Config._monsterMap[_loc_3[_loc_4]].name != "0" && Config._monsterMap[_loc_3[_loc_4]].model != 0)
                    {
                        if (Config._monsterMap[_loc_3[_loc_4]].type == 0 || !param1 && (Config._monsterMap[_loc_3[_loc_4]].type == 3 || Config._monsterMap[_loc_3[_loc_4]].type == 4))
                        {
                            if (DistrictMap.findMapFromMonster(_loc_3[_loc_4]).length > 0)
                            {
                                _loc_5.push(_loc_3[_loc_4]);
                            }
                        }
                    }
                }
                return _loc_5;
            }
            else
            {
                return [];
            }
        }// end function

        public function getMonsterByMap(param1, param2:Boolean = false, param3 = false) : Array
        {
            var _loc_6:* = undefined;
            if (!param3)
            {
                this._searchIT.text = String(Config._mapMap[param1].mapData.name);
            }
            var _loc_4:* = Config._mapMap[param1];
            if (Config._mapMap[param1] == null)
            {
                return [];
            }
            var _loc_5:* = DistrictMap.findMonsterFromMap(param1);
            var _loc_7:* = [];
            for (_loc_6 in _loc_5)
            {
                
                if (String(Config._monsterMap[_loc_5[_loc_6]].name) != "0" && Number(Config._monsterMap[_loc_5[_loc_6]].model) != 0)
                {
                    if (Number(Config._monsterMap[_loc_5[_loc_6]].type) == 0 || !param2 && (Number(Config._monsterMap[_loc_5[_loc_6]].type) == 3 || Number(Config._monsterMap[_loc_5[_loc_6]].type) == 4))
                    {
                        if (DistrictMap.findMapFromMonster(_loc_5[_loc_6]).length > 0)
                        {
                            _loc_7.push(_loc_5[_loc_6]);
                        }
                    }
                }
            }
            return _loc_7;
        }// end function

        public function getMonsterByMapName(param1:String, param2:Boolean = false) : Array
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_7:* = null;
            var _loc_9:* = undefined;
            var _loc_6:* = [];
            for (_loc_3 in DistrictMap._mapNameMap)
            {
                
                if (String(_loc_3).indexOf(param1) != -1)
                {
                    _loc_6.push(DistrictMap._mapNameMap[_loc_3]);
                }
            }
            if (_loc_6.length == 0)
            {
                return [];
            }
            var _loc_8:* = [];
            _loc_4 = 0;
            while (_loc_4 < _loc_6.length)
            {
                
                _loc_7 = DistrictMap.findMonsterFromMap(_loc_6[_loc_4]);
                for (_loc_3 in _loc_7)
                {
                    
                    if (String(Config._monsterMap[_loc_7[_loc_3]].name) != "0" && Number(Config._monsterMap[_loc_7[_loc_3]].model) != 0)
                    {
                        if (Number(Config._monsterMap[_loc_7[_loc_3]].type) == 0 || !param2 && (Number(Config._monsterMap[_loc_7[_loc_3]].type) == 3 || Number(Config._monsterMap[_loc_7[_loc_3]].type) == 4))
                        {
                            if (DistrictMap.findMapFromMonster(_loc_7[_loc_3]).length > 0)
                            {
                                _loc_9 = true;
                                for (_loc_5 in _loc_8)
                                {
                                    
                                    if (_loc_7[_loc_3] == _loc_8[_loc_5])
                                    {
                                        _loc_9 = false;
                                        break;
                                    }
                                }
                                if (_loc_9)
                                {
                                    _loc_8.push(_loc_7[_loc_3]);
                                }
                            }
                        }
                    }
                }
                _loc_4 = _loc_4 + 1;
            }
            return _loc_8;
        }// end function

        public function getMonsterByName(param1:String, param2:Boolean = false) : Array
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_3:* = [];
            for (_loc_4 in Config._monsterMap)
            {
                
                if (String(Config._monsterMap[_loc_4].name) != "0" && Number(Config._monsterMap[_loc_4].model) != 0)
                {
                    if (Number(Config._monsterMap[_loc_4].type) == 0 || !param2 && (Number(Config._monsterMap[_loc_4].type) == 3 || Number(Config._monsterMap[_loc_4].type) == 4))
                    {
                        if (String(Config._monsterMap[_loc_4].name).indexOf(param1) != -1)
                        {
                            if (DistrictMap.findMapFromMonster(_loc_4).length > 0)
                            {
                                _loc_3.push(_loc_4);
                                continue;
                            }
                            _loc_7 = false;
                            for (_loc_5 in Config._sonMap)
                            {
                                
                                for (_loc_6 in Config._sonMap[_loc_5])
                                {
                                    
                                    if (Number(Config._sonMap[_loc_5][_loc_6].item) == _loc_4)
                                    {
                                        _loc_3.push(_loc_4);
                                        _loc_7 = true;
                                        break;
                                    }
                                }
                                if (_loc_7)
                                {
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            return _loc_3;
        }// end function

        public function openMonster(param1)
        {
            super.open();
            this._searchIT.text = String(param1.name);
            this.setMonsterList(this.getMonsterByName(param1.name));
            this.setAvatar(param1, true);
            return;
        }// end function

        public static function isCanHang()
        {
            if (Config.map.data != null && Config.map.data.type != 0)
            {
                return true;
            }
            return false;
        }// end function

    }
}
