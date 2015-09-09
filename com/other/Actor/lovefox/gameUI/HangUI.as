package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import lovefox.game.*;
    import lovefox.unit.*;

    public class HangUI extends Sprite
    {
        private var _limitedHangNS:NumericStepper;
        private var _hanging:Boolean = false;
        private var _hangSwitchBtn:PushButton;
        private var _hpUseCB1:ComboBox;
        private var _hpConCB1:ComboBox;
        private var _hpUseCB2:ComboBox;
        private var _hpConCB2:ComboBox;
        private var _mpUseCB1:ComboBox;
        private var _mpConCB1:ComboBox;
        private var _mpUseCB2:ComboBox;
        private var _mpConCB2:ComboBox;
        private var _conArray1:Array;
        private var _conArray2:Array;
        private var _hpUseArray:Array;
        private var _mpUseArray:Array;
        private var _pickFilterCB:Array;
        private var _pickFilterDetail:Panel;
        private var _pickFilterQuality0:int = 0;
        private var _pickFilterLevel0:int = 0;
        private var _pickFilterQuality1:int = 0;
        private var _pickFilterLevel1:int = 0;
        private var _pickFilterPb0:PushButton;
        private var _noAutoJustUseCB:CheckBox;
        private var _attackSkillSlotArray:Array;
        private var _buffSkillSlotArray:Array;
        private var _buffItemSlotArray:Array;
        private var _ready:Boolean = false;
        private var _filterLevel:Array;
        private var _filterQuality:Array;
        private var _slotList:SlotList;
        private var _preSelectSkillSlot:DualSlot;
        private static var _qualityMap:Object = {};
        private static var _levelMap:Object = {};
        private static var _detailFilterPanel:Panel;

        public function HangUI()
        {
            this._conArray1 = [];
            this._conArray2 = [];
            this._hpUseArray = [];
            this._mpUseArray = [];
            this._pickFilterCB = [];
            this._attackSkillSlotArray = [];
            this._buffSkillSlotArray = [];
            this._buffItemSlotArray = [];
            this._filterLevel = [{label:Config.language("HangUI", 17), value:0}, {label:Config.language("HangUI", 18), value:10}, {label:Config.language("HangUI", 19), value:20}, {label:Config.language("HangUI", 20), value:30}, {label:Config.language("HangUI", 21), value:40}, {label:Config.language("HangUI", 22), value:50}, {label:Config.language("HangUI", 23), value:60}];
            this._filterQuality = [{label:Config.language("HangUI", 24), value:0}, {label:Config.language("HangUI", 25), value:1}, {label:Config.language("HangUI", 26), value:2}, {label:Config.language("HangUI", 27), value:3}, {label:Config.language("HangUI", 28), value:4}, {label:Config.language("HangUI", 29), value:5}];
            this.init();
            this.initDraw();
            return;
        }// end function

        private function getEquipLevel(param1)
        {
            return Config._itemMap[param1].reqLevel;
        }// end function

        private function getEquipQuality(param1)
        {
            var _loc_2:* = Config._itemMap[param1].name;
            if (_loc_2.indexOf("D") != -1)
            {
                return 1;
            }
            if (_loc_2.indexOf("C") != -1)
            {
                return 2;
            }
            if (_loc_2.indexOf("B") != -1)
            {
                return 3;
            }
            if (_loc_2.indexOf("A") != -1)
            {
                return 4;
            }
            return 0;
        }// end function

        private function init()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            for (_loc_1 in Config._formula)
            {
                
                _loc_3 = Number(Config._formula[_loc_1].outmater);
                _loc_2 = 1;
                while (_loc_2 < 7)
                {
                    
                    _loc_4 = Config._formula[_loc_1]["materialid" + _loc_2];
                    if (_loc_4 != 0)
                    {
                        _qualityMap[_loc_4] = this.getEquipQuality(_loc_3);
                        _levelMap[_loc_4] = this.getEquipLevel(_loc_3);
                    }
                    _loc_2 = _loc_2 + 1;
                }
            }
            return;
        }// end function

        public function getItemPick(param1)
        {
            var _loc_2:* = Config._itemMap[param1];
            if (_loc_2.type == 19 && _loc_2.subType == 2)
            {
                if (this._pickFilterCB[6].selected)
                {
                    return true;
                }
                return false;
            }
            else
            {
                if (_loc_2.type == 2 && _loc_2.subType == 0)
                {
                    if (this._pickFilterCB[0].selected)
                    {
                        return true;
                    }
                    return false;
                }
                else
                {
                    if (_loc_2.type == 2 && _loc_2.subType == 1)
                    {
                        if (this._pickFilterCB[1].selected)
                        {
                            return true;
                        }
                        return false;
                    }
                    else
                    {
                        if (_loc_2.type == 7)
                        {
                            if (this._pickFilterCB[2].selected)
                            {
                                return true;
                            }
                            return false;
                        }
                        else
                        {
                            if (_loc_2.type == 19)
                            {
                                if (this._pickFilterCB[3].selected)
                                {
                                    if (this.checkQuality(this.getQuality(param1), 0) && this.getLevel(param1) >= this._pickFilterLevel0)
                                    {
                                        return true;
                                    }
                                    return false;
                                }
                                else
                                {
                                    return false;
                                }
                            }
                            else
                            {
                                if (_loc_2.type == 10)
                                {
                                    if (this._pickFilterCB[4].selected)
                                    {
                                        return true;
                                    }
                                    return false;
                                }
                                else
                                {
                                    if (_loc_2.type == 12)
                                    {
                                        if (this._pickFilterCB[5].selected)
                                        {
                                            return true;
                                        }
                                        return false;
                                    }
                                    else
                                    {
                                        if (_loc_2.type == 18)
                                        {
                                            if (this._pickFilterCB[7].selected)
                                            {
                                                if (this.checkQuality(this.getQuality(param1), 1) && this.getLevel(param1) >= this._pickFilterLevel1)
                                                {
                                                    return true;
                                                }
                                                return false;
                                            }
                                            else
                                            {
                                                return false;
                                            }
                                        }
                                        else
                                        {
                                            return true;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }// end function

        private function checkQuality(param1, param2)
        {
            var _loc_3:* = undefined;
            if (param2 == 0)
            {
                _loc_3 = this._pickFilterQuality0;
            }
            else
            {
                _loc_3 = this._pickFilterQuality1;
            }
            if (_loc_3 == 0)
            {
                return true;
            }
            if (_loc_3 == 1)
            {
                if (param1 == 0)
                {
                    return true;
                }
                return false;
            }
            else
            {
                if (param1 >= (_loc_3 - 1))
                {
                    return true;
                }
                return false;
            }
        }// end function

        private function getQuality(param1)
        {
            var _loc_2:* = Config._itemMap[param1];
            if (_loc_2.type == 18)
            {
                return this.getEquipQuality(param1);
            }
            if (_loc_2.type == 19)
            {
                return _qualityMap[param1];
            }
            return 0;
        }// end function

        private function getLevel(param1)
        {
            var _loc_2:* = Config._itemMap[param1];
            if (_loc_2.type == 18)
            {
                return this.getEquipLevel(param1);
            }
            if (_loc_2.type == 19)
            {
                return _levelMap[param1];
            }
            return 0;
        }// end function

        private function handleCBChange(param1)
        {
            this.testOppCB(param1.currentTarget);
            this.setCookie();
            return;
        }// end function

        private function testOppCB(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            if (param1 == this._hpConCB1)
            {
                _loc_2 = this._hpConCB2;
                _loc_3 = this._conArray1;
            }
            else if (param1 == this._hpConCB2)
            {
                _loc_2 = this._hpConCB1;
                _loc_3 = this._conArray2;
            }
            else if (param1 == this._mpConCB1)
            {
                _loc_2 = this._mpConCB2;
                _loc_3 = this._conArray1;
            }
            else if (param1 == this._mpConCB2)
            {
                _loc_2 = this._mpConCB1;
                _loc_3 = this._conArray2;
            }
            else if (param1 == this._hpUseCB1)
            {
                _loc_2 = this._hpUseCB2;
                _loc_3 = this._hpUseArray;
            }
            else if (param1 == this._hpUseCB2)
            {
                _loc_2 = this._hpUseCB1;
                _loc_3 = this._hpUseArray;
            }
            else if (param1 == this._mpUseCB1)
            {
                _loc_2 = this._mpUseCB2;
                _loc_3 = this._mpUseArray;
            }
            else if (param1 == this._mpUseCB2)
            {
                _loc_2 = this._mpUseCB1;
                _loc_3 = this._mpUseArray;
            }
            var _loc_5:* = _loc_3.concat();
            _loc_4 = 0;
            while (_loc_4 < _loc_5.length)
            {
                
                if (_loc_5[_loc_4] == param1.selectedItem && _loc_5[_loc_4].id != -1 && _loc_5[_loc_4].value != -1)
                {
                    _loc_5.splice(_loc_4, 1);
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_2.itemArray = _loc_5;
            return;
        }// end function

        public function freshUseList()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            this.freshHpUseList();
            this.freshMpUseList();
            if (this._hpUseCB1.selectedItem.id != -1 && this._hpUseCB1.selectedItem.id != 0)
            {
                _loc_1 = false;
                _loc_2 = 0;
                while (_loc_2 < this._hpUseArray.length)
                {
                    
                    if (this._hpUseArray[_loc_2].id != -1 && this._hpUseArray[_loc_2].id != 0)
                    {
                        if (this._hpUseCB1.selectedItem.id == this._hpUseArray[_loc_2].id)
                        {
                            _loc_1 = true;
                            break;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (!_loc_1)
                {
                    _loc_4 = this._hpUseCB1.selectedItem.label.substring(0, this._hpUseCB1.selectedItem.label.indexOf(" × ")) + " × " + 0;
                    _loc_3 = {label:_loc_4, id:this._hpUseCB1.selectedItem.id, amount:0};
                    this._hpUseArray.push(_loc_3);
                }
            }
            if (this._hpUseCB2.selectedItem.id != -1 && this._hpUseCB2.selectedItem.id != 0)
            {
                _loc_1 = false;
                _loc_2 = 0;
                while (_loc_2 < this._hpUseArray.length)
                {
                    
                    if (this._hpUseArray[_loc_2].id != -1 && this._hpUseArray[_loc_2].id != 0)
                    {
                        if (this._hpUseCB2.selectedItem.id == this._hpUseArray[_loc_2].id)
                        {
                            _loc_1 = true;
                            break;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (!_loc_1)
                {
                    _loc_4 = this._hpUseCB2.selectedItem.label.substring(0, this._hpUseCB2.selectedItem.label.indexOf(" × ")) + " × " + 0;
                    _loc_3 = {label:_loc_4, id:this._hpUseCB2.selectedItem.id, amount:0};
                    this._hpUseArray.push(_loc_3);
                }
            }
            if (this._mpUseCB1.selectedItem.id != -1 && this._mpUseCB1.selectedItem.id != 0)
            {
                _loc_1 = false;
                _loc_2 = 0;
                while (_loc_2 < this._mpUseArray.length)
                {
                    
                    if (this._mpUseArray[_loc_2].id != -1 && this._mpUseArray[_loc_2].id != 0)
                    {
                        if (this._mpUseCB1.selectedItem.id == this._mpUseArray[_loc_2].id)
                        {
                            _loc_1 = true;
                            break;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (!_loc_1)
                {
                    _loc_4 = this._mpUseCB1.selectedItem.label.substring(0, this._mpUseCB1.selectedItem.label.indexOf(" × ")) + " × " + 0;
                    _loc_3 = {label:_loc_4, id:this._mpUseCB1.selectedItem.id, amount:0};
                    this._mpUseArray.push(_loc_3);
                }
            }
            if (this._mpUseCB2.selectedItem.id != -1 && this._mpUseCB2.selectedItem.id != 0)
            {
                _loc_1 = false;
                _loc_2 = 0;
                while (_loc_2 < this._mpUseArray.length)
                {
                    
                    if (this._mpUseArray[_loc_2].id != -1 && this._mpUseArray[_loc_2].id != 0)
                    {
                        if (this._mpUseCB2.selectedItem.id == this._mpUseArray[_loc_2].id)
                        {
                            _loc_1 = true;
                            break;
                        }
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (!_loc_1)
                {
                    _loc_4 = this._mpUseCB2.selectedItem.label.substring(0, this._mpUseCB2.selectedItem.label.indexOf(" × ")) + " × " + 0;
                    _loc_3 = {label:_loc_4, id:this._mpUseCB2.selectedItem.id, amount:0};
                    this._mpUseArray.push(_loc_3);
                }
            }
            this._hpUseCB1.itemArray = this._hpUseArray;
            this._hpUseCB2.itemArray = this._hpUseArray;
            this._mpUseCB1.itemArray = this._mpUseArray;
            this._mpUseCB2.itemArray = this._mpUseArray;
            this.testOppCB(this._hpUseCB1);
            this.testOppCB(this._mpUseCB1);
            var _loc_5:* = this._hpUseCB1.selectedItem.id;
            var _loc_6:* = this._hpUseCB2.selectedItem.id;
            var _loc_7:* = this._mpUseCB1.selectedItem.id;
            var _loc_8:* = this._mpUseCB2.selectedItem.id;
            this._hpUseCB1.selectedItem = this._hpUseCB1.itemArray[0];
            _loc_2 = 0;
            while (_loc_2 < this._hpUseCB1.itemArray.length)
            {
                
                if (this._hpUseCB1.itemArray[_loc_2].id == _loc_5)
                {
                    this._hpUseCB1.selectedItem = this._hpUseCB1.itemArray[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._hpUseCB2.selectedItem = this._hpUseCB2.itemArray[0];
            _loc_2 = 0;
            while (_loc_2 < this._hpUseCB2.itemArray.length)
            {
                
                if (this._hpUseCB2.itemArray[_loc_2].id == _loc_6)
                {
                    this._hpUseCB2.selectedItem = this._hpUseCB2.itemArray[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._mpUseCB1.selectedItem = this._mpUseCB1.itemArray[0];
            _loc_2 = 0;
            while (_loc_2 < this._mpUseCB1.itemArray.length)
            {
                
                if (this._mpUseCB1.itemArray[_loc_2].id == _loc_7)
                {
                    this._mpUseCB1.selectedItem = this._mpUseCB1.itemArray[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._mpUseCB2.selectedItem = this._mpUseCB2.itemArray[0];
            _loc_2 = 0;
            while (_loc_2 < this._mpUseCB2.itemArray.length)
            {
                
                if (this._mpUseCB2.itemArray[_loc_2].id == _loc_8)
                {
                    this._mpUseCB2.selectedItem = this._mpUseCB2.itemArray[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.setCookie();
            return;
        }// end function

        public function freshSkillUpdate(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < this._attackSkillSlotArray.length)
            {
                
                if (this._attackSkillSlotArray[_loc_2] != null)
                {
                    if (this._attackSkillSlotArray[_loc_2].skill != null)
                    {
                        _loc_3 = this._attackSkillSlotArray[_loc_2].skill;
                        if (Number(_loc_3._skillData.baseId) == Number(param1.baseId))
                        {
                            this._attackSkillSlotArray[_loc_2].skill = Skill.getSkill(Number(param1.id));
                            this.setCookie();
                            break;
                        }
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function removeSkillUpdate(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < this._attackSkillSlotArray.length)
            {
                
                if (this._attackSkillSlotArray[_loc_2] != null)
                {
                    if (this._attackSkillSlotArray[_loc_2].skill != null)
                    {
                        _loc_3 = this._attackSkillSlotArray[_loc_2].skill;
                        if (Number(_loc_3._skillData.baseId) == Number(param1.baseId))
                        {
                            this._attackSkillSlotArray[_loc_2].skill = null;
                            this.setCookie();
                            break;
                        }
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function freshHpUseList()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            this._hpUseArray = [{label:Config.language("HangUI", 2), id:-1}, {label:Config.language("HangUI", 3), id:0}];
            var _loc_7:* = {};
            for (_loc_1 in Config.ui._charUI._itemArray)
            {
                
                _loc_2 = Config.ui._charUI._itemArray[_loc_1];
                if (_loc_2._itemData.type == 2 && _loc_2._itemData.subType == 1)
                {
                    if (_loc_2._itemData.skillId != 0)
                    {
                        _loc_4 = Config._skillMap[_loc_2._itemData.skillId];
                        if (_loc_4.targetType == 1)
                        {
                            _loc_6 = false;
                            if ((_loc_4.damageHpMpOther == 0 || _loc_4.damageHpMpOther == 4 || _loc_4.damageHpMpOther == 6 || _loc_4.damageHpMpOther == 7 || _loc_4.damageHpMpOther == 8) && _loc_4.skillDamage < 0)
                            {
                                _loc_6 = true;
                            }
                            else if (_loc_4.addState != 0)
                            {
                                _loc_5 = Config._buffMap[_loc_4.addState];
                                if ((_loc_5.result == 0 || _loc_5.result == 4 || _loc_5.result == 6 || _loc_5.result == 7 || _loc_5.result == 8) && _loc_5.skillDmg < 0)
                                {
                                    _loc_6 = true;
                                }
                            }
                            if (_loc_6)
                            {
                                if (_loc_7[_loc_2._itemData.baseID] == null)
                                {
                                    _loc_3 = {label:_loc_2.name + " × " + _loc_2.amount, id:_loc_2._itemData.baseID, amount:_loc_2.amount, item:_loc_2};
                                    this._hpUseArray.push(_loc_3);
                                    _loc_7[_loc_2._itemData.baseID] = _loc_3;
                                    continue;
                                }
                                _loc_7[_loc_2._itemData.baseID].amount = _loc_7[_loc_2._itemData.baseID].amount + _loc_2.amount;
                                _loc_7[_loc_2._itemData.baseID].label = _loc_2.name + " × " + _loc_7[_loc_2._itemData.baseID].amount;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        private function freshMpUseList()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            this._mpUseArray = [{label:Config.language("HangUI", 2), id:-1}, {label:Config.language("HangUI", 3), id:0}];
            var _loc_7:* = {};
            for (_loc_1 in Config.ui._charUI._itemArray)
            {
                
                _loc_2 = Config.ui._charUI._itemArray[_loc_1];
                if (_loc_2._itemData.type == 2 && _loc_2._itemData.subType == 1)
                {
                    if (_loc_2._itemData.skillId != 0)
                    {
                        _loc_4 = Config._skillMap[_loc_2._itemData.skillId];
                        if (_loc_4.targetType == 1)
                        {
                            _loc_6 = false;
                            if ((_loc_4.damageHpMpOther == 1 || _loc_4.damageHpMpOther == 5 || _loc_4.damageHpMpOther == 6) && _loc_4.skillDamage < 0)
                            {
                                _loc_6 = true;
                            }
                            else if (_loc_4.addState != 0)
                            {
                                _loc_5 = Config._buffMap[_loc_4.addState];
                                if ((_loc_5.result == 1 || _loc_5.result == 5 || _loc_5.result == 6) && _loc_5.skillDmg < 0 || _loc_5.result == 0 && _loc_5.mpDmg < 0)
                                {
                                    _loc_6 = true;
                                }
                            }
                            if (_loc_6)
                            {
                                if (_loc_7[_loc_2._itemData.baseID] == null)
                                {
                                    _loc_3 = {label:_loc_2.name + " × " + _loc_2.amount, id:_loc_2._itemData.baseID, amount:_loc_2.amount, item:_loc_2};
                                    this._mpUseArray.push(_loc_3);
                                    _loc_7[_loc_2._itemData.baseID] = _loc_3;
                                    continue;
                                }
                                _loc_7[_loc_2._itemData.baseID].amount = _loc_7[_loc_2._itemData.baseID].amount + _loc_2.amount;
                                _loc_7[_loc_2._itemData.baseID].label = _loc_2.name + " × " + _loc_7[_loc_2._itemData.baseID].amount;
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        public function getNoAutoJustUse()
        {
            if (Config.player != null && (Config.player.silent || Config.player.forceClip != 0))
            {
                return null;
            }
            if (this._noAutoJustUseCB.selected)
            {
                return this.findPrimarySkill();
            }
            return null;
        }// end function

        public function handleNoAutoJustUse(param1)
        {
            this.setCookie();
            return;
        }// end function

        public function initDraw()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            _loc_4 = new Panel(this, 4, 138 + 10);
            _loc_4.color = 13545363;
            _loc_4.shadow = 0;
            _loc_4.width = 442 + 130;
            _loc_4.height = 86;
            _loc_7 = 150 - 5 + 10;
            _loc_6 = 20;
            _loc_8 = 160 + 130;
            if (Hang.limitedHang)
            {
                _loc_3 = new Label(this, _loc_6, _loc_7 - 2, Config.language("HangUI", 4));
                this._noAutoJustUseCB = new CheckBox(this, _loc_6 + 3, _loc_7 + 20, Config.language("HangUI", 38), this.handleNoAutoJustUse);
            }
            else
            {
                _loc_3 = new Label(this, _loc_6, _loc_7, Config.language("HangUI", 4));
                this._noAutoJustUseCB = new CheckBox(this, _loc_6 + 3, _loc_7 + 22, Config.language("HangUI", 38), this.handleNoAutoJustUse);
            }
            this._noAutoJustUseCB.selected = true;
            this._noAutoJustUseCB.textColor = 3110946;
            this._noAutoJustUseCB.subColor = 16711680;
            _loc_1 = 0;
            while (_loc_1 < 6)
            {
                
                this._attackSkillSlotArray[_loc_1] = new DualSlot(0, 32);
                addChild(this._attackSkillSlotArray[_loc_1]);
                this._attackSkillSlotArray[_loc_1].x = _loc_6 + 40 * _loc_1 + _loc_8;
                this._attackSkillSlotArray[_loc_1].y = _loc_7;
                this._attackSkillSlotArray[_loc_1].addEventListener("sglClick", this.handleSlotClickSkill);
                this._attackSkillSlotArray[_loc_1].addEventListener("up", this.handleSlotClickSkill);
                this._attackSkillSlotArray[_loc_1].addEventListener("drag", this.handleSlotDrag);
                this._attackSkillSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._attackSkillSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            if (Hang.limitedHang)
            {
                _loc_3 = new Label(this, _loc_6, _loc_7 + 35, Config.language("HangUI", 6));
                _loc_3 = new Label(this, _loc_6, _loc_7 + 55, Config.language("HangUI", 39));
                _loc_3 = new Label(this, _loc_6 + 195, _loc_7 + 55, Config.language("HangUI", 40));
                this._limitedHangNS = new NumericStepper(this, _loc_6 + 85, _loc_7 + 55, this.handleLimitedHangNSChange);
                this._limitedHangNS.width = 105;
                this._limitedHangNS.minimum = 1;
                this._limitedHangNS.maximum = 500;
                this._limitedHangNS.value = 500;
                _loc_7 = 190 - 5 + 10;
            }
            else
            {
                this._limitedHangNS = new NumericStepper(null, _loc_6 + 85, _loc_7 + 55, this.handleLimitedHangNSChange);
                this._limitedHangNS.width = 105;
                this._limitedHangNS.minimum = 1;
                this._limitedHangNS.maximum = 500;
                _loc_7 = 190 - 5 + 10;
                _loc_3 = new Label(this, _loc_6, _loc_7 + 7, Config.language("HangUI", 6));
            }
            _loc_1 = 0;
            while (_loc_1 < 6)
            {
                
                this._buffItemSlotArray[_loc_1] = new DualSlot(0, 32);
                addChild(this._buffItemSlotArray[_loc_1]);
                this._buffItemSlotArray[_loc_1].x = _loc_6 + 40 * _loc_1 + _loc_8;
                this._buffItemSlotArray[_loc_1].y = _loc_7;
                this._buffItemSlotArray[_loc_1].addEventListener("sglClick", this.handleSlotClickBuffItem);
                this._buffItemSlotArray[_loc_1].addEventListener("up", this.handleSlotClickBuffItem);
                this._buffItemSlotArray[_loc_1].addEventListener("drag", this.handleSlotDrag);
                this._buffItemSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this._buffItemSlotArray[_loc_1].addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                _loc_1 = _loc_1 + 1;
            }
            _loc_7 = 240 - 5 + 20;
            _loc_6 = 260 - 48 + 100;
            _loc_8 = 90;
            _loc_9 = 25;
            this.graphics.beginFill(13545363, 1);
            this.graphics.drawRoundRect(75 + 80, _loc_7 - 6, 126, 47, 7);
            this.graphics.endFill();
            _loc_3 = new Label(this, 80 - 60, _loc_7, Config.language("HangUI", 8));
            this._pickFilterCB[0] = new CheckBox(this, _loc_6, 100, Config.language("HangUI", 9), this.handlePickFilterChange);
            this._pickFilterCB[1] = new CheckBox(this, _loc_6, 100, Config.language("HangUI", 10), this.handlePickFilterChange);
            this._pickFilterCB[2] = new CheckBox(this, _loc_6, 100, Config.language("HangUI", 11), this.handlePickFilterChange);
            this._pickFilterCB[3] = new CheckBox(this, _loc_6, 100, Config.language("HangUI", 12), this.handlePickFilterChange);
            this._pickFilterCB[4] = new CheckBox(this, _loc_6, 100, Config.language("HangUI", 13), this.handlePickFilterChange);
            this._pickFilterCB[5] = new CheckBox(this, _loc_6, 100, Config.language("HangUI", 14), this.handlePickFilterChange);
            this._pickFilterCB[6] = new CheckBox(this, _loc_6, 100, Config.language("HangUI", 15), this.handlePickFilterChange);
            _loc_1 = 0;
            while (_loc_1 < this._pickFilterCB.length)
            {
                
                this._pickFilterCB[_loc_1].x = _loc_6 + _loc_1 % 4 * _loc_8;
                this._pickFilterCB[_loc_1].y = _loc_7 + Math.floor(_loc_1 / 4) * _loc_9;
                this._pickFilterCB[_loc_1].selected = true;
                _loc_1 = _loc_1 + 1;
            }
            this._pickFilterCB[3].x = 80 + 80;
            _loc_5 = new PushButton(this, 80 - 2 + 80, _loc_7 + 18, Config.language("HangUI", 33), this.handleDetailFilter, null, "table18", "table31");
            _loc_5.data = 0;
            _loc_5.textColor = Style.GOLD_FONT;
            _loc_5.width = 120;
            this._pickFilterPb0 = _loc_5;
            _loc_6 = 80;
            _loc_7 = 30 - 5;
            _loc_8 = 130 + 60;
            _loc_9 = 25;
            var _loc_10:* = 10;
            _loc_3 = new Label(this, 30, _loc_7, Config.language("HangUI", 30));
            _loc_3 = new Label(this, 30, _loc_7 + _loc_9 * 2 + _loc_10, Config.language("HangUI", 31));
            this._mpUseCB2 = new ComboBox(this, _loc_6 + _loc_8, _loc_7 + _loc_9 * 3 + _loc_10, this.handleCBChange);
            this._mpConCB2 = new ComboBox(this, _loc_6, _loc_7 + _loc_9 * 3 + _loc_10, this.handleCBChange);
            this._mpUseCB1 = new ComboBox(this, _loc_6 + _loc_8, _loc_7 + _loc_9 * 2 + _loc_10, this.handleCBChange);
            this._mpConCB1 = new ComboBox(this, _loc_6, _loc_7 + _loc_9 * 2 + _loc_10, this.handleCBChange);
            this._hpUseCB2 = new ComboBox(this, _loc_6 + _loc_8, _loc_7 + _loc_9, this.handleCBChange);
            this._hpConCB2 = new ComboBox(this, _loc_6, _loc_7 + _loc_9, this.handleCBChange);
            this._hpUseCB1 = new ComboBox(this, _loc_6 + _loc_8, _loc_7, this.handleCBChange);
            this._hpConCB1 = new ComboBox(this, _loc_6, _loc_7, this.handleCBChange);
            var _loc_11:* = 150;
            this._mpConCB2.width = 150;
            this._mpConCB1.width = _loc_11;
            this._hpConCB2.width = _loc_11;
            this._hpConCB1.width = _loc_11;
            var _loc_11:* = 270;
            this._mpUseCB2.width = 270;
            this._mpUseCB1.width = _loc_11;
            this._hpUseCB2.width = _loc_11;
            this._hpUseCB1.width = _loc_11;
            this._mpUseCB2.list.overshow = true;
            this._mpConCB2.list.overshow = true;
            this._mpUseCB1.list.overshow = true;
            this._mpConCB1.list.overshow = true;
            this._hpUseCB2.list.overshow = true;
            this._hpConCB2.list.overshow = true;
            this._hpUseCB1.list.overshow = true;
            this._hpConCB1.list.overshow = true;
            this._hpConCB1.editable = false;
            this._hpUseCB1.editable = false;
            this._hpConCB2.editable = false;
            this._hpUseCB2.editable = false;
            this._mpConCB1.editable = false;
            this._mpUseCB1.editable = false;
            this._mpConCB2.editable = false;
            this._mpUseCB2.editable = false;
            this.freshHpUseList();
            this.freshMpUseList();
            this._conArray1.push({label:Config.language("HangUI", 2), value:0});
            _loc_1 = 10;
            while (_loc_1 <= 90)
            {
                
                this._conArray1.push({label:Config.language("HangUI", 32, _loc_1), value:_loc_1 / 100});
                _loc_1 = _loc_1 + 10;
            }
            this._conArray2.push({label:Config.language("HangUI", 2), value:0});
            _loc_1 = 10;
            while (_loc_1 <= 90)
            {
                
                this._conArray2.push({label:Config.language("HangUI", 32, _loc_1), value:_loc_1 / 100});
                _loc_1 = _loc_1 + 10;
            }
            this._hpConCB1.itemArray = this._conArray1;
            this._hpConCB1.selectedItem = this._conArray1[4];
            this._hpConCB2.itemArray = this._conArray2;
            this._hpConCB2.selectedItem = this._conArray2[0];
            this._mpConCB1.itemArray = this._conArray1;
            this._mpConCB1.selectedItem = this._conArray1[0];
            this._mpConCB2.itemArray = this._conArray2;
            this._mpConCB2.selectedItem = this._conArray2[0];
            this._hpUseCB1.itemArray = this._hpUseArray;
            this._hpUseCB1.selectedItem = this._hpUseArray[1];
            this._hpUseCB2.itemArray = this._hpUseArray;
            this._hpUseCB2.selectedItem = this._hpUseArray[0];
            this._mpUseCB1.itemArray = this._mpUseArray;
            this._mpUseCB1.selectedItem = this._mpUseArray[0];
            this._mpUseCB2.itemArray = this._mpUseArray;
            this._mpUseCB2.selectedItem = this._mpUseArray[0];
            this._slotList = new SlotList(this, this._attackSkillSlotArray);
            this._slotList.addEventListener(Event.CHANGE, this.handleSlotListChange);
            this._slotList.addEventListener(Event.CLOSE, this.handleSlotListClose);
            this._slotList.x = this._attackSkillSlotArray[0].x;
            this._slotList.y = 100;
            return;
        }// end function

        private function handleSlotListClose(param1)
        {
            if (this._preSelectSkillSlot != null)
            {
                this._preSelectSkillSlot.selected = false;
                this._preSelectSkillSlot = null;
            }
            return;
        }// end function

        public function freshSlotList()
        {
            var _loc_1:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = [];
            var _loc_3:* = false;
            for (_loc_1 in Skill._skillMap)
            {
                
                _loc_3 = true;
                _loc_4 = Skill._skillMap[_loc_1];
                _loc_5 = Config.player;
                if (_loc_4.level > 0 && _loc_4._skillData.skillControl != 1 && _loc_4._skillData.skillControl != 16 && _loc_4._skillData.targetType == 2 && _loc_4._skillData.skillType != 4 && _loc_4._data != Config.player.attackMode && _loc_4._skillData.reqJob == Config.player.job)
                {
                    _loc_2.push(_loc_4);
                }
            }
            if (_loc_3)
            {
                this._slotList.itemList = _loc_2;
            }
            return;
        }// end function

        private function handleSlotListChange(param1)
        {
            this._preSelectSkillSlot.skill = this._slotList._selectedItem;
            this.setCookie();
            this._slotList.close();
            if (this._preSelectSkillSlot != null)
            {
                this._preSelectSkillSlot.selected = false;
            }
            return;
        }// end function

        public function handleLimitedHangNSChange(param1)
        {
            Hang.limitedHangTime = this._limitedHangNS.value;
            this.setCookie();
            return;
        }// end function

        private function handleDetailFilter(param1)
        {
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            if (_detailFilterPanel != null && _detailFilterPanel.parent != null)
            {
                this.closeDetailFilter();
            }
            else
            {
                _loc_2 = PushButton(param1.currentTarget);
                _loc_3 = _loc_2.data;
                if (_loc_3 == 0)
                {
                    _loc_4 = this.getDetailFilter(Config.language("HangUI", 34), _loc_2, _loc_3);
                }
                else
                {
                    _loc_4 = this.getDetailFilter(Config.language("HangUI", 35), _loc_2, _loc_3);
                }
                Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
                Config.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
                addChild(_loc_4);
                _loc_4.x = _loc_2.x - 180;
                _loc_4.y = _loc_2.y - 155;
            }
            return;
        }// end function

        private function closeDetailFilter(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = _detailFilterPanel.data.qualityRB;
            var _loc_4:* = _detailFilterPanel.data.levelRB;
            var _loc_5:* = _loc_3[0];
            var _loc_6:* = _loc_4[0];
            _loc_2 = 0;
            while (_loc_2 < _loc_3.length)
            {
                
                if (_loc_3[_loc_2].selected)
                {
                    _loc_5 = _loc_3[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < _loc_4.length)
            {
                
                if (_loc_4[_loc_2].selected)
                {
                    _loc_6 = _loc_4[_loc_2];
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            var _loc_7:* = _detailFilterPanel.data.pb;
            if (_detailFilterPanel.data.type == 0)
            {
                this._pickFilterQuality0 = int(_loc_5.data);
                this._pickFilterLevel0 = int(_loc_6.data);
            }
            else
            {
                this._pickFilterQuality1 = int(_loc_5.data);
                this._pickFilterLevel1 = int(_loc_6.data);
            }
            if (_loc_5.data == 0 && _loc_6.data == 0)
            {
                _loc_7.label = Config.language("HangUI", 33);
            }
            else
            {
                _loc_7.label = _loc_5.label + "-" + _loc_6.label;
            }
            if (_detailFilterPanel != null && _detailFilterPanel.parent != null)
            {
                _detailFilterPanel.parent.removeChild(_detailFilterPanel);
            }
            Config.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.handleClickOutside);
            this.setCookie();
            return;
        }// end function

        private function handleClickOutside(param1)
        {
            if (!_detailFilterPanel.data.pb.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY, true) && !_detailFilterPanel.hitTestPoint(Config.stage.mouseX, Config.stage.mouseY, true))
            {
                this.closeDetailFilter();
            }
            return;
        }// end function

        private function getDetailFilter(param1, param2, param3)
        {
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = null;
            if (_detailFilterPanel == null)
            {
                _loc_12 = this._filterLevel;
                _loc_13 = this._filterQuality;
                _detailFilterPanel = new Panel(null, 0, 0);
                _detailFilterPanel.shadow = 5;
                _detailFilterPanel.setSize(300, 155);
                _loc_14 = new Label(_detailFilterPanel, 5, 5);
                _detailFilterPanel.data = {};
                _detailFilterPanel.data.title = _loc_14;
                _detailFilterPanel.roundCorner = 7;
                _detailFilterPanel.color = Style.WINDOW;
                _loc_15 = new Panel(_detailFilterPanel, 5, 25);
                _loc_15.color = Style.FONT_BACKGROUND;
                _loc_15.shadow = 0;
                _loc_15.setSize(290, 60);
                _loc_15.roundCorner = 5;
                _loc_16 = new Label(_detailFilterPanel, 10, 30, Config.language("HangUI", 36));
                _loc_15 = new Panel(_detailFilterPanel, 5, 90);
                _loc_15.color = Style.FONT_BACKGROUND;
                _loc_15.shadow = 0;
                _loc_15.setSize(290, 60);
                _loc_15.roundCorner = 5;
                _loc_16 = new Label(_detailFilterPanel, 10, 95, Config.language("HangUI", 37));
                _loc_15 = new Panel(_detailFilterPanel, 279, 4);
                _loc_15.color = 6241592;
                _loc_15.shadow = 0;
                _loc_15.setSize(16, 15);
                _loc_15.roundCorner = 5;
                _loc_17 = new PushButton(_detailFilterPanel, 280, 5, "", this.closeDetailFilter);
                _loc_17.setStyle(Config.findUI("window")["closebutton"]);
                _loc_9 = [];
                _loc_4 = 0;
                while (_loc_4 < _loc_13.length)
                {
                    
                    if (_loc_4 == 0)
                    {
                        _loc_6 = true;
                    }
                    else
                    {
                        _loc_6 = false;
                    }
                    _loc_11 = new RadioButton(_detailFilterPanel, _loc_4 % 3 * 100 + 10, int(_loc_4 / 3) * 20 + 50, _loc_13[_loc_4].label, _loc_6);
                    _loc_11.data = _loc_13[_loc_4].value;
                    _loc_11.group = "filterQuality";
                    _loc_9.push(_loc_11);
                    _loc_4 = _loc_4 + 1;
                }
                _loc_10 = [];
                _loc_4 = 0;
                while (_loc_4 < _loc_12.length)
                {
                    
                    if (_loc_4 == 0)
                    {
                        _loc_6 = true;
                    }
                    else
                    {
                        _loc_6 = false;
                    }
                    _loc_11 = new RadioButton(_detailFilterPanel, _loc_4 % 4 * 70 + 10, int(_loc_4 / 4) * 20 + 115, _loc_12[_loc_4].label, _loc_6);
                    _loc_11.data = _loc_12[_loc_4].value;
                    _loc_11.group = "filterLevel";
                    _loc_10.push(_loc_11);
                    _loc_4 = _loc_4 + 1;
                }
                _detailFilterPanel.data.qualityRB = _loc_9;
                _detailFilterPanel.data.levelRB = _loc_10;
            }
            _detailFilterPanel.data.title.text = param1;
            _detailFilterPanel.data.pb = param2;
            _detailFilterPanel.data.type = param3;
            if (param3 == 0)
            {
                _loc_7 = this._pickFilterQuality0;
                _loc_8 = this._pickFilterLevel0;
            }
            else
            {
                _loc_7 = this._pickFilterQuality1;
                _loc_8 = this._pickFilterLevel1;
            }
            _loc_9 = _detailFilterPanel.data.qualityRB;
            _loc_10 = _detailFilterPanel.data.levelRB;
            _loc_4 = 0;
            while (_loc_4 < _loc_9.length)
            {
                
                if (_loc_9[_loc_4].data == _loc_7)
                {
                    _loc_9[_loc_4].selected = true;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            _loc_4 = 0;
            while (_loc_4 < _loc_10.length)
            {
                
                if (_loc_10[_loc_4].data == _loc_8)
                {
                    _loc_10[_loc_4].selected = true;
                    break;
                }
                _loc_4 = _loc_4 + 1;
            }
            return _detailFilterPanel;
        }// end function

        private function handlePickFilterChange(param1)
        {
            this.setCookie();
            return;
        }// end function

        public function initCookie()
        {
            if (this._ready)
            {
                return;
            }
            if (Config.cookie.contains("hangSet" + Player._playerId))
            {
                this.getCookie();
            }
            else
            {
                this.setCookie();
            }
            this.testOppCB(this._hpConCB1);
            this.testOppCB(this._mpConCB1);
            this.testOppCB(this._hpUseCB1);
            this.testOppCB(this._mpUseCB1);
            this.testOppCB(this._hpConCB2);
            this.testOppCB(this._mpConCB2);
            this.testOppCB(this._hpUseCB2);
            this.testOppCB(this._mpUseCB2);
            this._ready = true;
            return;
        }// end function

        public function getCookie()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_1:* = Config.cookie.get("hangSet" + Player._playerId);
            if (_loc_1 != null)
            {
                _loc_4 = [_loc_1.hpUse1, _loc_1.hpCon1, _loc_1.hpUse2, _loc_1.hpCon2, _loc_1.mpUse1, _loc_1.mpCon1, _loc_1.mpUse2, _loc_1.mpCon2];
                _loc_5 = [this._hpUseCB1, this._hpConCB1, this._hpUseCB2, this._hpConCB2, this._mpUseCB1, this._mpConCB1, this._mpUseCB2, this._mpConCB2];
                if (_loc_1.lockPos != null)
                {
                    Config.ui._monsterIndexUI._hangMode1.selected = _loc_1.lockPos;
                }
                _loc_2 = 0;
                while (_loc_2 < _loc_4.length)
                {
                    
                    _loc_3 = 0;
                    while (_loc_3 < _loc_5[_loc_2].itemArray.length)
                    {
                        
                        if (_loc_2 % 2 == 0)
                        {
                            if (_loc_5[_loc_2].itemArray[_loc_3].id == _loc_4[_loc_2])
                            {
                                _loc_5[_loc_2].selectedItem = _loc_5[_loc_2].itemArray[_loc_3];
                                break;
                            }
                        }
                        else if (_loc_5[_loc_2].itemArray[_loc_3].value == _loc_4[_loc_2])
                        {
                            _loc_5[_loc_2].selectedItem = _loc_5[_loc_2].itemArray[_loc_3];
                            break;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                _loc_2 = 0;
                while (_loc_2 < this._attackSkillSlotArray.length)
                {
                    
                    if (_loc_1.attackSkill[_loc_2] != null)
                    {
                        this._attackSkillSlotArray[_loc_2].skill = Skill._skillMap[_loc_1.attackSkill[_loc_2]];
                    }
                    else
                    {
                        this._attackSkillSlotArray[_loc_2].skill = null;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_1.pickFilter != null)
                {
                    _loc_2 = 0;
                    while (_loc_2 < this._pickFilterCB.length)
                    {
                        
                        if (_loc_1.pickFilter[_loc_2] != null)
                        {
                            this._pickFilterCB[_loc_2].selected = _loc_1.pickFilter[_loc_2];
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                _loc_6 = this._filterQuality[0].label;
                _loc_7 = this._filterLevel[0].label;
                if (_loc_1.pickQuality0 != null)
                {
                    this._pickFilterQuality0 = _loc_1.pickQuality0;
                    _loc_2 = 0;
                    while (_loc_2 < this._filterQuality.length)
                    {
                        
                        if (this._filterQuality[_loc_2].value == this._pickFilterQuality0)
                        {
                            _loc_6 = this._filterQuality[_loc_2].label;
                            break;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                if (_loc_1.pickLevel0 != null)
                {
                    this._pickFilterLevel0 = _loc_1.pickLevel0;
                    _loc_2 = 0;
                    while (_loc_2 < this._filterLevel.length)
                    {
                        
                        if (this._filterLevel[_loc_2].value == this._pickFilterLevel0)
                        {
                            _loc_7 = this._filterLevel[_loc_2].label;
                            break;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                if (this._pickFilterQuality0 == 0 && this._pickFilterLevel0 == 0)
                {
                    this._pickFilterPb0.label = Config.language("HangUI", 33);
                }
                else
                {
                    this._pickFilterPb0.label = _loc_6 + "-" + _loc_7;
                }
                _loc_6 = this._filterQuality[0].label;
                _loc_7 = this._filterLevel[0].label;
                if (_loc_1.pickQuality1 != null)
                {
                    this._pickFilterQuality1 = _loc_1.pickQuality1;
                    _loc_2 = 0;
                    while (_loc_2 < this._filterQuality.length)
                    {
                        
                        if (this._filterQuality[_loc_2].value == this._pickFilterQuality1)
                        {
                            _loc_6 = this._filterQuality[_loc_2].label;
                            break;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                if (_loc_1.pickLevel1 != null)
                {
                    this._pickFilterLevel1 = _loc_1.pickLevel1;
                    _loc_2 = 0;
                    while (_loc_2 < this._filterLevel.length)
                    {
                        
                        if (this._filterLevel[_loc_2].value == this._pickFilterLevel1)
                        {
                            _loc_7 = this._filterLevel[_loc_2].label;
                            break;
                        }
                        _loc_2 = _loc_2 + 1;
                    }
                }
                _loc_2 = 0;
                while (_loc_2 < this._buffItemSlotArray.length)
                {
                    
                    if (_loc_1.buffItem[_loc_2] != null)
                    {
                        this._buffItemSlotArray[_loc_2].item = _loc_1.buffItem[_loc_2];
                    }
                    else
                    {
                        this._buffItemSlotArray[_loc_2].item = null;
                    }
                    _loc_2 = _loc_2 + 1;
                }
                if (_loc_1.naju != null)
                {
                    this._noAutoJustUseCB.selected = _loc_1.naju;
                }
                if (_loc_1.elite != null)
                {
                    Config.ui._monsterIndexUI._eliteCB.selected = _loc_1.elite;
                }
                if (_loc_1.limitedHangTime != null)
                {
                    this._limitedHangNS.value = _loc_1.limitedHangTime;
                }
            }
            return;
        }// end function

        public function setCookie()
        {
            if (this._ready)
            {
                Config.startLoop(this.subSetCookie);
            }
            return;
        }// end function

        public function subSetCookie(param1)
        {
            var _loc_2:* = undefined;
            Config.stopLoop(this.subSetCookie);
            var _loc_3:* = {};
            _loc_3.hpUse1 = this._hpUseCB1.selectedItem.id;
            _loc_3.hpCon1 = this._hpConCB1.selectedItem.value;
            _loc_3.hpUse2 = this._hpUseCB2.selectedItem.id;
            _loc_3.hpCon2 = this._hpConCB2.selectedItem.value;
            _loc_3.mpUse1 = this._mpUseCB1.selectedItem.id;
            _loc_3.mpCon1 = this._mpConCB1.selectedItem.value;
            _loc_3.mpUse2 = this._mpUseCB2.selectedItem.id;
            _loc_3.mpCon2 = this._mpConCB2.selectedItem.value;
            _loc_3.lockPos = Config.ui._monsterIndexUI._hangMode1.selected;
            _loc_3.attackSkill = [];
            _loc_2 = 0;
            while (_loc_2 < this._attackSkillSlotArray.length)
            {
                
                if (this._attackSkillSlotArray[_loc_2].skill != null)
                {
                    _loc_3.attackSkill[_loc_2] = this._attackSkillSlotArray[_loc_2].skill._skillData.id;
                }
                else
                {
                    _loc_3.attackSkill[_loc_2] = null;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_3.buffItem = [];
            _loc_2 = 0;
            while (_loc_2 < this._buffItemSlotArray.length)
            {
                
                if (this._buffItemSlotArray[_loc_2].item != null)
                {
                    _loc_3.buffItem[_loc_2] = this._buffItemSlotArray[_loc_2].item;
                }
                else
                {
                    _loc_3.buffItem[_loc_2] = null;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_3.pickFilter = [];
            _loc_2 = 0;
            while (_loc_2 < this._pickFilterCB.length)
            {
                
                _loc_3.pickFilter[_loc_2] = this._pickFilterCB[_loc_2].selected;
                _loc_2 = _loc_2 + 1;
            }
            _loc_3.pickQuality0 = this._pickFilterQuality0;
            _loc_3.pickLevel0 = this._pickFilterLevel0;
            _loc_3.naju = this._noAutoJustUseCB.selected;
            _loc_3.elite = Config.ui._monsterIndexUI._eliteCB.selected;
            _loc_3.limitedHangTime = this._limitedHangNS.value;
            Config.cookie.put("hangSet" + Player._playerId, _loc_3);
            return;
        }// end function

        private function handleSlotOut(param1)
        {
            Holder.closeInfo();
            return;
        }// end function

        private function handleSlotOver(param1)
        {
            var _loc_2:* = param1.currentTarget;
            if (_loc_2.item != null)
            {
                Holder.showInfo(Config._itemMap[_loc_2.item].name, new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x + _loc_2.parent.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y + _loc_2.parent.parent.parent.y, _loc_2._size, _loc_2._size));
            }
            else if (_loc_2.skill != null)
            {
                Holder.showInfo(_loc_2.skill._skillData.name, new Rectangle(_loc_2.x + _loc_2.parent.x + _loc_2.parent.parent.x + _loc_2.parent.parent.parent.x, _loc_2.y + _loc_2.parent.y + _loc_2.parent.parent.y + _loc_2.parent.parent.parent.y, _loc_2._size, _loc_2._size));
            }
            return;
        }// end function

        private function handleSlotDrag(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (Holder.item == null && Holder.other == null)
            {
                if (_loc_2.skill != null)
                {
                    Holder.other = {obj:_loc_2.skill, bmpd:_loc_2.skill.getIcon()};
                    _loc_2.skill = null;
                }
                else if (_loc_2.item != null)
                {
                    if (Config._itemMap[_loc_2.item] != null)
                    {
                        _loc_5 = Config._itemMap[_loc_2.item];
                    }
                    _loc_4 = Config.findIcon(Item.getXmlIcon(_loc_5));
                    Holder.other = {obj:{type:UNIT_TYPE_ENUM.TYPEID_ITEM, id:_loc_2.item, slot:_loc_2}, bmpd:_loc_4};
                    _loc_2.item = null;
                }
                this.setCookie();
            }
            return;
        }// end function

        private function handleSlotClickSkill(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1.currentTarget;
            if (Holder.other is Skill)
            {
                if (Holder.other._skillData.skillControl != 1 && Holder.other._skillData.skillControl != 16 && Holder.other._skillData.targetType == 2 && Holder.other._skillData.skillType != 4 && Holder.other._data != Config.player.attackMode)
                {
                    _loc_4 = Holder.other;
                    _loc_2.skill = Holder.other;
                    Holder.other = null;
                    if (Holder.data != null)
                    {
                        Holder.data.skill = _loc_4;
                        Holder.data = null;
                    }
                    this.setCookie();
                }
            }
            else
            {
                if (this._preSelectSkillSlot != _loc_2)
                {
                    this._slotList.open();
                    if (this._preSelectSkillSlot != null)
                    {
                        this._preSelectSkillSlot.selected = false;
                    }
                    _loc_2.selected = true;
                }
                else
                {
                    this._slotList.switchOpen();
                    if (this._slotList.parent != null)
                    {
                        _loc_2.selected = true;
                    }
                    else
                    {
                        _loc_2.selected = false;
                    }
                }
                this._preSelectSkillSlot = _loc_2;
            }
            return;
        }// end function

        private function findBlankAttackSlot() : DualSlot
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._attackSkillSlotArray.length)
            {
                
                if (this._attackSkillSlotArray[_loc_1].skill == null)
                {
                    return this._attackSkillSlotArray[_loc_1];
                }
                _loc_1 = _loc_1 + 1;
            }
            return null;
        }// end function

        public function addAttackSlot(param1:Skill)
        {
            var _loc_2:* = null;
            if (param1 != null && param1._skillData.skillControl != 1 && param1._skillData.skillControl != 16 && param1._skillData.targetType == 2 && param1._skillData.skillType != 4 && param1._data != Config.player.attackMode)
            {
                _loc_2 = this.findBlankAttackSlot();
                if (_loc_2 != null)
                {
                    _loc_2.skill = param1;
                    this.setCookie();
                }
            }
            return;
        }// end function

        public function addHpPotion(param1, param2)
        {
            var _loc_3:* = undefined;
            if (this._hpUseCB1.selectedItem.id == -1)
            {
                _loc_3 = 0;
                while (_loc_3 < this._hpUseCB1.itemArray.length)
                {
                    
                    if (this._hpUseCB1.itemArray[_loc_3].id == param1)
                    {
                        this._hpUseCB1.selectedItem = this._hpUseCB1.itemArray[_loc_3];
                        this._hpConCB1.selectedItem = this._hpConCB1.itemArray[param2];
                        return;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            if (this._hpUseCB2.selectedItem.id == -1)
            {
                _loc_3 = 0;
                while (_loc_3 < this._hpUseCB2.itemArray.length)
                {
                    
                    if (this._hpUseCB2.itemArray[_loc_3].id == param1)
                    {
                        this._hpUseCB2.selectedItem = this._hpUseCB2.itemArray[_loc_3];
                        this._hpConCB2.selectedItem = this._hpConCB2.itemArray[param2];
                        return;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        public function addMpPotion(param1, param2)
        {
            var _loc_3:* = undefined;
            if (this._mpUseCB1.selectedItem.id == -1)
            {
                _loc_3 = 0;
                while (_loc_3 < this._mpUseCB1.itemArray.length)
                {
                    
                    if (this._mpUseCB1.itemArray[_loc_3].id == param1)
                    {
                        this._mpUseCB1.selectedItem = this._mpUseCB1.itemArray[_loc_3];
                        this._mpConCB1.selectedItem = this._mpConCB1.itemArray[param2];
                        return;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            if (this._mpUseCB2.selectedItem.id == -1)
            {
                _loc_3 = 0;
                while (_loc_3 < this._mpUseCB2.itemArray.length)
                {
                    
                    if (this._mpUseCB2.itemArray[_loc_3].id == param1)
                    {
                        this._mpUseCB2.selectedItem = this._mpUseCB2.itemArray[_loc_3];
                        this._mpConCB2.selectedItem = this._mpConCB2.itemArray[param2];
                        return;
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            return;
        }// end function

        private function handleSlotClickBuffSkill(param1)
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.currentTarget;
            if (Holder.other is Skill)
            {
                if (this.isGoodBuffSkill(Holder.other._skillData.id))
                {
                    _loc_3 = Holder.other;
                    _loc_2.skill = Holder.other;
                    Holder.other = null;
                    if (Holder.data != null)
                    {
                        Holder.data.skill = _loc_3;
                        Holder.data = null;
                    }
                    this.setCookie();
                }
            }
            return;
        }// end function

        private function handleSlotClickBuffItem(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_2:* = param1.currentTarget;
            if (Holder.item != null)
            {
                if (Holder.item._drawer == Config.ui._charUI._slotArray)
                {
                    _loc_4 = Holder.item._data;
                    if (Number(_loc_4.type) == 2 && (Number(_loc_4.subType) == 0 || Number(_loc_4.subType) == 5))
                    {
                        _loc_5 = Number(_loc_4.skillId);
                        if (_loc_5 != 0)
                        {
                            _loc_6 = Config._skillMap[_loc_5];
                            _loc_7 = Number(_loc_6.addState);
                            if (_loc_7 != 0 && Number(_loc_6.targetType) == 1)
                            {
                                _loc_8 = Config._buffMap[_loc_7];
                                if (Number(_loc_8.goodBad) == 2)
                                {
                                    _loc_2.item = Holder.item;
                                    _loc_3 = Holder.item;
                                    Holder.item = null;
                                    _loc_3._drawer[_loc_3._position].item = _loc_3;
                                    this.setCookie();
                                }
                            }
                        }
                    }
                    else if (Number(_loc_4.type) == 2 && (Number(_loc_4.subType) == 2 || Number(_loc_4.subType) == 3))
                    {
                        _loc_2.item = Holder.item;
                        _loc_3 = Holder.item;
                        Holder.item = null;
                        _loc_3._drawer[_loc_3._position].item = _loc_3;
                        this.setCookie();
                    }
                }
            }
            else if (Holder.other != null)
            {
                if (!(Holder.other is Skill) && Holder.other.type == UNIT_TYPE_ENUM.TYPEID_ITEM)
                {
                    _loc_4 = Config._itemMap[Holder.other.id];
                    if (Number(_loc_4.type) == 2 && (Number(_loc_4.subType) == 0 || Number(_loc_4.subType) == 5))
                    {
                        _loc_5 = Number(_loc_4.skillId);
                        if (_loc_5 != 0)
                        {
                            _loc_6 = Config._skillMap[_loc_5];
                            _loc_7 = Number(_loc_6.addState);
                            if (_loc_7 != 0 && Number(_loc_6.targetType) == 1)
                            {
                                _loc_8 = Config._buffMap[_loc_7];
                                if (Number(_loc_8.goodBad) == 2)
                                {
                                    _loc_2.item = Holder.other.id;
                                    Holder.other = null;
                                    if (Holder.data != null)
                                    {
                                        Holder.data.item = _loc_2.item;
                                        Holder.data = null;
                                    }
                                    this.setCookie();
                                }
                            }
                        }
                    }
                    else if (Number(_loc_4.type) == 2 && (Number(_loc_4.subType) == 2 || Number(_loc_4.subType) == 3))
                    {
                        _loc_2.item = Holder.other.id;
                        Holder.other = null;
                        if (Holder.data != null)
                        {
                            Holder.data.item = _loc_2.item;
                            Holder.data = null;
                        }
                        this.setCookie();
                    }
                }
            }
            return;
        }// end function

        public function testPropSlot()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < this._buffItemSlotArray.length)
            {
                
                this._buffItemSlotArray[_loc_1].testItemId();
                _loc_1 = _loc_1 + 1;
            }
            return;
        }// end function

        public function findBufferItem()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_11:* = undefined;
            var _loc_9:* = [];
            var _loc_10:* = {};
            for (_loc_1 in Config.player._buffEffect)
            {
                
                _loc_4 = _loc_1;
                _loc_8 = Config._buffMap[_loc_4];
                _loc_11 = Number(_loc_8.baseId);
                _loc_10[_loc_11] = true;
            }
            _loc_1 = 0;
            while (_loc_1 < this._buffItemSlotArray.length)
            {
                
                _loc_2 = this._buffItemSlotArray[_loc_1].item;
                if (_loc_2 != null)
                {
                    _loc_6 = Config._itemMap[_loc_2];
                    if (_loc_6.type == 2 && _loc_6.subType == 2)
                    {
                        if (Config.player.autoHp == 0)
                        {
                            _loc_5 = Config.ui._charUI.getOneItem(_loc_2);
                            if (_loc_5 != null)
                            {
                                _loc_9.push({id:_loc_2, item:_loc_5});
                            }
                        }
                    }
                    else if (_loc_6.type == 2 && _loc_6.subType == 3)
                    {
                        if (Config.player.autoMp == 0)
                        {
                            _loc_5 = Config.ui._charUI.getOneItem(_loc_2);
                            if (_loc_5 != null)
                            {
                                _loc_9.push({id:_loc_2, item:_loc_5});
                            }
                        }
                    }
                    else
                    {
                        _loc_3 = Number(_loc_6.skillId);
                        _loc_7 = Config._skillMap[_loc_3];
                        _loc_4 = Number(_loc_7.addState);
                        _loc_8 = Config._buffMap[_loc_4];
                        _loc_11 = Number(_loc_8.baseId);
                        if (_loc_10[_loc_11] == null)
                        {
                            _loc_5 = Config.ui._charUI.getOneItem(_loc_2);
                            if (_loc_5 != null)
                            {
                                _loc_9.push({id:_loc_2, item:_loc_5, buffBaseId:_loc_11});
                            }
                        }
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            return _loc_9;
        }// end function

        public function findBufferSkill()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_8:* = undefined;
            var _loc_7:* = {};
            for (_loc_1 in Config.player._buffEffect)
            {
                
                _loc_5 = _loc_1;
                _loc_6 = Config._buffMap[_loc_5];
                _loc_8 = Number(_loc_6.baseId);
                _loc_7[_loc_8] = true;
            }
            _loc_1 = 0;
            while (_loc_1 < this._buffSkillSlotArray.length)
            {
                
                _loc_2 = this._buffSkillSlotArray[_loc_1].skill;
                if (_loc_2 != null)
                {
                    _loc_5 = _loc_2._skillData.addState;
                    _loc_6 = Config._buffMap[_loc_5];
                    _loc_8 = Number(_loc_6.baseId);
                    if (_loc_7[_loc_8] == null)
                    {
                        return _loc_2;
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            return null;
        }// end function

        public function findRecoverItem()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = Config.player.hp / Config.player.hpMax;
            var _loc_6:* = Config.player.mp / Config.player.mpMax;
            var _loc_7:* = [];
            if (this._hpUseCB1.selectedItem.id > 0)
            {
                if (_loc_5 < this._hpConCB1.selectedItem.value)
                {
                    if (this._hpUseCB1.selectedItem.item != null && this._hpUseCB1.selectedItem.amount > 0)
                    {
                        _loc_1 = this._hpUseCB1.selectedItem.id;
                        _loc_2 = this._hpUseCB1.selectedItem.item;
                        _loc_7.push({id:_loc_1, item:_loc_2});
                    }
                }
            }
            if (this._hpUseCB2.selectedItem.id > 0)
            {
                if (_loc_5 < this._hpConCB2.selectedItem.value)
                {
                    if (this._hpUseCB2.selectedItem.item != null && this._hpUseCB2.selectedItem.amount > 0)
                    {
                        _loc_1 = this._hpUseCB2.selectedItem.id;
                        _loc_2 = this._hpUseCB2.selectedItem.item;
                        _loc_7.push({id:_loc_1, item:_loc_2});
                    }
                }
            }
            if (this._mpUseCB1.selectedItem.id > 0)
            {
                if (_loc_6 < this._mpConCB1.selectedItem.value)
                {
                    if (this._mpUseCB1.selectedItem.item != null && this._mpUseCB1.selectedItem.amount > 0)
                    {
                        _loc_3 = this._mpUseCB1.selectedItem.id;
                        _loc_4 = this._mpUseCB1.selectedItem.item;
                        _loc_7.push({id:_loc_3, item:_loc_4});
                    }
                }
            }
            if (this._mpUseCB2.selectedItem.id > 0)
            {
                if (_loc_6 < this._mpConCB2.selectedItem.value)
                {
                    if (this._mpUseCB2.selectedItem.item != null && this._mpUseCB2.selectedItem.amount > 0)
                    {
                        _loc_3 = this._mpUseCB2.selectedItem.id;
                        _loc_4 = this._mpUseCB2.selectedItem.item;
                        _loc_7.push({id:_loc_3, item:_loc_4});
                    }
                }
            }
            return _loc_7;
        }// end function

        public function findRest()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = Config.player.hp / Config.player.hpMax;
            var _loc_6:* = Config.player.mp / Config.player.mpMax;
            if (this._hpUseCB1.selectedItem.id == 0)
            {
                if (_loc_5 < this._hpConCB1.selectedItem.value)
                {
                    return true;
                }
            }
            if (this._hpUseCB2.selectedItem.id == 0)
            {
                if (_loc_5 < this._hpConCB2.selectedItem.value)
                {
                    return true;
                }
            }
            if (this._mpUseCB1.selectedItem.id == 0)
            {
                if (_loc_6 < this._mpConCB1.selectedItem.value)
                {
                    return true;
                }
            }
            if (this._mpUseCB2.selectedItem.id == 0)
            {
                if (_loc_6 < this._mpConCB2.selectedItem.value)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function findPrimarySkill()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = null;
            if (Config.player != null && (Config.player.silent || Config.player.forceClip != 0))
            {
                return null;
            }
            _loc_1 = 0;
            while (_loc_1 < this._attackSkillSlotArray.length)
            {
                
                _loc_2 = this._attackSkillSlotArray[_loc_1].skill;
                if (_loc_2 != null)
                {
                    if (Skill.testSkillReady(_loc_2))
                    {
                        return _loc_2;
                    }
                    if (_loc_2.level == 0)
                    {
                        this._attackSkillSlotArray[_loc_1].skill = null;
                    }
                }
                _loc_1 = _loc_1 + 1;
            }
            return null;
        }// end function

        private function isGoodBuffSkill(param1)
        {
            var _loc_2:* = Config._skillMap[param1];
            if (Number(_loc_2.addState) != 0)
            {
                if (Number(Config._buffMap[Number(_loc_2.addState)].goodBad) == 2)
                {
                    return true;
                }
            }
            return false;
        }// end function

    }
}
