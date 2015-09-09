package lovefox.gui
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.component.*;
    import lovefox.unit.*;

    public class Ubb extends Sprite
    {
        public var _type:uint;
        public var _name:String;
        private var _bmp:Bitmap;
        private var _imgArray:Array;
        private var _imgIndex:uint;
        private var _index:uint;
        private var _imgIntervalCount:Object;
        private var _id:Object;
        private var _playerId:int;
        private var _playerVIP:int;
        private var _playerLevel:int;
        private var _playerJobID:int;
        private var _unitType:Object;
        private var _getUnitDict:Dictionary;
        private var _getPicDict:Dictionary;
        private var _infoItem:Item;
        public static var TYPE_FACE:Object = 0;
        public static var TYPE_ITEM:Object = 1;
        public static var TYPE_PET:Object = 2;
        public static var TYPE_NAME:Object = 3;
        public static var TYPE_LINK:Object = 4;
        public static var TYPE_MONSTER:Object = 10;
        public static var TYPE_COM:Object = 11;
        public static var TYPE_TEXT:Object = 12;
        private static var _bmpBuff:Object = [];
        private static var _imgInterval:Object = 4;
        public static var _ubbW:Object = 15;
        public static var _ubbH:Object = 12;

        public function Ubb(param1:String)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this._getUnitDict = new Dictionary();
            this._getPicDict = new Dictionary();
            name = param1.substring(0, 3) + Base64.decode(param1.substring(3, (param1.length - 1))) + param1.substring((param1.length - 1));
            var _loc_2:* = name.substring(0, 3);
            if (_loc_2 == "<i:")
            {
                this._name = param1;
            }
            else
            {
                this._name = name;
            }
            if (_loc_2 == "<f:")
            {
                this._index = Number(name.substring(3, (name.length - 1)));
                this._type = TYPE_FACE;
                _loc_6 = _bmpBuff[this._index];
                _loc_7 = _loc_6.width / _ubbW;
                this._imgArray = [];
                _loc_8 = 0;
                while (_loc_8 < _loc_7)
                {
                    
                    _loc_9 = new BitmapData(_ubbW, _ubbH, true, 0);
                    _loc_9.copyPixels(_loc_6, new Rectangle(_ubbW * _loc_8, 0, _ubbW, _ubbH), new Point(), null, null, true);
                    this._imgArray[_loc_8] = _loc_9;
                    _loc_8 = _loc_8 + 1;
                }
                this._bmp = new Bitmap(this._imgArray[0]);
                this._imgIndex = 1;
                this._imgIntervalCount = _imgInterval;
                addChild(this._bmp);
                removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
                removeEventListener(Event.ADDED_TO_STAGE, this.handleAdded);
                removeEventListener(Event.REMOVED_FROM_STAGE, this.handleRemoved);
                addEventListener(Event.ADDED_TO_STAGE, this.handleAdded);
                addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemoved);
            }
            else if (_loc_2 == "<i:")
            {
                _loc_10 = JSON.decode(this._name.substring(3, (this._name.length - 1)));
                _loc_3 = _loc_10.name;
                this._type = TYPE_ITEM;
                this._bmp = new Bitmap(Text2Bitmap.toBmp(_loc_3, 13369344, 12, Text2Bitmap.SHADOW));
                buttonMode = true;
                addChild(this._bmp);
                addEventListener(MouseEvent.CLICK, this.handleClick);
            }
            else if (_loc_2 == "<l:")
            {
                _loc_3 = name.substring(3, name.indexOf(","));
                this._id = Number(name.substring((name.indexOf(",") + 1), name.lastIndexOf(",")));
                this._type = TYPE_LINK;
                this._bmp = new Bitmap(Text2Bitmap.toBmp(_loc_3, 16750855, 12, Text2Bitmap.SHADOW));
                buttonMode = true;
                addChild(this._bmp);
                addEventListener(MouseEvent.CLICK, this.handleClick);
            }
            else if (_loc_2 == "<p:")
            {
                this._type = TYPE_PET;
            }
            else if (_loc_2 == "<n:")
            {
                this._type = TYPE_NAME;
                _loc_3 = name.substring(3, name.indexOf(">"));
                _loc_5 = true;
                _loc_11 = _loc_3.split("^");
                this._playerVIP = -1;
                this._playerLevel = -1;
                this._playerJobID = -1;
                if (_loc_11.length > 1)
                {
                    _loc_4 = Number(_loc_3.substring((_loc_3.lastIndexOf("^") + 1)));
                    if (isNaN(Number(_loc_11[1])))
                    {
                        _loc_5 = false;
                    }
                    if (_loc_11.length == 4)
                    {
                        this._playerLevel = Number(_loc_11[2]);
                        this._playerJobID = Number(_loc_11[3]);
                    }
                    else if (_loc_11.length == 5)
                    {
                        this._playerVIP = Number(_loc_11[2]);
                        this._playerLevel = Number(_loc_11[3]);
                        this._playerJobID = Number(_loc_11[4]);
                    }
                }
                else
                {
                    _loc_5 = false;
                }
                if (_loc_5)
                {
                    this._id = _loc_11[0];
                    this._playerId = Number(_loc_11[1]);
                }
                else
                {
                    this._id = _loc_3;
                    this._playerId = -1;
                }
                _loc_12 = Text2Bitmap.toBmpFullName(this._id, 52224, 12, Text2Bitmap.SHADOW);
                if (this._playerVIP > 0)
                {
                    _loc_13 = Text2Bitmap.toBmpFullName("VIP" + this._playerVIP, 15689774, 12);
                    _loc_14 = new BitmapData(_loc_13.width + _loc_12.width + 2, Math.max(_loc_12.height, _loc_13.height), true, 0);
                    _loc_14.copyPixels(_loc_13, _loc_13.rect, new Point(0, _loc_14.height - _loc_13.height));
                    _loc_14.copyPixels(_loc_12, _loc_12.rect, new Point(_loc_13.width + 2, _loc_14.height - _loc_12.height));
                    _loc_12.dispose();
                    _loc_13.dispose();
                    this._bmp = new Bitmap(_loc_14);
                }
                else
                {
                    this._bmp = new Bitmap(_loc_12);
                }
                buttonMode = true;
                addChild(this._bmp);
                if (this._id != Player.name)
                {
                    addEventListener(MouseEvent.CLICK, this.handleClick);
                }
            }
            else if (_loc_2 == "<u:")
            {
                this._type = TYPE_MONSTER;
                _loc_3 = name.substring(3, name.indexOf(">")).split(",");
                this._unitType = Number(_loc_3[0]);
                this._id = Number(_loc_3[1]);
                if (this._unitType == 0)
                {
                    this._bmp = new Bitmap(this.getUnit(Config._model[Config._monsterMap[this._id].model], 32, 32));
                }
                else if (this._unitType == 1)
                {
                    this._bmp = new Bitmap(this.getUnit(Config._model[Config._npcMap[this._id].model], 32, 32));
                }
                else if (this._unitType == 2)
                {
                    this._bmp = new Bitmap(Config.findIcon(Config._itemMap[this._id]["icon"]));
                }
                else if (this._unitType == 3)
                {
                    this._bmp = new Bitmap(this.getUnit(Config._model[Config._gatherMap[this._id].model], 32, 32));
                }
                addChild(this._bmp);
            }
            else if (_loc_2 == "<c:")
            {
                this._type = TYPE_COM;
                _loc_3 = name.substring(3, name.indexOf(">")).split(",");
                _loc_4 = Number(_loc_3[0]);
                _loc_5 = String(_loc_3[1]);
                if (_loc_4 == 0)
                {
                    this._bmp = new Bitmap(this.getTable(_loc_5, Number(_loc_3[2]), Number(_loc_3[3]), String(_loc_3[4])));
                }
                else if (_loc_4 == 1)
                {
                    this._bmp = new Bitmap(this.getPic(_loc_5, 32, 32));
                }
                addChild(this._bmp);
            }
            else if (_loc_2 == "<t:")
            {
                this._type = TYPE_TEXT;
                _loc_3 = name.substring(3, name.indexOf(">")).split(",");
                _loc_4 = String(_loc_3[0]);
                _loc_5 = String(_loc_3[1]);
                this._bmp = new Bitmap(Text2Bitmap.toBmp(_loc_4, Number("0x" + _loc_5), 12));
                addChild(this._bmp);
            }
            else if (_loc_2 == "<u>")
            {
                _loc_15 = new ClickLabel(this, 0, 3, name, this.linkFuc);
                _loc_15.clickColor([6614260, 15590939]);
            }
            return;
        }// end function

        public function get index()
        {
            return this._index;
        }// end function

        private function getTable(param1, param2, param3, param4)
        {
            var _loc_5:* = new Sprite();
            var _loc_6:* = new Table(param1);
            new Table(param1).resize(param2, param3);
            _loc_5.addChild(_loc_6);
            var _loc_7:* = Config.getSimpleTextField();
            Config.getSimpleTextField().text = param4;
            _loc_7.x = (param2 - _loc_7.width) / 2;
            _loc_7.y = (param3 - _loc_7.height) / 2;
            _loc_7.textColor = Style.WINDOW_FONT;
            _loc_5.addChild(_loc_7);
            var _loc_8:* = new BitmapData(param2, param3, true, 0);
            var _loc_9:* = new Matrix();
            _loc_8.draw(_loc_5, _loc_9, null, null, null, true);
            _loc_6.destroy();
            return _loc_8;
        }// end function

        private function getPic(param1, param2, param3)
        {
            var _loc_6:* = undefined;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_4:* = BitmapLoader.pick(param1);
            var _loc_5:* = new BitmapData(param2, param3, true, 0);
            if (_loc_4 != null)
            {
                _loc_6 = Math.min(_loc_5.width / _loc_4.width, _loc_5.height / _loc_4.height);
                _loc_7 = new Matrix();
                _loc_7.scale(_loc_6, _loc_6);
                _loc_5.draw(_loc_4, _loc_7, null, null, null, true);
            }
            else
            {
                _loc_8 = BitmapLoader.newBitmapLoader();
                this._getPicDict[_loc_8] = {bmpd:_loc_5, url:param1};
                _loc_8.addEventListener("complete", this.subGetPic);
                _loc_8.load([param1]);
            }
            return _loc_5;
        }// end function

        private function subGetPic(param1)
        {
            var obj:*;
            var bmp:*;
            var ratio:*;
            var matrix:Matrix;
            var event:* = param1;
            event.target.removeEventListener("complete", this.subGetPic);
            try
            {
                obj = this._getPicDict[event.target];
                bmp = BitmapLoader.pick(obj.url);
                ratio = Math.min(obj.bmpd.width / bmp.width, obj.bmpd.height / bmp.height);
                matrix = new Matrix();
                matrix.scale(ratio, ratio);
                obj.bmpd.draw(bmp, matrix, null, null, null, true);
                bmp.dispose();
            }
            catch (e)
            {
            }
            delete this._getUnitDict[event.target];
            return;
        }// end function

        private function getUnit(param1, param2, param3)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_12:* = undefined;
            var _loc_8:* = Number(param1.width);
            var _loc_9:* = Number(param1.height);
            var _loc_10:* = UnitClip._modelURL + param1.id + ".mod";
            _loc_6 = new BitmapData(param2, param3, true, 0);
            var _loc_11:* = FileLoader.pick(_loc_10);
            if (FileLoader.pick(_loc_10) != null)
            {
                this.subGetUnit(_loc_6, _loc_11);
            }
            else
            {
                _loc_12 = new FileLoader();
                this._getUnitDict[_loc_12] = {bmpd1:_loc_6, url:_loc_10, w:_loc_8, h:_loc_9};
                _loc_12.addEventListener("complete", this.handleGetUnit);
                _loc_12.load([_loc_10]);
            }
            return _loc_6;
        }// end function

        private function handleGetUnit(param1)
        {
            param1.target.removeEventListener("complete", this.subGetUnit);
            this.subGetUnit(this._getUnitDict[param1.target].bmpd1, FileLoader.pick(this._getUnitDict[param1.target].url));
            delete this._getUnitDict[param1.target];
            return;
        }// end function

        private function subGetUnit(param1, param2)
        {
            var i:*;
            var j:*;
            var picBytes:ByteArray;
            var actionArr:*;
            var bmpd:*;
            var ratio:*;
            var matrix:Matrix;
            var bmpd1:* = param1;
            var modObj:* = param2;
            try
            {
                actionArr;
                var _loc_4:* = 0;
                var _loc_5:* = modObj._unitObj;
                while (_loc_5 in _loc_4)
                {
                    
                    i = _loc_5[_loc_4];
                    if (picBytes == null || i == "idle")
                    {
                        picBytes = modObj._unitObj[i][0][int(modObj._unitObj[i][0].length / 2)];
                    }
                }
                bmpd = PNGDecoder.decode(picBytes);
                ratio = Math.min(bmpd1.width / bmpd.width, bmpd1.height / bmpd.height);
                matrix = new Matrix();
                matrix.scale(ratio, ratio);
                bmpd1.draw(bmpd, matrix, null, null, null, true);
                bmpd.dispose();
            }
            catch (e)
            {
            }
            return;
        }// end function

        private function handleMouseOut(param1)
        {
            Holder.closeInfo();
            removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            return;
        }// end function

        private function getInfoItem(param1:String)
        {
            var _loc_2:* = JSON.decode(param1.substring(3, (this._name.length - 1)));
            var _loc_3:* = Item.newItem(Config._itemMap[_loc_2.id], 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 0);
            _loc_3.amount = _loc_2.amount;
            _loc_3._itemData.binding = _loc_2.binding;
            _loc_3._itemData.finegrade = _loc_2.finegrade;
            _loc_3._itemData.washgrade = _loc_2.washgrade;
            _loc_3._itemData.timeout = _loc_2.timeout;
            _loc_3._itemData.suitID = _loc_2.suitID;
            _loc_3._itemData.addEffect = _loc_2.addEffect;
            _loc_3._itemData.qual = _loc_2.addEffect.length;
            if (_loc_3._itemData.qual > 0)
            {
                _loc_3._itemData.nameColor = _loc_3._itemData.qual;
            }
            _loc_3._itemData.gem = _loc_2.gem;
            _loc_3._petBookObj = _loc_2._petBookObj;
            _loc_3._petObj = _loc_2._petObj;
            return _loc_3;
        }// end function

        private function handleClick(event:MouseEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (this._type == TYPE_ITEM)
            {
                removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
                addEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
                _loc_2 = new Point(x, y);
                _loc_2 = parent.localToGlobal(_loc_2);
                _loc_3 = new Rectangle(_loc_2.x, _loc_2.y, this._bmp.width, this._bmp.height);
                if (this._infoItem == null)
                {
                    this._infoItem = this.getInfoItem(this._name);
                    this._infoItem.display();
                }
                Holder.showInfo(this._infoItem.outputInfo(), _loc_3, true, 0, 250, this._infoItem.star, this._infoItem);
            }
            else if (this._type == TYPE_LINK)
            {
                _loc_4 = new URLRequest(String(this._name.substring((this._name.indexOf(",") + 1), (this._name.length - 1))));
                navigateToURL(_loc_4, "_blank");
            }
            else if (this._type == TYPE_NAME)
            {
                _loc_5 = new Array();
                if (Config._switchMobage)
                {
                    if (this._playerId != -1)
                    {
                        _loc_6 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5), Config.language("Ubb", 8), Config.language("Ubb", 7)];
                        _loc_7 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5), Config.language("Ubb", 8)];
                    }
                    else
                    {
                        _loc_6 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5), Config.language("Ubb", 7)];
                        _loc_7 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5)];
                    }
                }
                else if (this._playerId != -1)
                {
                    _loc_6 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 2), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5), Config.language("Ubb", 6), Config.language("Ubb", 8), Config.language("Ubb", 7)];
                    _loc_7 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 2), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5), Config.language("Ubb", 6), Config.language("Ubb", 8)];
                }
                else
                {
                    _loc_6 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 2), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5), Config.language("Ubb", 6), Config.language("Ubb", 7)];
                    _loc_7 = [Config.language("Ubb", 10), Config.language("Ubb", 9), Config.language("Ubb", 1), Config.language("Ubb", 2), Config.language("Ubb", 3), Config.language("Ubb", 4), Config.language("Ubb", 5), Config.language("Ubb", 6)];
                }
                if (Config.ui._gangs.mytype == 0)
                {
                    _loc_5 = _loc_7;
                }
                else if (Config.ui._gangs.mytype == 1 || Config.ui._gangs.mytype == 2 || Config.ui._gangs.mytype == 3)
                {
                    _loc_5 = _loc_6;
                }
                else
                {
                    _loc_5 = _loc_7;
                }
                _loc_5 = _loc_5;
                if (this._playerLevel != -1)
                {
                    _loc_8 = "<b>[" + this._id + "]</b>\nLv " + this._playerLevel + "  " + Config._jobTitleMap[this._playerJobID];
                    DropDown.dropDown(_loc_5, this.handleDropDownClick, _loc_8);
                }
                else
                {
                    DropDown.dropDown(_loc_5, this.handleDropDownClick);
                }
            }
            return;
        }// end function

        private function handleDropDownClick(param1)
        {
            if (Config._switchMobage)
            {
                if (param1 > 2)
                {
                    param1 = param1 + 1;
                }
                if (param1 > 6)
                {
                    param1 = param1 + 1;
                }
            }
            if (this._playerId == -1)
            {
                if (param1 == 0)
                {
                    if (Config.ui._giveflower.todaysendnum < 5)
                    {
                        Config.ui._giveflower.open();
                        Config.ui._giveflower.flowerplayerid = this._id;
                        Config.ui._giveflower.flowerplayername = this._name;
                    }
                    else
                    {
                        Config.message(Config.language("Ubb", 11));
                    }
                }
                else if (param1 == 1)
                {
                    Config.ui._teamUI.inviteTeam(this._playerId);
                }
                else if (param1 == 2)
                {
                    Config.ui._friendUI.addFriend(this._id);
                }
                else if (param1 == 3)
                {
                    Config.ui._chatUI.whisperTo(this._id);
                }
                else if (param1 == 4)
                {
                    Config.ui._mailpanel.sendmailshow(null, this._id);
                    Config.ui._mailpanel.open();
                }
                else if (param1 == 5)
                {
                    Config.ui._blackmarket.sendsalename(this._id);
                }
                else if (param1 == 6)
                {
                    Config.ui._friendUI.sendAddEnemy(this._id);
                }
                else if (param1 == 7)
                {
                    Config.ui._friendUI.sendaddblack(null, this._id);
                }
                else if (param1 == 8)
                {
                    Config.ui._gangs.inviteguild(this._id);
                }
            }
            else if (param1 == 0)
            {
                if (Config.ui._giveflower.todaysendnum < 5)
                {
                    Config.ui._giveflower.open();
                    Config.ui._giveflower.flowerplayerid = this._playerId;
                    Config.ui._giveflower.flowerplayername = this._id;
                }
                else
                {
                    Config.message("今日赠送次数已用完");
                }
            }
            else if (param1 == 1)
            {
                Config.ui._teamUI.inviteTeam(this._playerId);
            }
            else if (param1 == 2)
            {
                Config.ui._friendUI.addFriend(this._id);
            }
            else if (param1 == 3)
            {
                Config.ui._chatUI.whisperTo(this._id);
            }
            else if (param1 == 4)
            {
                Config.ui._mailpanel.sendmailshow(null, this._id);
                Config.ui._mailpanel.open();
            }
            else if (param1 == 5)
            {
                Config.ui._blackmarket.sendsalename(this._id);
            }
            else if (param1 == 6)
            {
                Config.ui._friendUI.sendAddEnemy(this._id);
            }
            else if (param1 == 7)
            {
                Config.ui._friendUI.sendaddblack(null, this._id);
            }
            else if (param1 == 8)
            {
                Config.ui._pkUI.invitePk(this._playerId, this._id);
            }
            else if (param1 == 9)
            {
                Config.ui._gangs.inviteguild(this._id);
            }
            return;
        }// end function

        private function handleEnterFrame(param1)
        {
            if (this._imgIntervalCount <= 0)
            {
                if (this._imgIndex >= this._imgArray.length)
                {
                    this._imgIndex = 0;
                }
                this._bmp.bitmapData = this._imgArray[this._imgIndex];
                var _loc_2:* = this;
                var _loc_3:* = this._imgIndex + 1;
                _loc_2._imgIndex = _loc_3;
                this._imgIntervalCount = _imgInterval;
            }
            else
            {
                var _loc_2:* = this;
                var _loc_3:* = this._imgIntervalCount - 1;
                _loc_2._imgIntervalCount = _loc_3;
            }
            return;
        }// end function

        private function handleAdded(param1)
        {
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        private function handleRemoved(param1)
        {
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        public function destroy()
        {
            var i:*;
            removeEventListener(MouseEvent.ROLL_OUT, this.handleMouseOut);
            removeEventListener(MouseEvent.CLICK, this.handleClick);
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            removeEventListener(Event.ADDED_TO_STAGE, this.handleAdded);
            removeEventListener(Event.REMOVED_FROM_STAGE, this.handleRemoved);
            if (this._imgArray != null)
            {
                i;
                while (i < this._imgArray.length)
                {
                    
                    this._imgArray[i].dispose();
                    i = (i + 1);
                }
            }
            if (this._bmp != null && this._bmp.bitmapData != null)
            {
                try
                {
                    this._bmp.bitmapData.dispose();
                }
                catch (e)
                {
                }
                try
                {
                }
                Config.clearDisplayList(this);
            }
            catch (e)
            {
            }
            if (this._infoItem != null)
            {
                this._infoItem.destroy();
                this._infoItem = null;
            }
            return;
        }// end function

        public function get label()
        {
            if (this._type == TYPE_ITEM)
            {
                return this._name;
            }
            return this._name.substring(0, 3) + Base64.encode(this._name.substring(3, (this._name.length - 1))) + this._name.substring((this._name.length - 1));
        }// end function

        private function linkFuc(event:TextEvent) : void
        {
            DescriptionTranslate.handleTextClick(null, event.text);
            return;
        }// end function

        public static function init()
        {
            var _loc_2:* = undefined;
            var _loc_1:* = Config._ubbMap;
            for (_loc_2 in _loc_1)
            {
                
                _bmpBuff[_loc_2] = BitmapLoader.pick(_loc_1[_loc_2].dir);
            }
            return;
        }// end function

    }
}
