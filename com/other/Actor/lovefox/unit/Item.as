package lovefox.unit
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.gameUI.*;
    import lovefox.isometric.*;

    public class Item extends EventDispatcher
    {
        private var _poolPushed:Boolean = false;
        private var _pushPoolTimer:Object;
        var _enterframeListenerArray:Array;
        public var _map:Map;
        public var _mc:Sprite;
        public var _img:DropClip;
        public var _effect:UnitClip;
        public var _id:uint;
        public var _type:uint;
        public var _x:Number;
        public var _y:Number;
        public var _visibleTimer:Object;
        public var sortId:int;
        public var _currTile:Object;
        public var _state:String = "idle";
        public var _data:Object;
        public var _itemData:Object;
        var _sayRect:Sprite;
        var _sayTxt:TextField;
        var _sayInterval:Object;
        public var _position:Object;
        public var _drawer:Object;
        private var _amount:uint = 0;
        private var _amountTxt:TextField;
        private var _numstr:Label;
        public var _icon:Sprite;
        public var _iconBmp:Bitmap;
        public var _iconBmpd:BitmapData;
        private var _preCdStartTime:Object;
        private var _pickDisable:Boolean = false;
        private var _dynamicData:Object;
        public var _haloEffect:Object;
        private var _destroyTimer:Number;
        public var _petBookObj:Object;
        public var _petObj:Object;
        private var _flyPlayerSpeed:int;
        private var _flyPlayerStartDis:int;
        public static var _allCount:int = 0;
        public static var _objectPool:Array = [];
        public static var _itemStack:Object = {};
        public static var _cdStack:Array = [];
        public static var _cdMaxStack:Array = [];
        private static var _taskItemMap:Object = [];

        public function Item(param1, param2, param3, param4, param5)
        {
            this._itemData = {};
            this._dynamicData = {};
            this._haloEffect = {};
            this._petBookObj = {};
            this._petObj = {};
            this._data = param1;
            this._x = param2;
            this._y = param3;
            this._id = param5;
            this._type = param4;
            this._itemData = {};
            this._itemData.addEffect = [];
            this._itemData.gem = [];
            this._itemData.washgrade = 0;
            this._itemData.washtime = 0;
            this._itemData.finegrade = 0;
            this._itemData.suitID = 0;
            this._itemData.qual = 0;
            this._petBookObj = {};
            this._petObj = {};
            this.setItemData();
            if (_itemStack[this._type] == null)
            {
                _itemStack[this._type] = {};
            }
            _itemStack[this._type][this._id] = this;
            this._enterframeListenerArray = [];
            var _loc_6:* = new Date();
            this.cd = Math.max(0, _cdStack[this._itemData.relatedId] - _loc_6.getTime());
            return;
        }// end function

        public function get star()
        {
            return this._itemData.finegrade;
        }// end function

        public function set star(param1)
        {
            this._itemData.finegrade = param1;
            return;
        }// end function

        public function clone(param1)
        {
            var _loc_4:* = undefined;
            var _loc_2:* = {};
            _loc_2.baseID = this._itemData.id;
            _loc_2.binding = this._itemData.binding;
            _loc_2.amount = this._itemData.amount;
            _loc_2.washgrade = this._itemData.washgrade;
            _loc_2.washtime = this._itemData.washtime;
            _loc_2.finegrade = this._itemData.finegrade;
            _loc_2.timeout = this._itemData.timeout;
            _loc_2.qual = this._itemData.qual;
            _loc_2.addEffect = this._itemData.addEffect;
            _loc_2.gem = this._itemData.gem;
            _loc_2.suitID = this._itemData.suitID;
            var _loc_3:* = Item.newItem(this._data, 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEM, 0);
            _loc_3.amount = _loc_2.amount;
            for (_loc_4 in _loc_2)
            {
                
                _loc_3._itemData[_loc_4] = _loc_2[_loc_4];
            }
            _loc_3._petBookObj = this._petBookObj;
            _loc_3._petObj = this._petObj;
            _loc_3._position = this._position;
            return _loc_3;
        }// end function

        public function get name() : String
        {
            return String(this._data.name);
        }// end function

        private function setItemData()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (this._itemData == null)
            {
                this._itemData = {};
            }
            for (_loc_1 in this._data)
            {
                
                this._itemData[_loc_1] = this._data[_loc_1];
            }
            return;
        }// end function

        public function set pickDisable(param1:Boolean) : void
        {
            this._pickDisable = param1;
            return;
        }// end function

        public function get pickDisable() : Boolean
        {
            return this._pickDisable;
        }// end function

        public function set id(param1)
        {
            this._id = param1;
            return;
        }// end function

        public function get id()
        {
            return this._id;
        }// end function

        public function set type(param1)
        {
            this._type = param1;
            return;
        }// end function

        public function get type()
        {
            return this._type;
        }// end function

        private function pfitemtip(param1:int) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = Style.FONT_0_White;
            switch(this._itemData.nameColor)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    break;
                }
                case 2:
                {
                    break;
                }
                case 3:
                {
                    break;
                }
                case 4:
                {
                    break;
                }
                case 5:
                {
                    break;
                }
                case 6:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._itemData.suitID > 0)
            {
                _loc_3 = Style.FONT_5_Green;
            }
            if (this._itemData.addEffect.length == 0 && this._itemData.suitID == 0)
            {
                _loc_3 = Style.FONT_0_White;
            }
            _loc_2 = _loc_2 + ("<font color=\'" + _loc_3 + "\'>" + this._itemData.name + "</font>");
            if (this._itemData.binding == 1)
            {
                _loc_2 = _loc_2 + Config.language("Item", 1);
            }
            else
            {
                switch(this._itemData.bindType)
                {
                    case 1:
                    {
                        _loc_2 = _loc_2 + Config.language("Item", 2);
                        break;
                    }
                    case 2:
                    {
                        _loc_2 = _loc_2 + Config.language("Item", 3);
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            _loc_2 = _loc_2 + "\n";
            if (Config.player.level >= int(this._itemData.reqLevel))
            {
                if (this._itemData.reqLevel != 0)
                {
                    _loc_2 = _loc_2 + (Config.language("Item", 4) + this._itemData.reqLevel);
                }
            }
            else if (int(this._itemData.reqLevel) != 0)
            {
                _loc_2 = _loc_2 + ("<font color=\'" + Style.FONT_Red + "\'>" + Config.language("Item", 4) + this._itemData.reqLevel + "</font>");
            }
            if (this._itemData.suitID > 0)
            {
                _loc_2 = _loc_2 + ("\n<font color=\'" + Style.FONT_Line + "\'>____________________</font>\n");
                _loc_2 = _loc_2 + this.outfitInfo();
            }
            if (this._itemData.suitID > 0)
            {
                _loc_2 = _loc_2 + ("<font color=\'" + Style.FONT_Line + "\'>____________________</font>");
                _loc_2 = _loc_2 + ("\n<font color=\'" + Style.FONT_5_Green + "\'>" + this._itemData.description + "</font>");
                _loc_2 = _loc_2 + ("<font color=\'" + Style.FONT_Red + "\'>\n" + Config.language("Item", 76) + "</font>");
            }
            else
            {
                _loc_2 = _loc_2 + ("<font color=\'" + Style.FONT_Red + "\'>" + Config.language("Item", 11) + "</font>");
            }
            return _loc_2;
        }// end function

        public function outputInfo(param1 = false, param2 = false)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = 0;
            var _loc_26:* = null;
            var _loc_27:* = undefined;
            var _loc_28:* = NaN;
            var _loc_29:* = 0;
            var _loc_30:* = undefined;
            var _loc_31:* = undefined;
            var _loc_32:* = undefined;
            var _loc_33:* = null;
            var _loc_34:* = null;
            var _loc_35:* = NaN;
            var _loc_36:* = 0;
            var _loc_37:* = undefined;
            var _loc_38:* = undefined;
            var _loc_39:* = undefined;
            var _loc_40:* = null;
            var _loc_41:* = null;
            var _loc_42:* = NaN;
            var _loc_43:* = 0;
            var _loc_44:* = null;
            var _loc_45:* = null;
            var _loc_46:* = null;
            var _loc_47:* = undefined;
            var _loc_48:* = null;
            var _loc_49:* = 0;
            var _loc_50:* = 0;
            var _loc_51:* = null;
            var _loc_52:* = 0;
            var _loc_53:* = 0;
            var _loc_54:* = 0;
            var _loc_55:* = null;
            var _loc_56:* = 0;
            var _loc_57:* = false;
            var _loc_58:* = 0;
            var _loc_59:* = undefined;
            var _loc_60:* = null;
            var _loc_61:* = null;
            var _loc_62:* = null;
            var _loc_63:* = undefined;
            if (int(this._itemData.type) == 20)
            {
                return this.pfitemtip(this._itemData.skillId);
            }
            var _loc_3:* = Number(this._itemData.type);
            var _loc_4:* = Number(this._itemData.subType);
            var _loc_8:* = "";
            var _loc_9:* = "";
            var _loc_10:* = Config._replace1;
            var _loc_11:* = [" ", Config.language("Item", 77), Config.language("Item", 78), Config.language("Item", 79), Config.language("Item", 80), "[S]", "[S2]"];
            if (this._itemData.type == 4 && (this._itemData.subType == 11 || this._itemData.subType == 13) && this._itemData.finegrade > 0)
            {
                _loc_8 = Config.language("Item", 12) + this._itemData.finegrade;
            }
            else if (this._itemData.finegrade > 0)
            {
                _loc_8 = Config.language("Item", 12) + this._itemData.finegrade;
                _loc_9 = _loc_9 + "\n";
                _loc_9 = _loc_9 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 13) + "</font>");
                if (this._itemData.subType == 1 || this._itemData.subType == 4 || this._itemData.subType == 8 || this._itemData.subType == 7)
                {
                    _loc_9 = _loc_9 + ("\n" + "<font color=\'" + Style.FONT_Purple + "\'>" + Config.language("Item", 14) + int(this._itemData.finegrade) * int(Config._equipUpgradeAttr[this._itemData.quality2].value) + "</font>");
                    _loc_22 = Style.FONT_Gray;
                    _loc_23 = Style.FONT_1_Blue;
                    _loc_24 = "";
                    if (this._itemData.finegrade < 5)
                    {
                        _loc_24 = "  5★";
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_24 + " " + Config.language("Item", 14) + Config._equipUpgradeAttr[this._itemData.quality2].level5 + "</font>");
                    }
                    else if (this._itemData.finegrade >= 30)
                    {
                        _loc_24 = "30★";
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config.language("Item", 14) + Config._equipUpgradeAttr[this._itemData.quality2].level30 + "</font>");
                        if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type31) > 0)
                        {
                            _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type31].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level31 + "</font>");
                        }
                        if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type32) > 0)
                        {
                            _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type32].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level32 + "</font>");
                        }
                    }
                    else
                    {
                        _loc_25 = int(this._itemData.finegrade / 5) * 5;
                        _loc_26 = "";
                        if (_loc_25 == 5)
                        {
                            _loc_24 = "  5★";
                            _loc_26 = "10★";
                        }
                        else
                        {
                            _loc_24 = _loc_25 + "★";
                            _loc_26 = int(_loc_25 + 5) + "★";
                        }
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config.language("Item", 14) + Config._equipUpgradeAttr[this._itemData.quality2]["level" + _loc_25] + "</font>");
                        if (this._itemData.finegrade >= 25)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type26) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type26].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level26 + "</font>");
                            }
                        }
                        else if (this._itemData.finegrade >= 20)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type21) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type21].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level21 + "</font>");
                            }
                        }
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config.language("Item", 14) + Config._equipUpgradeAttr[this._itemData.quality2]["level" + int(_loc_25 + 5)] + "</font>");
                        if (this._itemData.finegrade >= 25)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type31) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type31].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level31 + "</font>");
                            }
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type32) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type32].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level32 + "</font>");
                            }
                        }
                        else if (this._itemData.finegrade >= 20)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type26) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type26].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level26 + "</font>");
                            }
                        }
                        else if (this._itemData.finegrade >= 15)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type21) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type21].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level21 + "</font>");
                            }
                        }
                    }
                }
                else
                {
                    _loc_9 = _loc_9 + ("\n" + "<font color=\'" + Style.FONT_Purple + "\'>" + Config.language("Item", 18) + int(this._itemData.finegrade) * int(Config._equipUpgradeAttr[this._itemData.quality2].value) + "</font>");
                    _loc_22 = Style.FONT_Gray;
                    _loc_23 = Style.FONT_1_Blue;
                    _loc_24 = "";
                    if (this._itemData.finegrade < 5)
                    {
                        _loc_24 = "  5★";
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_24 + " " + Config.language("Item", 18) + Config._equipUpgradeAttr[this._itemData.quality2].level5 + "</font>");
                    }
                    else if (this._itemData.finegrade >= 30)
                    {
                        _loc_24 = "30★";
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config.language("Item", 18) + Config._equipUpgradeAttr[this._itemData.quality2].level30 + "</font>");
                        if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type31) > 0)
                        {
                            _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type31].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level31 + "</font>");
                        }
                        if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type32) > 0)
                        {
                            _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type32].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level32 + "</font>");
                        }
                    }
                    else
                    {
                        _loc_25 = int(this._itemData.finegrade / 5) * 5;
                        _loc_26 = "";
                        if (_loc_25 == 5)
                        {
                            _loc_24 = "  5★";
                            _loc_26 = "10★";
                        }
                        else
                        {
                            _loc_24 = _loc_25 + "★";
                            _loc_26 = int(_loc_25 + 5) + "★";
                        }
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config.language("Item", 18) + Config._equipUpgradeAttr[this._itemData.quality2]["level" + _loc_25] + "</font>");
                        if (this._itemData.finegrade >= 25)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type26) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type26].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level26 + "</font>");
                            }
                        }
                        else if (this._itemData.finegrade >= 20)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type21) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_23 + "\'>" + _loc_24 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type21].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level21 + "</font>");
                            }
                        }
                        _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config.language("Item", 18) + Config._equipUpgradeAttr[this._itemData.quality2]["level" + int(_loc_25 + 5)] + "</font>");
                        if (this._itemData.finegrade >= 25)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type31) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type31].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level31 + "</font>");
                            }
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type32) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type32].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level32 + "</font>");
                            }
                        }
                        else if (this._itemData.finegrade >= 20)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type26) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type26].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level26 + "</font>");
                            }
                        }
                        else if (this._itemData.finegrade >= 15)
                        {
                            if (Number(Config._equipUpgradeAttr[this._itemData.quality2].type21) > 0)
                            {
                                _loc_9 = _loc_9 + ("\n" + "<font color=\'" + _loc_22 + "\'>" + _loc_26 + " " + Config._itemPropMap[Config._equipUpgradeAttr[this._itemData.quality2].type21].name + " +" + Config._equipUpgradeAttr[this._itemData.quality2].level21 + "</font>");
                            }
                        }
                    }
                }
            }
            var _loc_12:* = Style.FONT_0_White;
            if (this._itemData.qual > 0)
            {
                if (this._itemData.type == 4 && (this._itemData.subType == 11 || this._itemData.subType == 13))
                {
                }
                else
                {
                    this._itemData.nameColor = this._itemData.qual;
                }
            }
            switch(this._itemData.nameColor)
            {
                case 0:
                {
                    _loc_12 = Style.FONT_0_White;
                    break;
                }
                case 1:
                {
                    _loc_12 = Style.FONT_1_Blue;
                    break;
                }
                case 2:
                {
                    _loc_12 = Style.FONT_2_Purple;
                    break;
                }
                case 3:
                {
                    _loc_12 = Style.FONT_3_Orange;
                    break;
                }
                case 4:
                {
                    _loc_12 = Style.FONT_4_Gold;
                    break;
                }
                case 5:
                {
                    _loc_12 = Style.FONT_S_Equip;
                    break;
                }
                case 6:
                {
                    _loc_12 = Style.FONT_6_Yellow;
                    break;
                }
                default:
                {
                    break;
                }
            }
            if (this._itemData.type == 4 && (this._itemData.subType == 11 || this._itemData.subType == 12 || this._itemData.subType == 24 || this._itemData.subType == 13))
            {
                if (int(this._itemData.finegrade) == 60)
                {
                    _loc_12 = "#ff0000";
                }
                else if (int(this._itemData.finegrade) >= 50)
                {
                    _loc_12 = "#EE70FF";
                }
                else if (int(this._itemData.finegrade) >= 40)
                {
                    _loc_12 = Style.FONT_5_Green;
                }
                else if (int(this._itemData.finegrade) >= 30)
                {
                    _loc_12 = Style.FONT_4_Gold;
                }
                else if (int(this._itemData.finegrade) >= 20)
                {
                    _loc_12 = Style.FONT_3_Orange;
                }
                else if (int(this._itemData.finegrade) >= 10)
                {
                    _loc_12 = Style.FONT_2_Purple;
                }
                else if (int(this._itemData.finegrade) > 0)
                {
                    _loc_12 = Style.FONT_1_Blue;
                }
                else
                {
                    _loc_12 = Style.FONT_0_White;
                }
            }
            if (this._itemData.suitID > 0)
            {
                _loc_12 = Style.FONT_5_Green;
                _loc_5 = "<font color=\'" + _loc_12 + "\'>" + Config._outfit[this._itemData.suitID].suitName + String(this._itemData.name) + _loc_11[this._itemData.qual] + _loc_8 + "</font>\n";
            }
            else
            {
                _loc_5 = "<font color=\'" + _loc_12 + "\'>" + String(this._itemData.name) + _loc_11[this._itemData.qual] + _loc_8 + "</font>\n";
            }
            if (this._itemData.itemonly != 0)
            {
                if (this._itemData.itemonly == 1)
                {
                    _loc_5 = _loc_5 + Config.language("Item", 22);
                }
                else
                {
                    _loc_5 = _loc_5 + (Config.language("Item", 23) + this._itemData.itemonly + ")");
                }
            }
            if (int(this._itemData.type) == 4)
            {
                _loc_5 = _loc_5 + (Config.language("Item", 24) + Config._itemType[0].itemlist[1].sub[(int(this._itemData.subType) - 1)].@label);
            }
            if (int(this._itemData.type) == 10 && int(this._itemData.subType) == 12)
            {
                _loc_5 = _loc_5 + (Config.language("Item", 24) + Config._itemType[0].itemlist[1].sub[11].@label);
            }
            if (int(this._itemData.type) == 1)
            {
                _loc_5 = _loc_5 + Config.language("Item", 25);
            }
            if (this._itemData.binding == 1)
            {
                _loc_5 = _loc_5 + Config.language("Item", 26);
            }
            else
            {
                switch(this._itemData.bindType)
                {
                    case 1:
                    {
                        _loc_5 = _loc_5 + Config.language("Item", 27);
                        break;
                    }
                    case 2:
                    {
                        _loc_5 = _loc_5 + Config.language("Item", 28);
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            if (Config.player.job == this._itemData.reqJob || this._itemData.reqJob == 0)
            {
                if (this._itemData.reqJob != 0)
                {
                    _loc_5 = _loc_5 + (Config.language("Item", 29) + Config._jobTitleMap[this._itemData.reqJob] + Config.language("Item", 96));
                }
            }
            else
            {
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_Red + "\'>" + Config.language("Item", 29) + Config._jobTitleMap[this._itemData.reqJob] + Config.language("Item", 96) + "</font>");
            }
            var _loc_13:* = "";
            if (this._petObj.hasOwnProperty("flag"))
            {
                if (this._petObj.flag == 1)
                {
                    if (Config.player.level >= this._itemData.reqLevel)
                    {
                        if (this._itemData.reqLevel != 0)
                        {
                            _loc_13 = Config.language("Item", 30) + this._itemData.reqLevel;
                        }
                    }
                    else
                    {
                        _loc_13 = "<font color=\'" + Style.FONT_Red + "\'>" + Config.language("Item", 30) + this._itemData.reqLevel + "</font>";
                    }
                }
                else if (Config.player.level >= this._itemData.reqLevel)
                {
                    if (this._itemData.reqLevel != 0)
                    {
                        _loc_13 = Config.language("Item", 31) + this._itemData.reqLevel;
                    }
                }
                else
                {
                    _loc_13 = "<font color=\'" + Style.FONT_Red + "\'>" + Config.language("Item", 31) + this._itemData.reqLevel + "</font>";
                }
            }
            else if (Config.player.level >= this._itemData.reqLevel)
            {
                if (this._itemData.reqLevel != 0)
                {
                    _loc_13 = Config.language("Item", 31) + this._itemData.reqLevel;
                }
            }
            else
            {
                _loc_13 = "<font color=\'" + Style.FONT_Red + "\'>" + Config.language("Item", 31) + this._itemData.reqLevel + "</font>";
            }
            if (this._itemData.type == 10 && this._itemData.subType == 4)
            {
                _loc_13 = "";
            }
            _loc_5 = _loc_5 + _loc_13;
            var _loc_14:* = [Config.language("Item", 32), Config.language("Item", 33), Config.language("Item", 34)];
            if (Config.player.sex == this._itemData.sex || this._itemData.sex == 0)
            {
                if (this._itemData.sex != 0)
                {
                    _loc_5 = _loc_5 + (Config.language("Item", 35) + _loc_14[this._itemData.sex]);
                }
            }
            else
            {
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_Red + "\'>" + Config.language("Item", 35) + _loc_14[this._itemData.sex] + "</font>");
            }
            var _loc_15:* = [];
            var _loc_16:* = [];
            if (this._itemData.type == 4 && this._itemData.qual > 0 && Number(this._itemData.subType) < 10)
            {
                _loc_15[0] = {id:1, value:Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].effectValue1, i:Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].effectId1, state:0};
            }
            else
            {
                _loc_27 = 1;
                while (_loc_27 < 10)
                {
                    
                    _loc_7 = Number(this._itemData["effectId" + _loc_27]);
                    if (_loc_7 != 0)
                    {
                        if (_loc_27 < 8)
                        {
                            _loc_15[_loc_7] = {id:_loc_7, value:Number(this._itemData["effectValue" + _loc_27]), i:_loc_27, state:0};
                        }
                        else
                        {
                            _loc_16[_loc_7] = {id:_loc_7, value:Number(this._itemData["effectValue" + _loc_27]), state:0};
                        }
                    }
                    _loc_27 = _loc_27 + 1;
                }
                _loc_15.sortOn("i", Array.NUMERIC);
            }
            if (int(this._itemData.atk) != 0 || int(this._itemData.atkRanged) != 0 || int(this._itemData.atkMagic) != 0 || int(this._itemData.def) != 0 || int(this._itemData.defRanged) != 0 || int(this._itemData.defMagic) != 0)
            {
                _loc_5 = _loc_5 + "\n";
            }
            if (this._itemData.qual > 0)
            {
                if (this._itemData.subType == 11 || this._itemData.subType == 13)
                {
                }
                else
                {
                    this._itemData.atk = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].atk;
                    this._itemData.atkRanged = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].atkRanged;
                    this._itemData.atkMagic = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].atkMagic;
                    this._itemData.def = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].def;
                    this._itemData.defRanged = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].defRanged;
                    this._itemData.defMagic = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + this._itemData.qual].defMagic;
                }
            }
            if (int(this._itemData.atk) != 0 || int(this._itemData.atkRanged) != 0 || int(this._itemData.atkMagic) != 0)
            {
                _loc_28 = Math.max(this._itemData.atk, this._itemData.atkRanged, this._itemData.atkMagic);
                if (this._itemData.addEffect.length > 5)
                {
                    if (this._itemData.addEffect[5] != null)
                    {
                        if (this._itemData.addEffect[5].id == 210)
                        {
                            _loc_30 = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + 5].atk;
                            _loc_31 = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + 5].atkRanged;
                            _loc_32 = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + 5].atkMagic;
                            _loc_28 = Math.max(_loc_30, _loc_31, _loc_32);
                            _loc_28 = int((int(this._itemData.addEffect[5].value) * int(Config._produceAttr[this._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * _loc_28);
                        }
                    }
                }
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_White + "\'>" + Config.language("Item", 36) + _loc_28 + "</font>");
                _loc_29 = 0;
                if (this._position >= 1021 && this._position <= 1030)
                {
                    _loc_29 = 20;
                }
                if (this._position - _loc_29 >= 1001 && this._position - _loc_29 <= 1010 && this._itemData.quality >= 6)
                {
                    _loc_33 = {};
                    _loc_34 = Config.ui._charUI.fightspr();
                    _loc_33 = _loc_34.getaktdefandbloo(this._position);
                    if (_loc_33 != null)
                    {
                        if (_loc_33._basicValue > 0)
                        {
                            _loc_5 = _loc_5 + ("        <font color=\'" + Style.FONT_YellowA + "\'>+" + _loc_33._basicValue + "</font>");
                        }
                    }
                }
            }
            if (int(this._itemData.def) != 0 || int(this._itemData.defRanged) != 0 || int(this._itemData.defMagic) != 0)
            {
                _loc_35 = Math.max(this._itemData.def, this._itemData.defRanged, this._itemData.defMagic);
                if (this._itemData.addEffect.length > 5)
                {
                    if (this._itemData.addEffect[5] != null)
                    {
                        if (this._itemData.addEffect[5].id == 210)
                        {
                            _loc_37 = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + 5].def;
                            _loc_38 = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + 5].defRanged;
                            _loc_39 = Config._bIAttribute[this._itemData.reqLevel * 1000 + this._itemData.subType * 10 + 5].defMagic;
                            _loc_35 = Math.max(_loc_37, _loc_38, _loc_39);
                            _loc_35 = int((int(this._itemData.addEffect[5].value) * int(Config._produceAttr[this._itemData.quality2 * 10 + 6].value2max) / 100 + 1) * _loc_35);
                        }
                    }
                }
                _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_White + "\'>" + Config.language("Item", 37) + _loc_35 + "</font>");
                _loc_36 = 0;
                if (this._position >= 1021 && this._position <= 1030)
                {
                    _loc_36 = 20;
                }
                if (this._position - _loc_36 >= 1001 && this._position - _loc_36 <= 1010 && this._itemData.quality >= 6)
                {
                    _loc_40 = {};
                    _loc_34 = Config.ui._charUI.fightspr();
                    _loc_40 = _loc_34.getaktdefandbloo(this._position);
                    if (_loc_40 != null)
                    {
                        if (_loc_40._basicValue > 0)
                        {
                            _loc_5 = _loc_5 + ("        <font color=\'" + Style.FONT_YellowA + "\'>+" + _loc_40._basicValue + "</font>");
                        }
                    }
                }
            }
            if (this._itemData.washgrade != null)
            {
                if (this._itemData.washgrade > 0)
                {
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_Green + "\'> (+" + this._itemData.washgrade + ")</font>");
                }
            }
            if (this._itemData.type == 4 && this._itemData.subType == 13)
            {
                _loc_5 = _loc_5 + "\n";
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 38) + "</font>");
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_Green + "\'>");
                _loc_5 = _loc_5 + (Config.language("Item", 39) + Config._wingProperty[this._itemData.finegrade].speed + "%");
                _loc_5 = _loc_5 + (Config.language("Item", 40) + Config._wingProperty[this._itemData.finegrade].plus + "%");
                _loc_5 = _loc_5 + (Config.language("Item", 41) + Config._wingProperty[this._itemData.finegrade].def + "%");
                _loc_5 = _loc_5 + "</font>";
            }
            if (this._itemData.type == 4 && this._itemData.subType == 11)
            {
                _loc_5 = _loc_5 + "\n";
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 38) + "</font>");
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_Green + "\'>");
                _loc_5 = _loc_5 + (Config.language("Item", 42) + Config._rideProperty[this._itemData.finegrade].speed);
                _loc_5 = _loc_5 + (Config.language("Item", 43) + Config._rideProperty[this._itemData.finegrade].addhp);
                _loc_5 = _loc_5 + (Config.language("Item", 44) + Config._rideProperty[this._itemData.finegrade].atk + "%");
                _loc_5 = _loc_5 + "</font>";
            }
            if (_loc_15.length > 0)
            {
                _loc_5 = _loc_5 + "\n";
                if (this._itemData.type == 4 && (this._itemData.subType == 11 || this._itemData.subType == 13))
                {
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 45) + "</font>");
                }
                else
                {
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 46) + "</font>");
                }
            }
            var _loc_19:* = 0;
            var _loc_20:* = 0;
            for (_loc_21 in _loc_15)
            {
                
                if (_loc_15[_loc_21].state == 0)
                {
                    if (this._itemData.type == 4 && (this._itemData.subType == 11 || this._itemData.subType == 13))
                    {
                    }
                    else
                    {
                        _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_1_Blue + "\'>");
                    }
                }
                _loc_41 = {46:46, 47:47, 48:48, 49:49, 50:50, 51:51};
                if (_loc_41[_loc_15[_loc_21].id] == null)
                {
                    if (this._itemData.type == 4 && (this._itemData.subType == 11 || this._itemData.subType == 13))
                    {
                        _loc_22 = Style.FONT_Gray;
                        if (_loc_20 == 0)
                        {
                            if (this._itemData.finegrade >= 1)
                            {
                                _loc_22 = Style.FONT_YellowA;
                            }
                        }
                        else if (this._itemData.finegrade >= _loc_20 * 10)
                        {
                            _loc_22 = Style.FONT_YellowA;
                        }
                        if (_loc_20 == 0)
                        {
                            _loc_5 = _loc_5 + ("<font color=\'" + _loc_22 + "\'>" + "\n" + "  1★ ");
                        }
                        else
                        {
                            _loc_5 = _loc_5 + ("<font color=\'" + _loc_22 + "\'>" + "\n" + int(_loc_20 * 10) + "★ ");
                        }
                        _loc_5 = _loc_5 + String(Config._itemPropMap[_loc_15[_loc_20].id].prop).replace(_loc_10, _loc_15[_loc_20].value);
                        _loc_5 = _loc_5 + "</font>";
                        _loc_20 = _loc_20 + 1;
                    }
                    else
                    {
                        _loc_42 = _loc_15[_loc_21].value;
                        if (this._itemData.addEffect.length > 0)
                        {
                            if (this._itemData.addEffect[5] != null)
                            {
                                if (this._itemData.addEffect[5].id == 210)
                                {
                                    _loc_42 = _loc_42 + int(this._itemData.addEffect[5].value) * Config._produceAttr[this._itemData.quality2 * 10 + 6].value3min;
                                }
                            }
                        }
                        _loc_5 = _loc_5 + ("\n" + String(Config._itemPropMap[_loc_15[_loc_21].id].prop).replace(_loc_10, _loc_42));
                        _loc_43 = 0;
                        if (this._position >= 1021 && this._position <= 1030)
                        {
                            _loc_43 = 20;
                        }
                        if (this._position - _loc_43 >= 1001 && this._position - _loc_43 <= 1010 && this._itemData.quality >= 6)
                        {
                            _loc_44 = {};
                            _loc_34 = Config.ui._charUI.fightspr();
                            _loc_44 = _loc_34.getaktdefandbloo(this._position);
                            if (_loc_44 != null)
                            {
                                if (_loc_44._enhanceValue > 0)
                                {
                                    _loc_5 = _loc_5 + ("        <font color=\'" + Style.FONT_YellowA + "\'>+" + _loc_44._enhanceValue + "</font>");
                                }
                            }
                        }
                    }
                }
                else if (_loc_15[_loc_21].id == 46 || _loc_15[_loc_21].id == 48 || _loc_15[_loc_21].id == 50)
                {
                    _loc_42 = _loc_15[_loc_21].value;
                    if (this._itemData.addEffect.length > 0)
                    {
                        if (this._itemData.addEffect[5] != null)
                        {
                            if (this._itemData.addEffect[5].id == 210)
                            {
                                _loc_42 = _loc_42 + int(this._itemData.addEffect[5].value) * Config._produceAttr[this._itemData.quality2 * 10 + 6].value3min;
                            }
                        }
                    }
                    _loc_45 = Config._replace2;
                    _loc_46 = String(Config._itemPropMap[_loc_15[_loc_21].id].prop).replace(_loc_45, _loc_42);
                    for (_loc_47 in _loc_15)
                    {
                        
                        if (_loc_15[_loc_47].id == int((_loc_15[_loc_21].id + 1)))
                        {
                            _loc_46 = _loc_46.replace(_loc_10, _loc_15[_loc_47].value);
                            break;
                        }
                    }
                    _loc_5 = _loc_5 + ("\n" + _loc_46);
                }
                if (_loc_15[_loc_21].state == 0)
                {
                    _loc_5 = _loc_5 + "</font>";
                }
            }
            if (this._itemData.spAtkValue > 0)
            {
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_1_Blue + "\'>");
                _loc_5 = _loc_5 + ("\n" + Config._skillMap[this._itemData.spAtkValue].description);
                _loc_5 = _loc_5 + "</font>";
            }
            if (this._itemData.addEffect.length > 0)
            {
                _loc_5 = _loc_5 + "\n";
                _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 47) + "</font>");
                _loc_48 = ["[ D ] ", "[ C ] ", "[ B ] ", "[ A ] ", "[ S ] ", "[ S2 ] "];
                _loc_49 = 0;
                _loc_50 = 0;
                while (_loc_50 < this._itemData.addEffect.length)
                {
                    
                    if (this._itemData.addEffect[_loc_50] != null)
                    {
                        if (this._itemData.addEffect[_loc_50].state == 0)
                        {
                            _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_1_Blue + "\'>");
                        }
                        _loc_41 = {46:46, 47:47, 48:48, 49:49, 50:50, 51:51};
                        if (_loc_41[this._itemData.addEffect[_loc_50].id] == null)
                        {
                            _loc_51 = [];
                            _loc_52 = 0;
                            _loc_53 = 0;
                            if (this._position >= 1021 && this._position <= 1030)
                            {
                                _loc_53 = 20;
                            }
                            if (this._position >= 1001 + _loc_53 && this._position <= 1010 + _loc_53 && this._itemData.quality >= 6)
                            {
                                _loc_34 = Config.ui._charUI.fightspr();
                                _loc_51 = _loc_34.getsameffect(this._position);
                                _loc_54 = 0;
                                while (_loc_54 < _loc_51.length)
                                {
                                    
                                    if (_loc_51[_loc_54].effectId == this._itemData.addEffect[_loc_50].id)
                                    {
                                        _loc_52 = _loc_51[_loc_54].effectvalue;
                                    }
                                    _loc_54 = _loc_54 + 1;
                                }
                            }
                            if (this._itemData.addEffect[_loc_50].id == 210)
                            {
                                _loc_5 = _loc_5 + ("\n" + "[S2] 改造属性 +" + this._itemData.addEffect[_loc_50].value + "%");
                            }
                            else
                            {
                                _loc_5 = _loc_5 + ("\n" + _loc_48[_loc_49] + String(Config._itemPropMap[this._itemData.addEffect[_loc_50].id].prop).replace(_loc_10, this._itemData.addEffect[_loc_50].value));
                            }
                            if (_loc_52 != 0)
                            {
                                _loc_5 = _loc_5 + ("        <font color=\'" + Style.FONT_YellowA + "\'>+" + _loc_52 + "</font>");
                            }
                        }
                        else if (this._itemData.addEffect[_loc_50].id == 46 || this._itemData.addEffect[_loc_50].id == 48 || this._itemData.addEffect[_loc_50].id == 50)
                        {
                            _loc_45 = Config._replace2;
                            _loc_46 = String(Config._itemPropMap[this._itemData.addEffect[_loc_50].id].prop).replace(_loc_45, this._itemData.addEffect[_loc_50].value);
                            _loc_5 = _loc_5 + ("\n" + _loc_48[_loc_49] + _loc_46);
                        }
                        if (this._itemData.addEffect[_loc_50].state == 0)
                        {
                            _loc_5 = _loc_5 + "</font>";
                        }
                        _loc_49 = _loc_49 + 1;
                    }
                    _loc_50 = _loc_50 + 1;
                }
            }
            if (this._petBookObj.hasOwnProperty("flag"))
            {
                if (this._petBookObj.flag == 1)
                {
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 48) + "</font>");
                    _loc_5 = _loc_5 + (Config.language("Item", 49) + this._petBookObj.level);
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_1_Blue + "\'>");
                    _loc_45 = Config._replace1;
                    _loc_46 = String(Config._itemPropMap[this._petBookObj.id].prop).replace(_loc_45, this._petBookObj.value);
                    _loc_5 = _loc_5 + ("\n" + _loc_46);
                    _loc_5 = _loc_5 + "</font>";
                }
            }
            if (this._petObj.hasOwnProperty("flag"))
            {
                if (this._petObj.flag == 1)
                {
                    _loc_5 = _loc_5 + (Config.language("Item", 50) + this._petObj.soulLevel);
                    _loc_5 = _loc_5 + "\n";
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_1_Blue + "\'>");
                    _loc_55 = [];
                    _loc_55[0] = this._petObj.baseProArr[2];
                    _loc_55[1] = this._petObj.baseProArr[3];
                    _loc_55[2] = this._petObj.baseProArr[0];
                    _loc_55[3] = this._petObj.baseProArr[1];
                    _loc_56 = 0;
                    while (_loc_56 < _loc_55.length)
                    {
                        
                        _loc_45 = Config._replace1;
                        _loc_46 = String(Config._itemPropMap[_loc_55[_loc_56].id].prop).replace(_loc_45, _loc_55[_loc_56].baseValue);
                        _loc_5 = _loc_5 + ("\n" + Config.language("Item", 51) + _loc_55[_loc_56].qual + " ] " + _loc_46);
                        _loc_56 = _loc_56 + 1;
                    }
                    _loc_5 = _loc_5 + "</font>";
                    _loc_5 = _loc_5 + "\n";
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 52) + "</font>");
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_5_Green + "\'>");
                    _loc_56 = 0;
                    while (_loc_56 < this._petObj.addProArr.length)
                    {
                        
                        _loc_45 = Config._replace1;
                        _loc_46 = String(Config._itemPropMap[this._petObj.addProArr[_loc_56].id].prop).replace(_loc_45, this._petObj.addProArr[_loc_56].value);
                        _loc_5 = _loc_5 + ("\n" + Config.language("Item", 53) + this._petObj.addProArr[_loc_56].level + " ] " + _loc_46);
                        _loc_56 = _loc_56 + 1;
                    }
                    _loc_5 = _loc_5 + "</font>";
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_6_Yellow + "\'>");
                    _loc_5 = _loc_5 + ("\n" + Config.language("Item", 54) + this._petObj.giftValue);
                    _loc_5 = _loc_5 + "</font>";
                    _loc_57 = false;
                    if (this._petObj.hasOwnProperty("skillArr"))
                    {
                        _loc_58 = 0;
                        while (_loc_58 < this._petObj.skillArr.length)
                        {
                            
                            if (this._petObj.skillArr[_loc_58].skillId > 0)
                            {
                                _loc_57 = true;
                                break;
                            }
                            _loc_58 = _loc_58 + 1;
                        }
                    }
                    if (_loc_57)
                    {
                        _loc_5 = _loc_5 + "\n";
                        _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 55) + "</font>");
                        _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_YellowA + "\'>");
                        _loc_56 = 0;
                        while (_loc_56 < this._petObj.skillArr.length)
                        {
                            
                            if (this._petObj.skillArr[_loc_56].skillId > 0)
                            {
                                _loc_46 = Config._skillMap[this._petObj.skillArr[_loc_56].skillId].name;
                                _loc_5 = _loc_5 + ("\n" + _loc_46);
                            }
                            _loc_56 = _loc_56 + 1;
                        }
                        _loc_5 = _loc_5 + "</font>";
                    }
                }
            }
            if (this._itemData.gem != null)
            {
                if (this._itemData.gem.length > 0)
                {
                    _loc_5 = _loc_5 + "\n";
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_LightYellow + "\'>" + Config.language("Item", 56) + "</font>");
                }
                if (this._itemData.gem.length > 0)
                {
                    _loc_5 = _loc_5 + ("<font color=\'" + Style.FONT_1_Blue + "\'>");
                    _loc_59 = [];
                    _loc_27 = 0;
                    while (_loc_27 < this._itemData.gem.length)
                    {
                        
                        _loc_60 = Style.FONT_White;
                        _loc_61 = Config.language("Item", 57);
                        switch(this._itemData.gem[_loc_27].type)
                        {
                            case 1:
                            {
                                _loc_60 = Style.FONT_Red;
                                _loc_61 = Config.language("Item", 58);
                                break;
                            }
                            case 2:
                            {
                                _loc_60 = Style.FONT_Blue;
                                _loc_61 = Config.language("Item", 59);
                                break;
                            }
                            case 3:
                            {
                                _loc_60 = Style.FONT_Yellow;
                                _loc_61 = Config.language("Item", 57);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        if (this._itemData.gem[_loc_27].id == 0)
                        {
                            if (this._itemData.gem[_loc_27].open)
                            {
                                _loc_5 = _loc_5 + ("<font color=\'" + _loc_60 + "\'>\n○" + "</font><font color=\'" + Style.FONT_White + "\'>" + _loc_61 + "</font>");
                            }
                            else
                            {
                                _loc_5 = _loc_5 + ("<font color=\'" + _loc_60 + "\'>\n◎" + "</font><font color=\'" + Style.FONT_White + "\'>" + _loc_61 + Config.language("Item", 60) + "</font>");
                            }
                        }
                        else
                        {
                            _loc_5 = _loc_5 + ("<font color=\'" + _loc_60 + "\'>\n●" + Config._itemMap[this._itemData.gem[_loc_27].id].name + "</font>  ");
                            _loc_5 = _loc_5 + String(Config._itemPropMap[Config._itemMap[this._itemData.gem[_loc_27].id].effectId1].prop).replace(_loc_10, Config._itemMap[this._itemData.gem[_loc_27].id].effectValue1);
                        }
                        _loc_27 = _loc_27 + 1;
                    }
                    _loc_5 = _loc_5 + "</font>";
                }
            }
            if (_loc_9 != "")
            {
                _loc_5 = _loc_5 + _loc_9;
            }
            if (this._itemData.baseID == 51000)
            {
                _loc_5 = _loc_5 + ("\n" + Config.ui._expball.getballtip());
            }
            if (this._itemData.description != null)
            {
                if (this._itemData.id == 10100)
                {
                    _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_1_Blue + "\'>" + Config.language("Item", 81, Config._ListExp[Config.player.level].coreExp) + "</font>");
                }
                else
                {
                    _loc_5 = _loc_5 + ("\n<font color=\'" + Style.FONT_1_Blue + "\'>" + this._itemData.description + "</font>");
                }
            }
            if (this._itemData.type == 4 && this._itemData.subType == 10)
            {
                if (this._itemData.timeLimit / 24 > 366)
                {
                    _loc_5 = _loc_5 + ("\n\n<font color=\'#28d0e4\'>" + Config.language("Item", 93) + "</font>");
                }
                else if (this._itemData.timeout != 0 && this._itemData.hasOwnProperty("timeout"))
                {
                    _loc_62 = Config.now;
                    _loc_63 = int(this._itemData.timeout - _loc_62.getTime() / 1000) + Config._serverTimeZoneOffset / 1000;
                    if (_loc_63 > 3600 * 24)
                    {
                        _loc_5 = _loc_5 + ("\n\n<font color=\'#28d0e4\'>" + Config.language("Item", 61) + Math.ceil(_loc_63 / (3600 * 24)) + Config.language("Item", 62) + " / " + int(this._itemData.timeLimit / 24) + Config.language("Item", 62) + "</font>");
                    }
                    else if (_loc_63 > 3600)
                    {
                        _loc_5 = _loc_5 + ("\n\n<font color=\'#28d0e4\'>" + Config.language("Item", 61) + Math.floor(_loc_63 / 3600) + Config.language("Item", 63) + Math.floor(_loc_63 % 3600 / 60) + Config.language("Item", 64) + _loc_63 % 60 + Config.language("Item", 65) + "</font>");
                    }
                    else if (_loc_63 > 60)
                    {
                        _loc_5 = _loc_5 + ("\n\n<font color=\'#28d0e4\'>" + Config.language("Item", 61) + Math.floor(_loc_63 % 3600 / 60) + Config.language("Item", 64) + _loc_63 % 60 + Config.language("Item", 65) + "</font>");
                    }
                    else if (_loc_63 > 0)
                    {
                        _loc_5 = _loc_5 + ("\n\n<font color=\'#28d0e4\'>" + Config.language("Item", 61) + _loc_63 % 60 + Config.language("Item", 65) + "</font>");
                    }
                    else
                    {
                        _loc_5 = _loc_5 + ("\n\n<font color=\'#28d0e4\'>" + Config.language("Item", 66) + "</font>");
                    }
                }
                else
                {
                    _loc_5 = _loc_5 + ("\n\n<font color=\'#28d0e4\'>" + Config.language("Item", 67) + int(this._itemData.timeLimit / 24) + Config.language("Item", 62) + "</font>");
                }
            }
            if (Config.ui._shopUI._opening || Config.ui._easyShop._opening || Config.ui._blackmarket._opening || Config.getMouseState() == "sell")
            {
                if (param2)
                {
                    if (this._itemData.goldType == 3)
                    {
                        _loc_5 = _loc_5 + ("\n<font color=\'#F1F5A5\'>" + Config.language("Item", 68) + this._itemData.goldValue * 10 + "</font>");
                    }
                    else if (this._itemData.goldType == 4)
                    {
                        _loc_5 = _loc_5 + ("\n<font color=\'#F1F5A5\'>" + Config.language("Item", 69) + this._itemData.goldValue * 10 + "</font>");
                    }
                }
                else if (param1)
                {
                    if (this._itemData.buyType == 3)
                    {
                        _loc_5 = _loc_5 + ("\n<font color=\'#F1F5A5\'>" + Config.language("Item", 68) + this._itemData.goldValue + "</font>");
                    }
                    else if (this._itemData.buyType == 4)
                    {
                        _loc_5 = _loc_5 + ("\n<font color=\'#F1F5A5\'>" + Config.language("Item", 69) + this._itemData.goldValue + "</font>");
                    }
                }
                else if (this._itemData.goldType == 3)
                {
                    _loc_5 = _loc_5 + ("\n<font color=\'#F1F5A5\'>" + Config.language("Item", 70) + this._itemData.goldValue + Config.language("Item", 71) + "</font>");
                }
                else if (this._itemData.goldType == 4)
                {
                    _loc_5 = _loc_5 + ("\n<font color=\'#F1F5A5\'>" + Config.language("Item", 70) + this._itemData.goldValue + Config.language("Item", 72) + "</font>");
                }
            }
            return _loc_5;
        }// end function

        public function outfitInfo(param1:int = 1) : String
        {
            var _loc_10:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = 0;
            var _loc_14:* = null;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = null;
            var _loc_18:* = null;
            var _loc_19:* = 0;
            var _loc_20:* = null;
            var _loc_2:* = Config._replace1;
            var _loc_3:* = "";
            var _loc_4:* = [Config.language("Item", 82), Config.language("Item", 83), Config.language("Item", 84), Config.language("Item", 85), Config.language("Item", 86), Config.language("Item", 87), Config.language("Item", 88), Config.language("Item", 89), Config.language("Item", 90), Config.language("Item", 91), Config.language("Item", 92)];
            var _loc_5:* = Config._outfit[this._itemData.suitID];
            var _loc_6:* = false;
            var _loc_7:* = 0;
            if (this._position >= 1021 && this._position <= 1030)
            {
                _loc_7 = 20;
            }
            _loc_3 = _loc_3 + ("<font color=\'" + Style.FONT_Green + "\'>" + _loc_5.suitName + Config.language("Item", 73));
            if (param1 == 3)
            {
                _loc_3 = _loc_3 + (Config.ui._charUI.getOutfitNum(this._itemData.suitID, param1, _loc_7) + " / " + _loc_5.suitMaxNumber);
            }
            else if (int(this._itemData.type) == 20)
            {
                _loc_3 = _loc_3 + ("0 / " + _loc_5.suitMaxNumber + "");
            }
            else
            {
                _loc_3 = _loc_3 + ("1 / " + _loc_5.suitMaxNumber + "");
            }
            _loc_3 = _loc_3 + "</font>\n";
            var _loc_8:* = 0;
            var _loc_9:* = 0;
            _loc_10 = String(_loc_5.suit1).split(":");
            var _loc_11:* = 0;
            _loc_12 = 0;
            while (_loc_12 < _loc_10.length)
            {
                
                _loc_11 = int(_loc_10[_loc_12]);
                break;
                _loc_12 = _loc_12 + 1;
            }
            if (Config.player.job == 1)
            {
                _loc_8 = 0;
            }
            else if (Config.player.job == 4)
            {
                _loc_8 = 1;
            }
            else
            {
                _loc_8 = 2;
            }
            if (_loc_11 > 0)
            {
                _loc_14 = Style.FONT_Gray;
                if (param1 == 3)
                {
                    _loc_15 = 0;
                    while (_loc_15 < _loc_10.length)
                    {
                        
                        if (Config.ui._charUI.checkOutfit(1, int(_loc_10[_loc_15]), this._itemData.suitID, _loc_7))
                        {
                            _loc_14 = Style.FONT_Green;
                            break;
                        }
                        _loc_15 = _loc_15 + 1;
                    }
                    if (_loc_14 == Style.FONT_Green)
                    {
                        _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + Config._itemMap[int(_loc_10[_loc_15])].name + "</font>");
                    }
                    else
                    {
                        _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + " - " + _loc_4[_loc_8] + "</font>");
                    }
                }
                else
                {
                    _loc_14 = Style.FONT_Gray;
                    if (this._itemData.subType == 10 || this._itemData.subType == 1)
                    {
                        _loc_8 = 0;
                        if (this._itemData.type != 20)
                        {
                            _loc_14 = Style.FONT_Green;
                        }
                    }
                    else if (this._itemData.subType == 11 || this._itemData.subType == 1)
                    {
                        _loc_8 = 1;
                        if (this._itemData.type != 20)
                        {
                            _loc_14 = Style.FONT_Green;
                        }
                    }
                    else if (this._itemData.subType == 12 || this._itemData.subType == 24 || this._itemData.subType == 1)
                    {
                        _loc_8 = 2;
                        if (this._itemData.type != 20)
                        {
                            _loc_14 = Style.FONT_Green;
                        }
                    }
                    if (_loc_14 == Style.FONT_Green && this._itemData.type != 20)
                    {
                        _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + Config._itemMap[this._itemData.id].name + "</font>");
                    }
                    else
                    {
                        _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + " - " + _loc_4[_loc_8] + "</font>");
                    }
                }
            }
            _loc_12 = 2;
            while (_loc_12 < 15)
            {
                
                _loc_16 = String(_loc_5["suit" + _loc_12]).split(":");
                _loc_15 = 0;
                while (_loc_15 < _loc_16.length)
                {
                    
                    _loc_9 = int(_loc_16[_loc_15]);
                    break;
                    _loc_15 = _loc_15 + 1;
                }
                if (_loc_9 > 0)
                {
                    _loc_8 = Config._itemMap[_loc_9].subType;
                    _loc_14 = Style.FONT_Gray;
                    if (param1 == 3)
                    {
                        _loc_15 = 0;
                        while (_loc_15 < _loc_16.length)
                        {
                            
                            if (Config.ui._charUI.checkOutfit(_loc_12, int(_loc_16[_loc_15]), this._itemData.suitID, _loc_7))
                            {
                                _loc_14 = Style.FONT_Green;
                                break;
                            }
                            _loc_15 = _loc_15 + 1;
                        }
                        if (_loc_14 == Style.FONT_Green)
                        {
                            _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + Config._itemMap[int(_loc_16[_loc_15])].name + "</font>");
                        }
                        else
                        {
                            _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + " - " + _loc_4[(_loc_8 + 1)] + "</font>");
                        }
                    }
                    else
                    {
                        _loc_15 = 0;
                        while (_loc_15 < _loc_16.length)
                        {
                            
                            if (int(this._itemData.id) == int(_loc_16[_loc_15]))
                            {
                                _loc_14 = Style.FONT_Green;
                                if (this._itemData.subType == 7)
                                {
                                    if (_loc_6)
                                    {
                                        _loc_6 = false;
                                        _loc_14 = Style.FONT_Gray;
                                    }
                                    else
                                    {
                                        _loc_6 = true;
                                    }
                                }
                                break;
                            }
                            _loc_15 = _loc_15 + 1;
                        }
                        if (_loc_14 == Style.FONT_Green && this._itemData.type != 20)
                        {
                            _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + Config._itemMap[this._itemData.id].name + "</font>");
                        }
                        else
                        {
                            _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_14 + "\'>" + _loc_5.suitName + " - " + _loc_4[(_loc_8 + 1)] + "</font>");
                        }
                    }
                }
                _loc_12 = _loc_12 + 1;
            }
            _loc_3 = _loc_3 + ("\n\n<font color=\'" + Style.FONT_Green + "\'>" + Config.language("Item", 74) + "</font>\n");
            _loc_13 = 1;
            while (_loc_13 < 10)
            {
                
                if (_loc_5["amount" + _loc_13] > 0)
                {
                    _loc_17 = Style.FONT_Gray;
                    if (Config.ui._charUI.getOutfitNum(this._itemData.suitID, param1, _loc_7) >= _loc_5["amount" + _loc_13])
                    {
                        _loc_17 = Style.FONT_Green;
                    }
                    _loc_3 = _loc_3 + Config.language("Item", 75, _loc_17, _loc_5["amount" + _loc_13]);
                    _loc_18 = String(_loc_5["effect" + _loc_13 + "_s"]);
                    _loc_10 = _loc_18.split(";");
                    _loc_19 = 0;
                    while (_loc_19 < _loc_10.length)
                    {
                        
                        _loc_20 = String(Config._itemPropMap[int(_loc_10[_loc_19].split(",")[0])].prop).replace(_loc_2, _loc_10[_loc_19].split(",")[1]);
                        if (_loc_19 > 0)
                        {
                            _loc_20 = "        " + _loc_20;
                        }
                        _loc_3 = _loc_3 + (_loc_20 + "\n");
                        _loc_19 = _loc_19 + 1;
                    }
                    _loc_3 = _loc_3 + "</font>";
                }
                _loc_13 = _loc_13 + 1;
            }
            _loc_13 = 1;
            while (_loc_13 < 11)
            {
                
                if (_loc_5["skillId" + _loc_13] > 0)
                {
                    _loc_3 = _loc_3 + ("\n<font color=\'" + Style.FONT_Green + "\'>" + Config.language("Item", 94) + "</font>");
                    break;
                }
                _loc_13 = _loc_13 + 1;
            }
            _loc_13 = 1;
            while (_loc_13 < 11)
            {
                
                if (_loc_5["skillId" + _loc_13] > 0)
                {
                    _loc_17 = Style.FONT_Gray;
                    if (Config.ui._charUI.getOutfitNum(this._itemData.suitID, param1, _loc_7) >= _loc_13)
                    {
                        _loc_17 = Style.FONT_Green;
                    }
                    _loc_3 = _loc_3 + ("\n<font color=\'" + _loc_17 + "\'>" + Config.language("Item", 95, _loc_13, Config._skillMap[_loc_5["skillId" + _loc_13]].description) + "</font>");
                }
                _loc_13 = _loc_13 + 1;
            }
            return _loc_3;
        }// end function

        private function constrong(param1:int, param2:int) : int
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            switch(param1)
            {
                case 0:
                {
                    if (param2 >= 4)
                    {
                        _loc_4 = _loc_4 + 2;
                        if (param2 >= 7)
                        {
                            _loc_4 = _loc_4 + 3;
                            if (param2 >= 10)
                            {
                                _loc_4 = _loc_4 + 5;
                            }
                        }
                    }
                    _loc_3 = param2 * 3 + _loc_4;
                    break;
                }
                case 1:
                {
                    if (param2 >= 10)
                    {
                        _loc_4 = _loc_4 + 2;
                    }
                    _loc_3 = param2 * 1 + _loc_4;
                    break;
                }
                case 2:
                {
                    if (param2 >= 7)
                    {
                        _loc_4 = _loc_4 + 2;
                        if (param2 >= 10)
                        {
                            _loc_4 = _loc_4 + 3;
                        }
                    }
                    _loc_3 = param2 * 2 + _loc_4;
                    break;
                }
                case 3:
                {
                    if (param2 >= 4)
                    {
                        _loc_4 = _loc_4 + 2;
                        if (param2 >= 7)
                        {
                            _loc_4 = _loc_4 + 3;
                            if (param2 >= 10)
                            {
                                _loc_4 = _loc_4 + 5;
                            }
                        }
                    }
                    _loc_3 = param2 * 3 + _loc_4;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_3;
        }// end function

        public function set cd(param1)
        {
            if (param1 == null || isNaN(param1))
            {
                return;
            }
            if (_cdMaxStack[this._itemData.relatedId] == null)
            {
                _cdMaxStack[this._itemData.relatedId] = param1;
            }
            else
            {
                _cdMaxStack[this._itemData.relatedId] = Math.max(param1, _cdMaxStack[this._itemData.relatedId]);
            }
            var _loc_2:* = new Date();
            this._preCdStartTime = _loc_2.getTime() + param1;
            if (this._drawer != null)
            {
                if (this._drawer[this._position] != null)
                {
                    this._drawer[this._position].setCd(param1, _cdMaxStack[this._itemData.relatedId]);
                }
            }
            _cdStack[this._itemData.relatedId] = this._preCdStartTime;
            Config.ui._quickUI.handleSkillCd(this._itemData.relatedId, param1);
            return;
        }// end function

        public function get cd()
        {
            var _loc_1:* = new Date();
            return Math.max(0, this._preCdStartTime - _loc_1.getTime());
        }// end function

        public function set amount(param1)
        {
            this._amount = param1;
            if (this._amountTxt != null)
            {
                if (this._amount > 1)
                {
                    this._amountTxt.text = String(this._amount);
                }
                else if (param1 == "★")
                {
                    this._amountTxt.text = param1;
                }
                else
                {
                    this._amountTxt.text = "";
                }
            }
            dispatchEvent(new Event("amount"));
            return;
        }// end function

        public function get amount()
        {
            if (this._amountTxt.text == "★")
            {
                return "★";
            }
            return this._amount;
        }// end function

        public function set numstr(param1:String) : void
        {
            this._numstr.text = param1;
            dispatchEvent(new Event("numstrs"));
            return;
        }// end function

        public function get numstr() : String
        {
            if (this._numstr == null)
            {
                return "";
            }
            return this._numstr.text;
        }// end function

        public function set numstrcolor(param1:int) : void
        {
            this._numstr.textColor = param1;
            return;
        }// end function

        public function get numstrcolor() : int
        {
            return this._numstr.textColor;
        }// end function

        function startLoop(param1:Function)
        {
            this.stopLoop(param1);
            this._enterframeListenerArray.push(param1);
            this._mc.addEventListener(Event.ENTER_FRAME, param1, false, 0, true);
            return;
        }// end function

        function stopLoop(param1:Function)
        {
            var _loc_2:* = 0;
            while (_loc_2 < this._enterframeListenerArray.length)
            {
                
                if (this._enterframeListenerArray[_loc_2] == param1)
                {
                    this._enterframeListenerArray.splice(_loc_2, 1);
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this._mc.removeEventListener(Event.ENTER_FRAME, param1);
            return;
        }// end function

        public function removeFromMap()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < this._enterframeListenerArray.length)
            {
                
                this.stopLoop(this._enterframeListenerArray[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            if (EventMouse._hoverUnit == this)
            {
                EventMouse._hoverUnit = null;
            }
            if (this._currTile != null)
            {
                this._currTile.removeItem(this);
            }
            if (this._map != null)
            {
                if (this._mc.parent == this._map._footMap)
                {
                    this._map._footMap.removeChild(this._mc);
                }
            }
            return;
        }// end function

        public function destroyClip()
        {
            if (this._img != null)
            {
                this._img.destroy();
                this._img = null;
            }
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            this._pickDisable = false;
            var _loc_8:* = _allCount - 1;
            _allCount = _loc_8;
            clearTimeout(this._destroyTimer);
            dispatchEvent(new Event("destroy"));
            if (this._map != null)
            {
                this._map.removeEventListener("complete", this.handleMapComplete);
            }
            this.say("");
            var _loc_6:* = this._enterframeListenerArray.concat();
            _loc_1 = 0;
            while (_loc_1 < _loc_6.length)
            {
                
                this.stopLoop(_loc_6[_loc_1]);
                _loc_1 = _loc_1 + 1;
            }
            _loc_4 = false;
            delete _itemStack[this._type][this._id];
            if (EventMouse._hoverUnit == this)
            {
                EventMouse._hoverUnit = null;
            }
            if (this._currTile != null)
            {
                this._currTile.removeItem(this);
                this._currTile = null;
            }
            if (this._img != null)
            {
                this._img.destroy();
                this._img = null;
            }
            this.amount = 0;
            this.visible = false;
            if (this._iconBmpd != null)
            {
                this._iconBmpd.dispose();
                this._iconBmpd = null;
            }
            if (this._iconBmp != null && this._iconBmp.parent != null)
            {
                this._iconBmp.parent.removeChild(this._iconBmp);
            }
            if (this._icon != null && this._icon.parent != null)
            {
                this._icon.parent.removeChild(this._icon);
            }
            this._mc = null;
            _objectPool.push(this);
            return;
        }// end function

        public function display(param1 = null)
        {
            this._sayRect = new Sprite();
            this._sayTxt = Config.getSimpleTextField();
            this._sayRect.addChild(this._sayTxt);
            this._map = param1;
            if (this._map != null)
            {
                this._mc = new Sprite();
                this._img = DropClip.newDropClip(this.iconURL);
                this._mc.addChild(this._img);
                if (this._map._state == "ready")
                {
                    this.subDisplay();
                }
                else
                {
                    this._map.addEventListener("complete", this.handleMapComplete);
                }
                clearTimeout(this._destroyTimer);
                this._destroyTimer = setTimeout(this.destroy, 300000);
            }
            else
            {
                if (this._iconBmpd != null)
                {
                    this._iconBmpd.dispose();
                    this._iconBmpd = null;
                }
                if (this._iconBmp != null && this._iconBmp.parent != null)
                {
                    this._iconBmp.parent.removeChild(this._iconBmp);
                }
                if (this._icon != null && this._icon.parent != null)
                {
                    this._icon.parent.removeChild(this._icon);
                }
                this._iconBmpd = Config.findIcon(this.iconURL);
                this._icon = new Sprite();
                this._iconBmp = new Bitmap(this._iconBmpd);
                this._icon.addChild(this._iconBmp);
                this._amountTxt = Config.getSimpleTextField();
                this._amountTxt.autoSize = TextFieldAutoSize.RIGHT;
                this._amountTxt.textColor = 16777215;
                this._amountTxt.y = 32 - 16;
                this._amountTxt.x = 32 - 5;
                this._amountTxt.filters = [new GlowFilter(0, 1, 3, 3, 10)];
                this._icon.addChild(this._amountTxt);
                this.amount = this._amount;
                this._numstr = new Label(null, 0, 20);
                this._numstr.textColor = 16777215;
                this._icon.addChild(this._numstr);
            }
            return;
        }// end function

        private function handleMapComplete(param1)
        {
            this._map.removeEventListener("complete", this.handleMapComplete);
            this.subDisplay();
            return;
        }// end function

        private function subDisplay()
        {
            var _loc_1:* = this._map.mapToTile({_x:this._x, _y:this._y});
            if (this._currTile != null)
            {
                this._currTile.removeItem(this);
            }
            this._currTile = _loc_1;
            this._currTile.addItem(this);
            this.swapDepthTile();
            this.draw();
            var _loc_2:* = 64;
            this.visible = true;
            return;
        }// end function

        public function forcePosition(param1)
        {
            this._x = param1._x;
            this._y = param1._y;
            param1 = this._map.mapToTile({_x:this._x, _y:this._y});
            var _loc_2:* = this._map._logicalTile[param1._x][param1._y];
            if (this._currTile != null)
            {
                this._currTile.removeItem(this);
            }
            this._currTile = _loc_2;
            this._currTile.addItem(this);
            this.swapDepthTile();
            this.draw();
            return;
        }// end function

        public function addBorder(param1:uint = 16711680)
        {
            this.say(this._itemData.name);
            var _loc_2:* = 1;
            var _loc_3:* = 5;
            var _loc_4:* = 5;
            var _loc_5:* = 2;
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = BitmapFilterQuality.LOW;
            var _loc_9:* = new GlowFilter(param1, _loc_2, _loc_3, _loc_4, _loc_5, _loc_8, _loc_6, _loc_7);
            var _loc_10:* = new Array();
            new Array().push(_loc_9);
            this._mc.filters = _loc_10;
            return;
        }// end function

        public function removeBorder()
        {
            this.say("");
            this._mc.filters = [];
            return;
        }// end function

        private function swapDepthTile()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (this._currTile._x < (this._map._logicalWidth - 1) && this._currTile._y < (this._map._logicalHeight - 1))
            {
                _loc_1 = this._map._logicalTile[(this._currTile._x + 1)][(this._currTile._y + 1)];
                _loc_2 = _loc_1.getMinCurrDepthItem();
                if (_loc_2 != null)
                {
                    if (_loc_2._mc.parent == this._map._footMap && this._mc.parent == this._map._footMap)
                    {
                        if (this._map._footMap.getChildIndex(_loc_2._mc) < this._map._footMap.getChildIndex(this._mc))
                        {
                            this._map._footMap.swapChildren(_loc_2._mc, this._mc);
                        }
                    }
                }
            }
            return;
        }// end function

        public function testTileDistance(param1)
        {
            return Math.max(Math.abs(this._currTile._x - param1._currTile._x), Math.abs(this._currTile._y - param1._currTile._y));
        }// end function

        public function draw()
        {
            var _loc_1:* = null;
            _loc_1 = {_x:this._x, _y:this._y};
            _loc_1 = this._map.mapToUnit(_loc_1);
            this._mc.x = _loc_1._x;
            this._mc.y = _loc_1._y;
            if (this._img._shiningClip != null)
            {
                if (this._img._shiningClip.parent == null)
                {
                    this._map._textMap.addChild(this._img._shiningClip);
                }
                this._img._shiningClip.x = this._mc.x + this._img._width / 3;
                this._img._shiningClip.y = this._mc.y - this._img._height / 3 * 2;
            }
            if (this._sayRect.parent == this._map._textMap)
            {
                this._sayRect.x = this._mc.x + 10;
                this._sayRect.y = this._mc.y - this._img._bitmapRect.height - this._sayRect.height;
            }
            return;
        }// end function

        public function set visible(param1:Boolean)
        {
            clearTimeout(this._visibleTimer);
            if (this._mc == null)
            {
                return;
            }
            if (param1)
            {
                if (this._map != null && this._mc.parent == null)
                {
                    this._map._footMap.addChild(this._mc);
                }
            }
            else if (this._map != null && this._map._footMap != null && this._mc != null && this._mc.parent == this._map._footMap)
            {
                this._map._footMap.removeChild(this._mc);
            }
            return;
        }// end function

        public function get visible()
        {
            if (this._mc == null || this._mc.parent == null)
            {
                return false;
            }
            return true;
        }// end function

        public function say(param1 = "", param2 = 10)
        {
            if (this._img == null || this._img._bitmapRect == null)
            {
                return;
            }
            if (param1.length > 0)
            {
                this._map._textMap.addChild(this._sayRect);
                this._sayTxt.x = 0;
                this._sayTxt.y = 0;
                this._sayTxt.width = 0;
                this._sayTxt.height = 0;
                this._sayTxt.selectable = false;
                this._sayTxt.autoSize = TextFieldAutoSize.CENTER;
                this._sayTxt.htmlText = param1;
                this._sayTxt.x = (-this._sayTxt.width) / 2;
                this._sayRect.graphics.clear();
                this._sayRect.graphics.lineStyle(0, 0, 0.2, true);
                this._sayRect.graphics.beginFill(16777215);
                this._sayRect.graphics.drawRoundRect(this._sayTxt.x - 2, 0, this._sayTxt.width + 4, this._sayTxt.height, 6, 6);
                this._sayRect.graphics.endFill();
                this._sayRect.graphics.lineStyle(0, 0, 0, true);
                this._sayRect.graphics.beginFill(16777215);
                this._sayRect.graphics.moveTo(0, 5 + this._sayTxt.height);
                this._sayRect.graphics.lineTo(-5, 0 + this._sayTxt.height);
                this._sayRect.graphics.lineTo(5, 0 + this._sayTxt.height);
                this._sayRect.graphics.lineTo(0, 5 + this._sayTxt.height);
                this._sayRect.graphics.endFill();
                this._sayRect.graphics.lineStyle(0, 0, 0.2, true);
                this._sayRect.graphics.moveTo(-5, 0 + this._sayTxt.height);
                this._sayRect.graphics.lineTo(0, 5 + this._sayTxt.height);
                this._sayRect.graphics.lineTo(5, 0 + this._sayTxt.height);
                this._sayRect.alpha = 0.8;
                this._sayRect.x = this._mc.x;
                this._sayRect.y = this._mc.y - this._img._bitmapRect.height - this._sayRect.height;
                clearTimeout(this._sayInterval);
                if (param2 > 0)
                {
                    this._sayInterval = setTimeout(this.closeSay, param2 * 1000);
                }
            }
            else
            {
                clearTimeout(this._sayInterval);
                this.closeSay();
            }
            return;
        }// end function

        private function closeSay()
        {
            if (this._sayRect != null && this._sayRect.parent != null)
            {
                this._sayRect.parent.removeChild(this._sayRect);
            }
            return;
        }// end function

        public function get slot()
        {
            if (this._position != null && this._drawer != null)
            {
                return this._drawer[this._position];
            }
            return null;
        }// end function

        public function backToSlot()
        {
            this._drawer[this._position].item = this;
            return;
        }// end function

        public function set data(param1:Object) : void
        {
            this._dynamicData = param1;
            return;
        }// end function

        public function get data() : Object
        {
            return this._dynamicData;
        }// end function

        public function addHalo(param1, param2 = 0)
        {
            var _loc_3:* = undefined;
            if (this._img != null)
            {
                if (this._haloEffect[param1] == null)
                {
                    _loc_3 = UnitClip.newUnitClip(Config._model[param1]);
                    _loc_3.shadow = false;
                    _loc_3.changeStateTo("idle");
                    _loc_3.y = param2;
                    this._haloEffect[param1] = _loc_3;
                    this._mc.addChild(_loc_3);
                    if (this._img != null)
                    {
                        this._mc.addChild(this._img);
                    }
                }
            }
            return;
        }// end function

        public function removeHalo(param1)
        {
            if (this._img != null)
            {
                if (this._haloEffect[param1] != null)
                {
                    if (this._haloEffect[param1].parent != null)
                    {
                        this._haloEffect[param1].parent.removeChild(this._haloEffect[param1]);
                    }
                    this._haloEffect[param1].destroy();
                    delete this._haloEffect[param1];
                }
            }
            return;
        }// end function

        public function get iconURL()
        {
            var _loc_1:* = undefined;
            if (this._itemData.type == 4 && (this._itemData.subType == 11 || this._itemData.subType == 13))
            {
                _loc_1 = this._itemData.icon.split("|");
                if (_loc_1.length > 0)
                {
                    return _loc_1[Math.min(int(this.star / 10), (_loc_1.length - 1))];
                }
            }
            return this._itemData.icon;
        }// end function

        public function flyToPlayer()
        {
            delete _itemStack[this._type][this._id];
            this._flyPlayerSpeed = 2;
            this._flyPlayerStartDis = Math.sqrt(Math.pow(Config.player._x - this._x, 2) + Math.pow(Config.player._y - this._y, 2));
            this.startLoop(this.flyToPlayerLoop);
            return;
        }// end function

        private function flyToPlayerLoop(param1) : void
        {
            var _loc_3:* = NaN;
            var _loc_2:* = Math.sqrt(Math.pow(Config.player._x - this._x, 2) + Math.pow(Config.player._y - this._y, 2));
            this._flyPlayerSpeed = this._flyPlayerSpeed + 2;
            if (_loc_2 < this._flyPlayerSpeed)
            {
                this.stopLoop(this.flyToPlayerLoop);
                this.destroy();
            }
            else
            {
                _loc_3 = Math.atan2(Config.player._y - this._y, Config.player._x - this._x);
                this._x = this._x + this._flyPlayerSpeed * Math.cos(_loc_3);
                this._y = this._y + this._flyPlayerSpeed * Math.sin(_loc_3);
                this._img.zoff = 48 * Math.min((this._flyPlayerStartDis - _loc_2) / this._flyPlayerStartDis, 1);
                this.draw();
            }
            return;
        }// end function

        public static function initMonsterItem()
        {
            var _loc_1:* = undefined;
            for (_loc_1 in Config._monsterMap)
            {
                
                if (Number(Config._monsterMap[_loc_1].taskItem) != 0)
                {
                    _taskItemMap[Number(Config._monsterMap[_loc_1].taskItem)] = Number(Config._monsterMap[_loc_1].id);
                }
            }
            return;
        }// end function

        public static function getTaskItemMonster(param1)
        {
            return _taskItemMap[param1];
        }// end function

        public static function createItemByBytes(param1:ByteArray, param2, param3 = null) : Item
        {
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_11:* = 0;
            var _loc_15:* = undefined;
            var _loc_16:* = 0;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            var _loc_19:* = null;
            var _loc_20:* = 0;
            var _loc_21:* = 0;
            var _loc_22:* = 0;
            var _loc_23:* = 0;
            var _loc_24:* = 0;
            var _loc_25:* = 0;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_4:* = new ByteArray();
            new ByteArray().endian = Endian.BIG_ENDIAN;
            _loc_4.writeBytes(param1, 0, param1.length);
            _loc_4.position = 0;
            if (param3 == null)
            {
                param3 = UNIT_TYPE_ENUM.TYPEID_ITEM;
            }
            var _loc_8:* = {};
            {}.baseID = param1.readUnsignedInt();
            _loc_8.binding = param1.readByte();
            _loc_8.amount = param1.readUnsignedShort();
            _loc_8.washgrade = param1.readUnsignedByte();
            _loc_8.washtime = param1.readUnsignedShort();
            _loc_8.finegrade = param1.readByte();
            _loc_8.timeout = param1.readUnsignedInt();
            _loc_8.suitID = param1.readUnsignedInt();
            var _loc_9:* = param1.readByte();
            var _loc_10:* = [];
            _loc_8.qual = _loc_9;
            if (_loc_8.qual > 0)
            {
                if (int(Config._itemMap[_loc_8.baseID].type) == 4 && (int(Config._itemMap[_loc_8.baseID].subType) == 11 || int(Config._itemMap[_loc_8.baseID].subType) == 13))
                {
                    _loc_8.nameColor = 0;
                }
                else
                {
                    _loc_8.nameColor = _loc_8.qual;
                }
            }
            _loc_11 = 0;
            while (_loc_11 < _loc_9)
            {
                
                _loc_16 = param1.readUnsignedByte();
                _loc_17 = param1.readUnsignedShort();
                _loc_10[_loc_11] = {id:_loc_16, value:_loc_17, state:0};
                _loc_11 = _loc_11 + 1;
            }
            _loc_8.addEffect = _loc_10;
            if (int(Config._itemMap[_loc_8.baseID].type) == 20)
            {
                if (_loc_10.length == 0)
                {
                    _loc_8.nameColor = 6;
                }
            }
            var _loc_12:* = param1.readByte();
            _loc_8.gem = [];
            if (_loc_12 > 0)
            {
                _loc_18 = int(Config._itemMap[_loc_8.baseID].relatedId).toString(2);
                _loc_18 = "000000" + _loc_18;
                _loc_18 = ("000000" + _loc_18).substring(_loc_18.length - 6, _loc_18.length);
            }
            _loc_11 = 0;
            while (_loc_11 < _loc_12)
            {
                
                _loc_19 = new Object();
                _loc_19.open = param1.readBoolean();
                _loc_19.id = param1.readUnsignedInt();
                _loc_19.type = parseInt(_loc_18.substr((3 - _loc_12 + _loc_11) * 2, 2), 2);
                _loc_8.gem.push(_loc_19);
                _loc_11 = _loc_11 + 1;
            }
            var _loc_13:* = {};
            {}.flag = param1.readByte();
            if (_loc_13.flag == 1)
            {
                _loc_13.svId = param1.readByte();
                _loc_13.id = param1.readUnsignedByte();
                _loc_13.value = param1.readUnsignedShort();
                _loc_13.level = param1.readUnsignedShort();
            }
            var _loc_14:* = {};
            {}.flag = param1.readByte();
            if (_loc_14.flag == 1)
            {
                _loc_14.soulLevel = param1.readUnsignedShort();
                _loc_14.soulLevelMax = param1.readUnsignedShort();
                _loc_14.soulValue = param1.readUnsignedInt();
                _loc_14.soulAllValue = param1.readUnsignedInt();
                _loc_14.soulValueMax = param1.readUnsignedInt();
                _loc_14.giftValue = param1.readUnsignedInt();
                _loc_14.growValue = int(param1.readUnsignedInt() / 100);
                _loc_20 = param1.readByte();
                _loc_14.baseProArr = [];
                _loc_14.maxFlag = false;
                _loc_5 = 0;
                while (_loc_5 < _loc_20)
                {
                    
                    _loc_26 = {};
                    _loc_26.id = param1.readUnsignedByte();
                    _loc_26.allValue = param1.readUnsignedShort();
                    _loc_26.proValue = param1.readUnsignedShort();
                    _loc_26.allproValue = _loc_26.proValue;
                    _loc_26.baseValue = param1.readUnsignedShort();
                    _loc_26.mixValue = param1.readUnsignedShort();
                    if (_loc_26.mixValue > 0)
                    {
                        _loc_14.maxFlag = true;
                    }
                    _loc_14.baseProArr.push(_loc_26);
                    _loc_5 = _loc_5 + 1;
                }
                _loc_21 = param1.readByte();
                _loc_22 = 0;
                while (_loc_22 < _loc_14.baseProArr.length)
                {
                    
                    _loc_14.baseProArr[_loc_22].qual = param1.readUnsignedShort();
                    _loc_14.baseProArr[_loc_22].washNum = param1.readUnsignedShort();
                    _loc_22 = _loc_22 + 1;
                }
                _loc_23 = param1.readByte();
                _loc_14.addProArr = [];
                _loc_11 = 0;
                while (_loc_11 < _loc_23)
                {
                    
                    _loc_27 = {};
                    _loc_27.position = param1.readByte();
                    _loc_27.svId = param1.readByte();
                    _loc_27.id = param1.readUnsignedByte();
                    _loc_27.value = param1.readUnsignedShort();
                    _loc_27.level = param1.readUnsignedShort();
                    _loc_27.nextPoint = param1.readUnsignedInt();
                    _loc_14.addProArr.push(_loc_27);
                    _loc_11 = _loc_11 + 1;
                }
                _loc_24 = param1.readByte();
                _loc_14.skillArr = [];
                _loc_25 = 0;
                while (_loc_25 < _loc_24)
                {
                    
                    _loc_28 = {};
                    _loc_28.lock = param1.readByte();
                    _loc_28.cardId = param1.readUnsignedInt();
                    _loc_28.skillId = param1.readUnsignedInt();
                    _loc_28.level = param1.readUnsignedInt();
                    _loc_14.skillArr.push(_loc_28);
                    _loc_25 = _loc_25 + 1;
                }
            }
            _loc_7 = _loc_8.baseID;
            if (Config._itemMap[_loc_8.baseID] == null)
            {
                trace("没找到物品模型" + _loc_8.baseID);
                _loc_7 = 21101;
            }
            _loc_6 = Item.newItem(Config._itemMap[_loc_7], 0, 0, param3, param2);
            _loc_6.amount = _loc_8.amount;
            _loc_6._petBookObj = _loc_13;
            _loc_6._petObj = _loc_14;
            for (_loc_15 in _loc_8)
            {
                
                _loc_6._itemData[_loc_15] = _loc_8[_loc_15];
            }
            return _loc_6;
        }// end function

        public static function getItem(param1, param2)
        {
            if (_itemStack[param1] != null)
            {
                if (_itemStack[param1][param2] != null)
                {
                    return _itemStack[param1][param2];
                }
            }
            return null;
        }// end function

        public static function newItem(param1, param2, param3, param4, param5)
        {
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_9:* = _allCount + 1;
            _allCount = _loc_9;
            if (_objectPool.length == 0)
            {
                return new Item(param1, param2, param3, param4, param5);
            }
            _loc_6 = _objectPool.shift();
            _loc_6._data = param1;
            _loc_6._x = param2;
            _loc_6._y = param3;
            _loc_6._id = param5;
            _loc_6._type = param4;
            _loc_6._itemData = {};
            _loc_6._itemData.addEffect = [];
            _loc_6._itemData.gem = [];
            _loc_6._itemData.washgrade = 0;
            _loc_6._itemData.washtime = 0;
            _loc_6._itemData.finegrade = 0;
            _loc_6._itemData.suitID = 0;
            _loc_6._itemData.qual = 0;
            _loc_6._petBookObj = {};
            _loc_6._petObj = {};
            _loc_6.setItemData();
            if (_itemStack[_loc_6._type] == null)
            {
                _itemStack[_loc_6._type] = {};
            }
            _itemStack[_loc_6._type][_loc_6._id] = _loc_6;
            _loc_6._enterframeListenerArray = [];
            _loc_7 = new Date();
            _loc_6.cd = Math.max(0, _cdStack[_loc_6._itemData.relatedId] - _loc_7.getTime());
            return _loc_6;
        }// end function

        public static function get itemArray()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = [];
            for (_loc_1 in _itemStack)
            {
                
                for (_loc_2 in _itemStack[_loc_1])
                {
                    
                    _loc_3.push(_itemStack[_loc_1][_loc_2]);
                }
            }
            return _loc_3;
        }// end function

        public static function destroyAll()
        {
            var _loc_1:* = itemArray;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_1[_loc_2].destroy();
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public static function destroyMap(param1 = null)
        {
            var _loc_2:* = itemArray;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3]._map != null && (param1 == null || param1 == _loc_2[_loc_3]._map))
                {
                    _loc_2[_loc_3].destroy();
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public static function getXmlIcon(param1)
        {
            var _loc_2:* = String(param1.icon).split("|");
            return _loc_2[0];
        }// end function

    }
}
