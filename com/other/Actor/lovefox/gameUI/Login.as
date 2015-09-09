package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.net.*;
    import flash.text.*;
    import flash.utils.*;
    import lovefox.buffer.*;
    import lovefox.gui.*;
    import lovefox.isometric.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class Login extends Sprite
    {
        private var _width:Object;
        private var _height:Object;
        private var _charStack:Array;
        private var _createChar:Object;
        private var _selectedChar:Object;
        private var _page:Object;
        private var _beginBtn:PushButton;
        private var _createBtn:PushButton;
        private var _listPanel:Sprite;
        private var _listPanelArray:Array;
        private var _listRectArray:Array;
        private var _listLabelArray:Array;
        private var _listFilter:Array;
        private var _createPanelArray:Array;
        private var _createRectArray:Array;
        private var _loginPanel:Panel;
        private var _createPanel:Sprite;
        private var login_nameTi:InputText;
        private var _soundbtn:CheckBox;
        private var _mask:Sprite;
        private var _listBg:GPanel;
        private var _listBgW:Object;
        private var _listBgH:Object;
        private var _createBg:GPanel;
        private var _polygon:Polygon;
        private var _charSprite:Sprite;
        private var _charBmp:Bitmap;
        private var _charFlag:Boolean = false;
        private var _charBmpd:BitmapData;
        private var _charCMF:ColorMatrixFilter;
        private var _charId:uint;
        private var _charLoader:BitmapLoader;
        private var _firstSwitch:Boolean = true;
        private var _loginSessionKey:String;
        private var _loginAccountId:uint;
        private var _autoLoginTimer:uint;
        private var _autoLoginSelectedChar:Object;
        private var _removeTimeTotal:Object = 259200;
        private var _removePB:PushButton;
        private var _removeAlertID:Number;
        private var _preRemoveID:int;
        private var _p:int = 0;
        private var _mp:int = 0;
        private var _pButtonLayer:Sprite;
        private var _pButtons:Array;
        private var _jian:Shape;
        private var _jianCount:int = 0;
        private var _loading:TextField;
        private var _loadingPer:Number = 0;
        private var _connect:TextField;
        private var _initializing:TextField;
        private var _loadingBG:Shape;
        private var _loadingPanel:Table;
        private var _loadingPanelContent:Sprite;
        private var _loadingPanelContentMask:Shape;
        private var _preQueue:int = -1;
        private var _queueTF:TextField;
        private var _queuePB:PushButton;
        private var _queueBG:Shape;
        private var _queuePanel:Table;
        private var _queuePanelContent:Sprite;
        private var _queuePanelContentMask:Shape;
        private var _filters3:Array;
        private var _filters1:Array;
        private var _filters2:Array;
        private var _ranNameInited:Boolean = false;
        private var _ranNameStacks:Array;
        private var selectedCharCreate:Object = 0;
        private var _nameIT:InputText;
        private var _queueTimer:Number;
        private var roleNum:uint;
        private var _createpbtn:PushButton;
        private var _sprceate:Sprite;
        private var _infoSpr:Sprite;
        private static var _grayFilter:Object = [new ColorMatrixFilter([0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0.3, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0]), new ColorMatrixFilter([0.94, 0, 0, 0, 0, 0, 0.9, 0, 0, 0, 0, 0, 0.8, 0, 0, 0, 0, 0, 1, 0])];
        private static var _ungrayFilter:Object = [new DropShadowFilter(6, 45, 0, 0.5, 6, 6, 1, BitmapFilterQuality.HIGH)];

        public function Login()
        {
            this._charStack = [];
            this._listPanelArray = [];
            this._listRectArray = [];
            this._listLabelArray = [];
            this._listFilter = [];
            this._createPanelArray = [];
            this._createRectArray = [];
            this._charCMF = new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0]);
            this._pButtons = [];
            this._filters3 = [new GlowFilter(0, 1, 1.2, 1.2), new GlowFilter(11344686, 1, 5, 5, 2, 3, true, true)];
            this._filters1 = [new GlowFilter(0, 1, 1.2, 1.2), new GlowFilter(Style.WINDOW_FONT, 1, 5, 5, 2, 3, true, true)];
            this._filters2 = [new GlowFilter(0, 1, 1.2, 1.2), new GlowFilter(5987163, 1, 5, 5, 2, 3, true, true)];
            this._ranNameStacks = [];
            return;
        }// end function

        public function init()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_LOGIN, this.handleLoginGame);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_LOGIN_USER, this.handleLoginRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_LIST, this.handleRoleList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_SELECT, this.handlePlayGameRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_CREATE, this.handleCreateRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_DELETE, this.handleRemoveRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_QUEUE_UPDATE, this.handleQueueUpdate);
            this.initDraw();
            Config.startLoop(this.afterSwitch);
            Config.startLoop(this.removeTimeLoop);
            return;
        }// end function

        private function setLogin()
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = null;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = undefined;
            var _loc_20:* = undefined;
            var _loc_21:* = undefined;
            var _loc_22:* = undefined;
            if (this._mp > 1)
            {
                this._pButtonLayer.visible = true;
            }
            else
            {
                this._pButtonLayer.visible = false;
            }
            var _loc_1:* = this._charStack;
            var _loc_23:* = 0;
            _loc_2 = 0;
            while (_loc_2 < this._pButtons.length)
            {
                
                if (_loc_2 == this._p)
                {
                    this._pButtons[_loc_2].selected = true;
                }
                else
                {
                    this._pButtons[_loc_2].selected = false;
                }
                _loc_2 = _loc_2 + 1;
            }
            _loc_2 = 0;
            while (_loc_2 < 3)
            {
                
                _loc_23 = this._p * 3 + _loc_2;
                if (_loc_1[_loc_23] == null)
                {
                    delete this._listFilter[_loc_2];
                    this._listPanelArray[_loc_2].filters = _ungrayFilter;
                    if (this._p == 0)
                    {
                        this._listPanelArray[_loc_2].visible = true;
                        this._listRectArray[_loc_2].clip = null;
                        this._listRectArray[_loc_2].data = {index:_loc_2};
                        this._listLabelArray[_loc_2].text = Config.language("Login", 1);
                    }
                    else
                    {
                        this._listPanelArray[_loc_2].visible = false;
                    }
                }
                else
                {
                    this._listPanelArray[_loc_2].visible = true;
                    if (_loc_1[_loc_23].status == 5)
                    {
                        this._listFilter[_loc_23] = true;
                        this._listPanelArray[_loc_2].filters = _grayFilter;
                    }
                    else
                    {
                        this._listFilter[_loc_23] = false;
                        this._listPanelArray[_loc_2].filters = _ungrayFilter;
                    }
                    _loc_22 = _loc_1[_loc_23];
                    _loc_4 = _loc_22.sex;
                    _loc_5 = _loc_22.job;
                    _loc_6 = _loc_22.hair;
                    _loc_3 = Config._charactorMap[(_loc_4 - 1) * 12 + _loc_5];
                    this._listRectArray[_loc_2].clip = Config._model[_loc_3.model];
                    this._listRectArray[_loc_2].clip.multiLayer = true;
                    this._listRectArray[_loc_2].clip.layerStack = _loc_3.id;
                    if (_loc_6 != 0)
                    {
                        if (_loc_5 == 1)
                        {
                            if (_loc_4 == 1)
                            {
                                _loc_7 = Config._model[Number(Config._hairMap[_loc_6].fightMale)];
                            }
                            else
                            {
                                _loc_7 = Config._model[Number(Config._hairMap[_loc_6].fightFemale)];
                            }
                        }
                        else if (_loc_5 == 4)
                        {
                            if (_loc_4 == 1)
                            {
                                _loc_7 = Config._model[Number(Config._hairMap[_loc_6].rangerMale)];
                            }
                            else
                            {
                                _loc_7 = Config._model[Number(Config._hairMap[_loc_6].rangerFemale)];
                            }
                        }
                        else if (_loc_5 == 10)
                        {
                            if (_loc_4 == 1)
                            {
                                _loc_7 = Config._model[Number(Config._hairMap[_loc_6].magicMale)];
                            }
                            else
                            {
                                _loc_7 = Config._model[Number(Config._hairMap[_loc_6].magicFemale)];
                            }
                        }
                        this._listRectArray[_loc_2].clip.hair = _loc_7;
                    }
                    else
                    {
                        this._listRectArray[_loc_2].clip.hair = Config._model[Number(_loc_3.hair.style0)];
                    }
                    if (_loc_22.weaponId > 0)
                    {
                        _loc_11 = Config._itemMap[_loc_22.weaponId];
                        if (_loc_4 == 1)
                        {
                            _loc_13 = Config._model[Number(_loc_11.mModel)];
                        }
                        else
                        {
                            _loc_13 = Config._model[Number(_loc_11.fModel)];
                        }
                        this._listRectArray[_loc_2].clip.weapon = _loc_13;
                    }
                    if (_loc_22.szId > 0 && _loc_22.showEquip == 0)
                    {
                        _loc_11 = Config._itemMap[_loc_22.szId];
                        if (_loc_4 == 1)
                        {
                            _loc_14 = String(_loc_11.mModel);
                        }
                        else
                        {
                            _loc_14 = String(_loc_11.fModel);
                        }
                        if (_loc_14.indexOf(":") == -1)
                        {
                            _loc_13 = Config._model[Number(_loc_14)];
                        }
                        else
                        {
                            _loc_15 = _loc_14.split(":");
                            if (_loc_5 == 1)
                            {
                                _loc_13 = Config._model[Number(_loc_15[0])];
                            }
                            else if (_loc_5 == 4)
                            {
                                _loc_13 = Config._model[Number(_loc_15[1])];
                            }
                            else if (_loc_5 == 10)
                            {
                                _loc_13 = Config._model[Number(_loc_15[2])];
                            }
                        }
                        this._listRectArray[_loc_2].clip.cloth = _loc_13;
                    }
                    else
                    {
                        this._listRectArray[_loc_2].clip.cloth = Config._model[Number(_loc_3.cloth)];
                    }
                    if (_loc_22.wingId > 0)
                    {
                        _loc_11 = Config._itemMap[_loc_22.wingId];
                        if (_loc_4 == 1)
                        {
                            _loc_14 = String(_loc_11.mModel);
                        }
                        else
                        {
                            _loc_14 = String(_loc_11.fModel);
                        }
                        if (_loc_14.indexOf("|") == -1)
                        {
                            _loc_18 = _loc_14;
                        }
                        else
                        {
                            _loc_15 = _loc_14.split("|");
                            if (_loc_22.wingLevel < 10)
                            {
                                _loc_18 = String(_loc_15[0]);
                            }
                            else if (_loc_22.wingLevel < 20)
                            {
                                _loc_18 = String(_loc_15[1]);
                            }
                            else if (_loc_22.wingLevel < 30)
                            {
                                _loc_18 = String(_loc_15[2]);
                            }
                            else
                            {
                                _loc_18 = String(_loc_15[3]);
                            }
                        }
                        if (_loc_18.indexOf(";") == -1)
                        {
                            _loc_19 = _loc_18;
                        }
                        else
                        {
                            _loc_20 = _loc_18.split(";");
                            if (_loc_5 == 1)
                            {
                                _loc_19 = String(_loc_20[0]);
                            }
                            else if (_loc_5 == 4)
                            {
                                _loc_19 = String(_loc_20[1]);
                            }
                            else if (_loc_5 == 10)
                            {
                                _loc_19 = String(_loc_20[2]);
                            }
                        }
                        _loc_21 = _loc_19.split(",");
                        _loc_16 = Config._model[Number(_loc_21[0])];
                        _loc_17 = Config._model[Number(_loc_21[1])];
                        this._listRectArray[_loc_2].clip.lWing = _loc_16;
                        this._listRectArray[_loc_2].clip.rWing = _loc_17;
                    }
                    this._listRectArray[_loc_2].data = _loc_1[_loc_23];
                    this._listRectArray[_loc_2].data.index = _loc_2;
                    this._listLabelArray[_loc_2].text = _loc_1[_loc_23].name + "\n\nLV  " + _loc_1[_loc_23].level;
                    if (this._selectedChar - this._p * 3 == _loc_2)
                    {
                        this._listRectArray[_loc_2].selected = true;
                    }
                    else
                    {
                        this._listRectArray[_loc_2].selected = false;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function removeTimeLoop(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < this._charStack.length)
            {
                
                _loc_3 = _loc_2 - this._p * 3;
                if (this._charStack[_loc_2].status == 5)
                {
                    _loc_4 = this._charStack[_loc_2].realDelTime - int(Config.now.getTime() / 1000);
                    if (_loc_4 > 0)
                    {
                        _loc_5 = Config.language("Login", 59, Style.FONT_4_Gold);
                        if (_loc_4 >= 24 * 60 * 60)
                        {
                            _loc_5 = _loc_5 + (int(_loc_4 / (24 * 60 * 60)) + Config.language("Login", 60) + this.toTime(int(_loc_4 % (24 * 60 * 60) / (60 * 60))) + Config.language("Login", 61));
                        }
                        else if (_loc_4 >= 60 * 60)
                        {
                            _loc_5 = _loc_5 + (int(_loc_4 / (60 * 60)) + Config.language("Login", 61) + this.toTime(int(_loc_4 % (60 * 60) / 60)) + Config.language("Login", 62));
                        }
                        else if (_loc_4 >= 60)
                        {
                            _loc_5 = _loc_5 + (int(_loc_4 / 60) + Config.language("Login", 62) + this.toTime(_loc_4 % 60) + Config.language("Login", 63));
                        }
                        else
                        {
                            _loc_5 = _loc_5 + (_loc_4 + Config.language("Login", 63));
                        }
                        _loc_5 = _loc_5 + "</font>";
                        if (this._listPanelArray[_loc_3] != null)
                        {
                            this._listLabelArray[_loc_3].text = this._charStack[_loc_2].name + "\n\nLV  " + this._charStack[_loc_2].level + "\n\n" + _loc_5;
                        }
                    }
                    else
                    {
                        this.removeChar(_loc_2);
                        this.selectChar(null);
                        this.setLogin();
                        return;
                    }
                    if (this._listFilter[_loc_2] == false)
                    {
                        this._listFilter[_loc_2] = true;
                        if (this._listPanelArray[_loc_3] != null)
                        {
                            this._listPanelArray[_loc_3].filters = _grayFilter;
                        }
                    }
                }
                else
                {
                    if (this._listPanelArray[_loc_3] != null)
                    {
                        this._listLabelArray[_loc_3].text = this._charStack[_loc_2].name + "\n\nLV  " + this._charStack[_loc_2].level;
                    }
                    if (this._listFilter[_loc_2] == true)
                    {
                        this._listFilter[_loc_2] = false;
                        if (this._listPanelArray[_loc_3] != null)
                        {
                            this._listPanelArray[_loc_3].filters = _ungrayFilter;
                        }
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        private function toTime(param1)
        {
            var _loc_2:* = String(param1);
            if (_loc_2.length == 1)
            {
                _loc_2 = "0" + _loc_2;
            }
            return _loc_2;
        }// end function

        public function reInit()
        {
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_LOGIN, this.handleLoginGame);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.SMSG_LOGIN_USER, this.handleLoginRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_LIST, this.handleRoleList);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_SELECT, this.handlePlayGameRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_CREATE, this.handleCreateRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_ROLE_DELETE, this.handleRemoveRcv);
            ClientSocket._socket.addEventListener("socket" + CONST_ENUM.L2C_QUEUE_UPDATE, this.handleQueueUpdate);
            this.switchPage("LOGIN");
            return;
        }// end function

        private function afterSwitch(param1 = null)
        {
            Config.stopLoop(this.afterSwitch);
            this.switchPage("LOGIN");
            return;
        }// end function

        public function destroy()
        {
            var _loc_1:* = undefined;
            Config.stopLoop(this.loadingBGLoop);
            Config.stopLoop(this.removeTimeLoop);
            Config.stopLoop(this.fadeOut);
            Config.stopLoop(this.fadeIn);
            Config.stopLoop(this.maskOn);
            Config.stopLoop(this.maskOff);
            Config.stopLoop(this.subGetCookie);
            Config.stopLoop(this.afterSwitch);
            ClientSocket._socket.removeEventListener("socket" + CONST_ENUM.SMSG_LOGIN, this.handleLoginGame);
            ClientSocket._socket.removeEventListener("socket" + CONST_ENUM.SMSG_LOGIN_USER, this.handleLoginRcv);
            ClientSocket._socket.removeEventListener("socket" + CONST_ENUM.L2C_ROLE_LIST, this.handleRoleList);
            ClientSocket._socket.removeEventListener("socket" + CONST_ENUM.L2C_ROLE_SELECT, this.handlePlayGameRcv);
            ClientSocket._socket.removeEventListener("socket" + CONST_ENUM.L2C_ROLE_CREATE, this.handleCreateRcv);
            ClientSocket._socket.removeEventListener("socket" + CONST_ENUM.L2C_ROLE_DELETE, this.handleRemoveRcv);
            ClientSocket._socket.removeEventListener("socket" + CONST_ENUM.L2C_QUEUE_UPDATE, this.handleQueueUpdate);
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                this._listRectArray[_loc_1].clip = null;
                this._createPanelArray[_loc_1].destroy();
                _loc_1 = _loc_1 + 1;
            }
            _loc_1 = 0;
            while (_loc_1 < 6)
            {
                
                this._createRectArray[_loc_1].clip = null;
                _loc_1 = _loc_1 + 1;
            }
            this._polygon.destroy();
            this._listBg.destroy();
            this._createBg.destroy();
            this._loadingPanel.destroy();
            this._loadingBG.graphics.clear();
            this.removeChild(this._loadingBG);
            if (this._charBmp != null && this._charBmp.bitmapData != null)
            {
                this._charBmp.bitmapData.dispose();
            }
            Config.clearDisplayList(this);
            Config.main.removeChild(this);
            Config.loginUI = null;
            Config.gc();
            return;
        }// end function

        private function handleBg(param1)
        {
            param1.target.scrollTo((param1.target._width - param1.target._exBorder) / 2 * 48, (param1.target._height - param1.target._exBorder) / 2 * 48);
            return;
        }// end function

        private function initDraw()
        {
            var dataset:DataSet;
            var temp:*;
            var temp1:*;
            var temp2:*;
            var temp3:*;
            var temp4:*;
            var temp5:*;
            var temp6:*;
            var temp7:*;
            var i:*;
            var j:*;
            var k:*;
            var tempPB:PushButton;
            var tempLB:Label;
            var tempCB:CheckBox;
            var tempRB:RadioButton;
            var tempMap:Map;
            var login_passTi:InputText;
            var subHandleLogin:*;
            var handleLogin:*;
            var tempTable:Table;
            var handlePlayGame:*;
            var handleRemove:*;
            var realRecover:*;
            var realRemove:*;
            var handleCreateSelect:*;
            var job:*;
            var xml:*;
            var handleBack:*;
            var handleCreate:*;
            var inputmaxChar:*;
            var doLogin:* = function ()
            {
                return;
            }// end function
            ;
            subHandleLogin = function (param1)
            {
                ClientSocket._socket.removeEventListener(Event.CONNECT, subHandleLogin);
                dataset = new DataSet();
                dataset.addHead(CONST_ENUM.CMSG_LOGIN_USER);
                dataset.addUTF("t1");
                dataset.addUTF("1");
                dataset.addUTF(login_nameTi.text);
                dataset.addUTF(login_passTi.text);
                dataset.add32(0);
                dataset.addUTF("");
                ClientSocket.send(dataset);
                return;
            }// end function
            ;
            handleLogin = function (param1 = null)
            {
                if (login_nameTi.text == "")
                {
                    AlertUI.alert(Config.language("Login", 5), Config.language("Login", 6), [Config.language("Login", 7)]);
                    return;
                }
                ClientSocket._socket.addEventListener(Event.CONNECT, subHandleLogin, false, 0, true);
                ClientSocket.connect(Config.loginIp, Config.loginPort);
                return;
            }// end function
            ;
            handlePlayGame = function (param1)
            {
                var _loc_2:* = _charStack[_selectedChar];
                if (_loc_2 != null && _loc_2.name.indexOf(":") == -1)
                {
                    enterGame();
                }
                else
                {
                    AlertUI.alert(Config.language("Login", 68), Config.language("Login", 69), [Config.language("Login", 70), Config.language("Login", 71)], [realRename], _loc_2, true);
                }
                return;
            }// end function
            ;
            handleRemove = function (event:MouseEvent)
            {
                if (_selectedChar != null && _listRectArray[_selectedChar - _p * 3] != null)
                {
                    AlertUI.remove(_removeAlertID);
                    if (_charStack[_selectedChar].status == 5)
                    {
                        _removeAlertID = AlertUI.alert(Config.language("Login", 64), Config.language("Login", 65, _listRectArray[_selectedChar - _p * 3].data.name), [Config.language("Login", 13), Config.language("Login", 14)], [realRecover], _listRectArray[_selectedChar - _p * 3].data);
                    }
                    else
                    {
                        _removeAlertID = AlertUI.alert(Config.language("Login", 10), Config.language("Login", 11, _listRectArray[_selectedChar - _p * 3].data.name), [Config.language("Login", 13), Config.language("Login", 14)], [realRemove], _listRectArray[_selectedChar - _p * 3].data);
                    }
                }
                return;
            }// end function
            ;
            realRecover = function (param1 = null)
            {
                var _loc_2:* = undefined;
                if (param1 != null)
                {
                    _preRemoveID = param1.id;
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2L_ROLE_DELETE);
                    _loc_2.add16(1);
                    _loc_2.add32(param1.id);
                    ClientSocket.send(_loc_2);
                }
                return;
            }// end function
            ;
            realRemove = function (param1 = null)
            {
                var _loc_2:* = undefined;
                if (param1 != null)
                {
                    _preRemoveID = param1.id;
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2L_ROLE_DELETE);
                    _loc_2.add16(0);
                    _loc_2.add32(param1.id);
                    ClientSocket.send(_loc_2);
                }
                return;
            }// end function
            ;
            handleCreateSelect = function (param1)
            {
                _createRectArray[selectedCharCreate].selected = false;
                selectedCharCreate = param1.currentTarget.data.index;
                _createRectArray[selectedCharCreate].selected = true;
                changePaint(selectedCharCreate);
                if (param1.currentTarget.data.job == 1)
                {
                    _polygon.data = [5, 4, 5, 1, 2];
                }
                else if (param1.currentTarget.data.job == 4)
                {
                    _polygon.data = [4, 3, 4, 2, 5];
                }
                else if (param1.currentTarget.data.job == 10)
                {
                    _polygon.data = [3, 2, 3, 5, 4];
                }
                return;
            }// end function
            ;
            handleBack = function (param1)
            {
                switchPage("LIST");
                return;
            }// end function
            ;
            handleCreate = function (event:MouseEvent)
            {
                var _loc_2:* = undefined;
                if (temp5.text == "")
                {
                    AlertUI.alert(Config.language("Login", 17), Config.language("Login", 18), [Config.language("Login", 7)]);
                }
                else
                {
                    _loc_2 = new DataSet();
                    _loc_2.addHead(CONST_ENUM.C2L_ROLE_CREATE);
                    _loc_2.addUTF(temp5.text);
                    _loc_2.add8(_createRectArray[selectedCharCreate].data.sex);
                    _loc_2.add8(_createRectArray[selectedCharCreate].data.job);
                    ClientSocket.send(_loc_2);
                }
                return;
            }// end function
            ;
            inputmaxChar = function (param1)
            {
                var _loc_2:* = 12;
                var _loc_3:* = 0;
                while (_loc_3 < temp5.text.length)
                {
                    
                    if (temp5.text.charCodeAt(_loc_3) > 255)
                    {
                        _loc_2 = _loc_2 - 1;
                    }
                    _loc_3++;
                }
                temp5.maxChars = _loc_2;
                return;
            }// end function
            ;
            this.focusRect = false;
            Music.play("stuff/music/bgm001.mp3");
            var shadow1:* = new DropShadowFilter(3, 45, 0, 0.5, 3, 3, 1, BitmapFilterQuality.HIGH);
            if (Config._lanVersion == LanVersion.QQ_ZH_CN)
            {
                this._listBg = new GPanel(Config.findUI("login").qqlogin);
            }
            else
            {
                this._listBg = new GPanel(Config.findUI("login").login);
            }
            this._listBgW = this._listBg.width;
            this._listBgH = this._listBg.height;
            addChild(this._listBg);
            this._loginPanel = new Panel(null, 0, 0);
            this._loginPanel.color = Style.WINDOW;
            this._loginPanel.border = 2;
            this._loginPanel.roundCorner = 8;
            this._loginPanel.shadow = 8;
            this._loginPanel.width = 200;
            this._loginPanel.height = 130;
            tempLB = new Label(this._loginPanel, 10, 10, Config.language("Login", 2));
            this.login_nameTi = new InputText(this._loginPanel, 80, 10);
            this.login_nameTi.maxChars = 16;
            this.login_nameTi._tf.tabIndex = 0;
            tempLB = new Label(this._loginPanel, 10, 40, Config.language("Login", 3));
            login_passTi = new InputText(this._loginPanel, 80, 40, "1");
            login_passTi.maxChars = 16;
            login_passTi.restrict = "A-Za-z0-9";
            login_passTi._tf.tabIndex = 1;
            if (Main._loginMode == 0)
            {
                this.login_nameTi.text = Config.loginName;
                login_passTi.text = Config.loginPass;
            }
            else
            {
                this.login_nameTi.text = Config.loginName;
            }
            tempCB = new CheckBox(this._loginPanel, 80, 70, Config.language("Login", 4));
            tempPB = new PushButton(this._loginPanel, 75, 100, Config.language("Login", 8), handleLogin);
            tempPB.width = 50;
            this._listPanel = new Sprite();
            this._pButtonLayer = new Sprite();
            this._pButtonLayer.filters = [shadow1];
            tempPB = new PushButton(this._pButtonLayer, -450 - 36, -100, "", this.pageLeft, Config.findUI("login").left);
            tempPB = new PushButton(this._pButtonLayer, 450, -100, "", this.pageRight, Config.findUI("login").right);
            this._listPanel.addChild(this._pButtonLayer);
            i;
            while (i < 6)
            {
                
                this._listPanelArray[i] = new Table("table15");
                this._listPanelArray[i].resize(278, 117);
                this._listPanelArray[i].x = i * 300;
                this._listPanelArray[i].filters = _ungrayFilter;
                this._listPanelArray[i].addEventListener(MouseEvent.CLICK, Config.create(this.handleListPanelInfoClick, i));
                this._listPanelArray[i].buttonMode = true;
                this._listRectArray[i] = new ClipSlot(this._listPanelArray[i], 24, 16);
                this._listRectArray[i].addEventListener("sglClick", Config.create(this.handleListPanelInfoClick, i));
                this._listRectArray[i].addEventListener("dblClick", Config.create(this.handleListPanelInfoDblClick, i));
                this._listLabelArray[i] = new Label(this._listPanelArray[i], 120, 20);
                this._listLabelArray[i].textColor = 16768174;
                this._listLabelArray[i].html = true;
                this._listLabelArray[i].mouseEnabled = false;
                i = (i + 1);
            }
            this._beginBtn = new PushButton(this._listPanel, -50 - 12, 0, Config.language("Login", 9), handlePlayGame);
            this._beginBtn.setTable("table13", "table14");
            this._beginBtn.width = 124;
            this._beginBtn.enabled = false;
            this._sprceate = new Sprite();
            this._listPanel.addChild(this._sprceate);
            this._createpbtn = new PushButton(this._sprceate, -160, 0, Config.language("Login", 86), Config.create(this.handleListPanelInfoClick, 5));
            this._sprceate.addEventListener(MouseEvent.ROLL_OVER, this.handlebtnOver);
            this._sprceate.addEventListener(MouseEvent.ROLL_OUT, this.handlebtnOut);
            this._createpbtn.width = 80;
            this._removePB = new PushButton(null, 80, 0, Config.language("Login", 15), handleRemove);
            this._removePB.width = 80;
            this._soundbtn = new CheckBox(this._listPanel, 180, 5, Config.language("Login", 16), this.soundfuc);
            this._soundbtn.selected = SoundManager.musicOn;
            this.getSoundCookie();
            this._createPanel = new Sprite();
            i;
            while (i < 3)
            {
                
                this._createPanelArray[i] = new GPanel(Config.findUI("login")["create" + (i + 1)]);
                this._createPanelArray[i].mouseChildren = true;
                this._createPanelArray[i].y = i * 120 + 0;
                this._createPanelArray[i].filters = _ungrayFilter;
                job = i;
                if (job > 1)
                {
                    job = (job + 1);
                }
                xml = Config._charactorMap[1 + job * 3];
                this._createRectArray[i * 2] = new ClipSlot(this._createPanelArray[i], 24, 16);
                this._createRectArray[i * 2].clip = Config._model[Number(xml.model)];
                this._createRectArray[i * 2].clip.multiLayer = true;
                this._createRectArray[i * 2].clip.layerStack = xml.id;
                this._createRectArray[i * 2].clip.hair = Config._model[Number(xml.hair.style0)];
                this._createRectArray[i * 2].clip.cloth = Config._model[Number(xml.cloth)];
                this._createRectArray[i * 2].data = {index:i * 2, sex:1, job:job * 3 + 1};
                this._createRectArray[i * 2].addEventListener(MouseEvent.CLICK, handleCreateSelect);
                xml = Config._charactorMap[13 + job * 3];
                this._createRectArray[i * 2 + 1] = new ClipSlot(this._createPanelArray[i], 114, 16);
                this._createRectArray[i * 2 + 1].clip = Config._model[Number(xml.model)];
                this._createRectArray[i * 2 + 1].clip.multiLayer = true;
                this._createRectArray[i * 2 + 1].clip.layerStack = xml.id;
                this._createRectArray[i * 2 + 1].clip.hair = Config._model[Number(xml.hair.style0)];
                this._createRectArray[i * 2 + 1].clip.cloth = Config._model[Number(xml.cloth)];
                this._createRectArray[i * 2 + 1].data = {index:i * 2 + 1, sex:2, job:job * 3 + 1};
                this._createRectArray[i * 2 + 1].addEventListener(MouseEvent.CLICK, handleCreateSelect);
                i = (i + 1);
            }
            this._createRectArray[this.selectedCharCreate].selected = true;
            this._polygon = new Polygon(10, (-Math.PI) / 2, [5, 4, 5, 1, 2]);
            this._polygon.x = 0;
            this._polygon.y = -100;
            addChild(this._polygon);
            tempLB = new Label(this._createPanel, -150, 2, Config.language("Login", 19));
            tempLB.textColor = 16777215;
            tempLB.filters = [shadow1];
            var juesemingcheng:* = tempLB;
            tempLB = new Label(this._createPanel, -90, 27, Config.language("Login", 20));
            tempLB.textColor = 16777215;
            tempLB.filters = [shadow1];
            if (Config._switchRandName)
            {
                tempLB = new Label(this._createPanel, -90, -23, Config.language("Login", 84));
                tempLB.textColor = 16777215;
                tempLB.filters = [shadow1];
                tempPB = new PushButton(this._createPanel, 100, 2, Config.language("Login", 85), this.ranName, null, "table18", "table31");
                tempPB.textColor = Style.GOLD_FONT;
                tempPB.overshow = true;
                tempPB.width = 60;
            }
            if (Config._switchNameLength)
            {
                temp5 = new InputText(this._createPanel, -90, 0, "");
            }
            else
            {
                temp5 = new InputText(this._createPanel, -90, 0, "", inputmaxChar);
            }
            temp5.setTable("table20");
            if (Config._switchEnglish)
            {
                temp5.restrict = "^<>\\^一-龥";
            }
            else
            {
                temp5.restrict = "^<>\\^";
            }
            temp5.width = 180;
            temp5.height = 25;
            if (Config._switchNameLength)
            {
                temp5.maxChars = 12;
            }
            else
            {
                temp5.maxChars = 6;
            }
            this._nameIT = temp5;
            juesemingcheng.x = this._nameIT.x - juesemingcheng.width - 5;
            tempPB = new PushButton(this._createPanel, -50 - 12, 50, Config.language("Login", 9), handleCreate);
            tempPB.setTable("table13", "table14");
            tempPB.width = 124;
            tempPB = new PushButton(this._createPanel, 100, 50, Config.language("Login", 21), handleBack);
            tempPB.width = 64;
            this._createBg = new GPanel(Config.findUI("login").bg);
            this._charSprite = new Sprite();
            this._charSprite.mouseChildren = false;
            this._charSprite.mouseEnabled = false;
            this._charBmp = new Bitmap();
            this._charSprite.addChild(this._charBmp);
            this._charBmp.filters = [this._charCMF];
            this._mask = new Sprite();
            this.resize();
            if (Main._loginMode == 0)
            {
                this._loginPanel.visible = false;
                this.handleLogin();
            }
            return;
        }// end function

        private function ranName(param1 = null)
        {
            var _loc_2:* = null;
            var _loc_4:* = undefined;
            if (!this._ranNameInited)
            {
                this._ranNameStacks[0] = [];
                this._ranNameStacks[1] = [];
                this._ranNameStacks[2] = [];
                this._ranNameStacks[3] = [];
                for (_loc_4 in Config._nameMap)
                {
                    
                    this._ranNameStacks[int((_loc_4 - 10000) / 10000)].push(String(Config._nameMap[_loc_4].name));
                }
                this._ranNameInited = true;
            }
            if (this._createRectArray[this.selectedCharCreate].data.sex == 1)
            {
                _loc_2 = this._ranNameStacks[1].concat(this._ranNameStacks[2]);
            }
            else
            {
                _loc_2 = this._ranNameStacks[1].concat(this._ranNameStacks[3]);
            }
            var _loc_3:* = _loc_2[int(Math.random() * _loc_2.length)] + "." + this._ranNameStacks[0][int(Math.random() * this._ranNameStacks[0].length)];
            if (_loc_3.length > 6)
            {
                _loc_3 = _loc_3.substring(0, 6);
            }
            this._nameIT.text = _loc_3;
            return;
        }// end function

        private function pageLeft(param1)
        {
            if (this._p > 0)
            {
                var _loc_2:* = this;
                var _loc_3:* = this._p - 1;
                _loc_2._p = _loc_3;
                this.setLogin();
            }
            return;
        }// end function

        private function pageRight(param1)
        {
            if (this._p < (this._mp - 1))
            {
                var _loc_2:* = this;
                var _loc_3:* = this._p + 1;
                _loc_2._p = _loc_3;
                this.setLogin();
            }
            return;
        }// end function

        private function realRename(param1, param2:String)
        {
            var _loc_3:* = undefined;
            if (param1 != null)
            {
                this._preRemoveID = param1.id;
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2L_ROLE_DELETE);
                _loc_3.add16(10);
                _loc_3.add32(param1.id);
                _loc_3.addUTF(param2);
                ClientSocket.send(_loc_3);
            }
            return;
        }// end function

        private function changePaint(param1, param2 = false)
        {
            var _loc_3:* = undefined;
            if (this._charId == param1 && !param2)
            {
                return;
            }
            this._charId = param1;
            this._charBmpd = BitmapLoader.pick("stuff/pic/paint/" + this._charId + ".png");
            if (this._charBmpd == null)
            {
                this._charFlag = false;
                if (this._charLoader != null)
                {
                    this._charLoader.removeEventListener(Event.COMPLETE, this.handleLoadComplete);
                    this._charLoader = null;
                }
                this._charLoader = BitmapLoader.newBitmapLoader();
                this._charLoader.removeEventListener(Event.COMPLETE, this.handleLoadComplete);
                this._charLoader.addEventListener(Event.COMPLETE, this.handleLoadComplete);
                this._charLoader.load(["stuff/pic/paint/" + this._charId + ".png"]);
            }
            else
            {
                this._charFlag = true;
            }
            if (param2)
            {
                _loc_3 = this._charCMF.matrix;
                var _loc_4:* = 200;
                _loc_3[14] = 200;
                _loc_3[9] = _loc_4;
                _loc_3[4] = _loc_4;
                this._charCMF.matrix = _loc_3;
                this._charBmp.filters = [this._charCMF];
                this._charBmp.x = 25;
                this._charBmp.alpha = 0;
                if (this._charFlag)
                {
                    if (this._charBmp.bitmapData != null)
                    {
                        this._charBmp.bitmapData.dispose();
                    }
                    this._charBmp.bitmapData = this._charBmpd;
                    if (this._charId == 5)
                    {
                        this._charBmp.y = -50;
                    }
                    else
                    {
                        this._charBmp.y = 0;
                    }
                    this.fadeIn();
                    Config.stopLoop(this.fadeOut);
                    Config.startLoop(this.fadeIn);
                }
                else
                {
                    this._charFlag = true;
                }
            }
            else
            {
                this.fadeOut();
                Config.stopLoop(this.fadeIn);
                Config.startLoop(this.fadeOut);
            }
            return;
        }// end function

        private function fadeOut(param1 = null)
        {
            var _loc_2:* = this._charCMF.matrix;
            var _loc_3:* = _loc_2[4];
            var _loc_4:* = _loc_3 + 40;
            _loc_2[14] = _loc_3 + 40;
            _loc_2[9] = _loc_4;
            _loc_2[4] = _loc_4;
            this._charCMF.matrix = _loc_2;
            this._charBmp.filters = [this._charCMF];
            this._charBmp.x = Math.pow(_loc_2[4] / 40, 2);
            if (_loc_2[4] >= 100)
            {
                this._charBmp.alpha = (200 - _loc_2[4]) / 100;
            }
            if (_loc_2[4] >= 200)
            {
                this._charBmp.alpha = 0;
                Config.stopLoop(this.fadeOut);
                if (this._charFlag)
                {
                    if (this._charBmp.bitmapData != null)
                    {
                        this._charBmp.bitmapData.dispose();
                    }
                    this._charBmp.bitmapData = this._charBmpd;
                    if (this._charId == 5)
                    {
                        this._charBmp.y = -50;
                    }
                    else
                    {
                        this._charBmp.y = 0;
                    }
                    this.fadeIn();
                    Config.startLoop(this.fadeIn);
                }
                else
                {
                    this._charFlag = true;
                }
            }
            return;
        }// end function

        private function fadeIn(param1 = null)
        {
            var _loc_2:* = this._charCMF.matrix;
            var _loc_3:* = _loc_2[4];
            var _loc_4:* = _loc_3 - 40;
            _loc_2[14] = _loc_3 - 40;
            _loc_2[9] = _loc_4;
            _loc_2[4] = _loc_4;
            this._charCMF.matrix = _loc_2;
            this._charBmp.filters = [this._charCMF];
            this._charBmp.x = Math.pow(_loc_2[4] / 40, 2);
            if (_loc_2[4] >= 100)
            {
                this._charBmp.alpha = (200 - _loc_2[4]) / 100;
            }
            if (_loc_2[4] <= 0)
            {
                this._charBmp.alpha = 1;
                Config.stopLoop(this.fadeOut);
                Config.stopLoop(this.fadeIn);
            }
            return;
        }// end function

        private function handleLoadComplete(param1)
        {
            param1.target.removeEventListener(Event.COMPLETE, this.handleLoadComplete);
            this._charBmpd = BitmapLoader.pick("stuff/pic/paint/" + this._charId + ".png");
            if (this._charFlag)
            {
                if (this._charBmp.bitmapData != null)
                {
                    this._charBmp.bitmapData.dispose();
                }
                this._charBmp.bitmapData = this._charBmpd;
                if (this._charId == 5)
                {
                    this._charBmp.y = -50;
                }
                else
                {
                    this._charBmp.y = 0;
                }
                this.fadeIn();
                Config.stopLoop(this.fadeOut);
                Config.startLoop(this.fadeIn);
            }
            else
            {
                this._charFlag = true;
            }
            return;
        }// end function

        public function resize()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            this._width = Config.stage.stageWidth;
            this._height = Config.stage.stageHeight;
            if (this._page == "LOGIN")
            {
                this._loginPanel.x = (this._width - this._loginPanel.width) / 2;
                this._loginPanel.y = (this._height - this._loginPanel.height) / 4 * 3;
                _loc_3 = this._listBgW / this._listBgH;
                if (this._width / this._height < _loc_3)
                {
                    this._listBg.height = this._height;
                    this._listBg.width = _loc_3 * this._listBg.height;
                    this._listBg.x = (-(this._listBg.width - this._width)) / 2;
                    this._listBg.y = 0;
                }
                else
                {
                    this._listBg.width = this._width;
                    this._listBg.height = this._listBg.width / _loc_3;
                    this._listBg.x = 0;
                    this._listBg.y = (-(this._listBg.height - this._height)) / 2;
                }
            }
            else if (this._page == "LIST")
            {
                _loc_2 = Math.floor((this._width - this._listPanelArray[0].width * 3 - 16 * 2) / 2);
                _loc_1 = 0;
                while (_loc_1 < 3)
                {
                    
                    this._listPanelArray[_loc_1].x = (16 + this._listPanelArray[0].width) * _loc_1 + _loc_2;
                    this._listPanelArray[_loc_1].y = this._height * 0.55;
                    _loc_1 = _loc_1 + 1;
                }
                this._pButtonLayer.x = 0;
                this._pButtonLayer.y = -22;
                this._listPanel.x = this._width / 2;
                this._listPanel.y = this._height * 0.55 + 150;
                _loc_3 = this._listBgW / this._listBgH;
                if (this._width / this._height < _loc_3)
                {
                    this._listBg.height = this._height;
                    this._listBg.width = _loc_3 * this._listBg.height;
                    this._listBg.x = (-(this._listBg.width - this._width)) / 2;
                    this._listBg.y = 0;
                }
                else
                {
                    this._listBg.width = this._width;
                    this._listBg.height = this._listBg.width / _loc_3;
                    this._listBg.x = 0;
                    this._listBg.y = (-(this._listBg.height - this._height)) / 2;
                }
            }
            else if (this._page == "CREATE")
            {
                _loc_1 = 0;
                while (_loc_1 < 3)
                {
                    
                    this._createPanelArray[_loc_1].x = Math.max(32, this._width / 2 - 500 + 32);
                    this._createPanelArray[_loc_1].y = Math.max((16 + 117) * _loc_1 + 32, this._height / 2 - 300 + (16 + 117) * _loc_1 + 32);
                    _loc_1 = _loc_1 + 1;
                }
                this._charSprite.x = Math.min(this._width / 2 + 100, this._width - 450);
                this._charSprite.y = Math.max(10, this._height / 2 - 400);
                this._polygon.x = this._width / 2;
                this._polygon.y = this._height * 0.45;
                this._createPanel.x = this._width / 2;
                this._createPanel.y = this._height * 0.55 + 100;
                this._createBg.width = this._width;
                this._createBg.height = this._height;
            }
            else
            {
                _loc_3 = this._listBgW / this._listBgH;
                if (this._width / this._height < _loc_3)
                {
                    this._listBg.height = this._height;
                    this._listBg.width = _loc_3 * this._listBg.height;
                    this._listBg.x = (-(this._listBg.width - this._width)) / 2;
                    this._listBg.y = 0;
                }
                else
                {
                    this._listBg.width = this._width;
                    this._listBg.height = this._listBg.width / _loc_3;
                    this._listBg.x = 0;
                    this._listBg.y = (-(this._listBg.height - this._height)) / 2;
                }
                if (this._loadingBG != null)
                {
                    this._loadingBG.graphics.clear();
                    this._loadingBG.graphics.beginFill(0, 1);
                    this._loadingBG.graphics.drawRect(0, 0, this._width, this._height);
                    this._loadingBG.graphics.endFill();
                }
                if (this._queueBG != null)
                {
                    this._queueBG.graphics.clear();
                    this._queueBG.graphics.beginFill(0, 1);
                    this._queueBG.graphics.drawRect(0, 0, this._width, this._height);
                    this._queueBG.graphics.endFill();
                }
            }
            if (this._mask != null)
            {
                this._mask.graphics.clear();
                this._mask.graphics.beginFill(0, 1);
                this._mask.graphics.drawRect(0, 0, this._width, this._height);
                this._mask.graphics.endFill();
            }
            return;
        }// end function

        public function switchPage(param1, param2 = false)
        {
            if (this._page == param1)
            {
                return;
            }
            this._page = param1;
            if (param2)
            {
                this.subSwitchPage();
                removeChild(this._mask);
            }
            else
            {
                this._mask.alpha = 0;
                addChild(this._mask);
                this.maskOn();
                Config.startLoop(this.maskOn);
            }
            return;
        }// end function

        private function maskOn(param1 = null)
        {
            this._mask.alpha = this._mask.alpha + 0.2;
            if (this._mask.alpha >= 1)
            {
                this._mask.alpha = 1;
                this.subSwitchPage();
                Config.stopLoop(this.maskOn);
                this.maskOff();
                Config.startLoop(this.maskOff);
            }
            return;
        }// end function

        private function maskOff(param1 = null)
        {
            this._mask.alpha = this._mask.alpha - 0.2;
            if (this._mask.alpha <= 0)
            {
                this._mask.alpha = 0;
                removeChild(this._mask);
                Config.stopLoop(this.maskOff);
            }
            return;
        }// end function

        private function subSwitchPage()
        {
            var _loc_1:* = undefined;
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                if (this._createPanelArray[_loc_1].parent != null)
                {
                    removeChild(this._createPanelArray[_loc_1]);
                }
                _loc_1 = _loc_1 + 1;
            }
            if (this._createBg.parent != null)
            {
                removeChild(this._createBg);
            }
            if (this._createPanel.parent != null)
            {
                removeChild(this._createPanel);
            }
            if (this._polygon.parent != null)
            {
                removeChild(this._polygon);
            }
            if (this._charSprite.parent != null)
            {
                removeChild(this._charSprite);
            }
            _loc_1 = 0;
            while (_loc_1 < 3)
            {
                
                if (this._listPanelArray[_loc_1].parent != null)
                {
                    removeChild(this._listPanelArray[_loc_1]);
                }
                _loc_1 = _loc_1 + 1;
            }
            if (this._listPanel.parent != null)
            {
                removeChild(this._listPanel);
            }
            if (this._listBg.parent != null)
            {
                removeChild(this._listBg);
            }
            if (this._loginPanel.parent != null)
            {
                removeChild(this._loginPanel);
            }
            if (this._page != "LOGIN")
            {
                if (this._firstSwitch)
                {
                    this._firstSwitch = false;
                }
            }
            if (this._page == "LOGIN")
            {
                addChild(this._listBg);
                addChild(this._loginPanel);
            }
            else if (this._page == "LIST")
            {
                addChild(this._listBg);
                addChild(this._listPanel);
                _loc_1 = 0;
                while (_loc_1 < 3)
                {
                    
                    addChild(this._listPanelArray[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
                addChild(this._listPanel);
            }
            else if (this._page == "CREATE")
            {
                if (Config._switchRandName && !this._ranNameInited)
                {
                    if (Config._switchEnglish != true)
                    {
                        this.ranName();
                    }
                }
                addChild(this._createBg);
                _loc_1 = 0;
                while (_loc_1 < 3)
                {
                    
                    addChild(this._createPanelArray[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
                addChild(this._charSprite);
                addChild(this._polygon);
                addChild(this._createPanel);
                this.changePaint(this._charId, true);
            }
            else if (this._page == "INIT")
            {
                addChild(this._listBg);
            }
            addChild(this._mask);
            this.resize();
            return;
        }// end function

        private function enterGame()
        {
            if (this._charStack[this._selectedChar] != null)
            {
                this.autoLoginCancel();
                Music.stop();
                SoundManager.play("stuff/sound/ui/entergame.mp3");
                Player._playerId = this._charStack[this._selectedChar].id;
                Player.name = this._charStack[this._selectedChar].name;
                Player.sex = this._charStack[this._selectedChar].sex;
                Player.job = this._charStack[this._selectedChar].job;
                Player.level = this._charStack[this._selectedChar].level;
                this.subEnterGame();
                this.initStep0();
                this.lock();
            }
            return;
        }// end function

        public function initStepProgress(param1)
        {
            this._loadingPer = param1;
            if (this._loading != null)
            {
                this._loading.text = Config.language("Login", 72) + " " + Math.max(0, Math.min(100, int(param1 * 2 * 100))) + "%";
            }
            return;
        }// end function

        public function initStep1()
        {
            this._loading.filters = this._filters3;
            var _loc_1:* = this.getGou();
            _loc_1.x = this._loading.x - 16;
            _loc_1.y = this._loading.y + 4;
            this._initializing.filters = this._filters1;
            this._jian.y = this._initializing.y + 3;
            this._loading.text = Config.language("Login", 72);
            return;
        }// end function

        private function loadingBGLoop(param1)
        {
            this._loadingBG.alpha = Math.min(this._loadingBG.alpha + 0.2, 0.81);
            this._loadingPanel.resize(150, int(this._loadingBG.alpha / 0.8 * 80));
            this._loadingPanelContentMask.graphics.clear();
            this._loadingPanelContentMask.graphics.beginFill(0, 1);
            this._loadingPanelContentMask.graphics.drawRect(4, 4, this._loadingPanel.width - 8, this._loadingPanel.height - 8);
            this._loadingPanelContentMask.graphics.endFill();
            this._loadingPanel.y = (this._height - this._loadingPanel.height) / 2;
            if (this._loadingBG.alpha >= 0.8)
            {
                this._loadingBG.alpha = 0.8;
                Config.stopLoop(this.loadingBGLoop);
                Main._main.realEnterGame();
            }
            return;
        }// end function

        private function getGou() : Shape
        {
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(0, 0, 0);
            _loc_1.graphics.beginFill(13369344, 1);
            _loc_1.graphics.moveTo(-2, 4);
            _loc_1.graphics.lineTo(3, 11);
            _loc_1.graphics.lineTo(13, -1);
            _loc_1.graphics.lineTo(3, 6);
            _loc_1.graphics.lineTo(-2, 4);
            _loc_1.graphics.endFill();
            _loc_1.filters = [new GlowFilter(13369344, 1, 4, 4, 2, 3, true, true)];
            this._loadingPanelContent.addChild(_loc_1);
            return _loc_1;
        }// end function

        private function getJian() : Shape
        {
            var _loc_1:* = new Shape();
            _loc_1.graphics.lineStyle(0, 0, 0);
            _loc_1.graphics.beginFill(Style.WINDOW_FONT, 1);
            _loc_1.graphics.moveTo(8, 0);
            _loc_1.graphics.lineTo(14, 6);
            _loc_1.graphics.lineTo(8, 12);
            _loc_1.graphics.lineTo(10, 7);
            _loc_1.graphics.lineTo(0, 7);
            _loc_1.graphics.lineTo(0, 5);
            _loc_1.graphics.lineTo(10, 5);
            _loc_1.graphics.lineTo(8, 0);
            _loc_1.graphics.endFill();
            _loc_1.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 2, 3, true, true)];
            this._loadingPanelContent.addChild(_loc_1);
            return _loc_1;
        }// end function

        private function getSimpleTxt() : TextField
        {
            var _loc_1:* = Config.getSimpleTextField();
            _loc_1.textColor = Style.WINDOW_FONT;
            return _loc_1;
        }// end function

        private function initStep0()
        {
            this.switchPage("INIT", true);
            this._loadingBG = new Shape();
            this._loadingBG.graphics.clear();
            this._loadingBG.graphics.beginFill(0, 1);
            this._loadingBG.graphics.drawRect(0, 0, this._width, this._height);
            this._loadingBG.graphics.endFill();
            this._loadingBG.alpha = 0;
            addChild(this._loadingBG);
            Config.startLoop(this.loadingBGLoop);
            this._loadingPanel = new Table("table8");
            this._loadingPanel.resize(150, 0);
            this._loadingPanel.x = (this._width - this._loadingPanel.width) / 2;
            this._loadingPanel.y = (this._height - this._loadingPanel.height) / 2;
            this._loadingPanel.filters = [new DropShadowFilter(6, 45, 0, 0.5, 6, 6, 1, BitmapFilterQuality.HIGH)];
            addChild(this._loadingPanel);
            this._loadingPanelContent = new Sprite();
            this._loadingPanel.addChild(this._loadingPanelContent);
            this._loadingPanelContentMask = new Shape();
            this._loadingPanel.addChild(this._loadingPanelContentMask);
            this._loadingPanelContent.mask = this._loadingPanelContentMask;
            this._jian = this.getJian();
            this._jian.x = 17;
            this._loading = this.getSimpleTxt();
            this._loading.x = 35;
            this._loading.y = 10;
            if (Main._data1Complete)
            {
                this._loading.text = Config.language("Login", 72);
                this._loading.filters = this._filters3;
            }
            else
            {
                this._loading.text = Config.language("Login", 72) + " " + Math.max(0, Math.min(100, int(this._loadingPer * 2 * 100))) + "%";
                this._loading.filters = this._filters1;
                this._jian.y = this._loading.y + 3;
            }
            this._loadingPanelContent.addChild(this._loading);
            this._initializing = this.getSimpleTxt();
            this._initializing.x = 35;
            this._initializing.y = 30;
            this._initializing.text = Config.language("Login", 73);
            if (Main._data1Complete)
            {
                this._initializing.filters = this._filters1;
                this._jian.y = this._initializing.y + 3;
            }
            else
            {
                this._initializing.filters = this._filters2;
            }
            this._loadingPanelContent.addChild(this._initializing);
            this._connect = this.getSimpleTxt();
            this._connect.x = 35;
            this._connect.y = 50;
            this._connect.text = Config.language("Login", 74);
            this._connect.filters = this._filters2;
            this._loadingPanelContent.addChild(this._connect);
            return;
        }// end function

        public function initStep2()
        {
            this._initializing.filters = this._filters3;
            var _loc_1:* = this.getGou();
            _loc_1.x = this._initializing.x - 16;
            _loc_1.y = this._initializing.y + 4;
            this._connect.filters = this._filters1;
            this._jian.y = this._connect.y + 3;
            return;
        }// end function

        private function lock()
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        private function unlock()
        {
            this.mouseChildren = true;
            this.mouseEnabled = true;
            return;
        }// end function

        public function subEnterGame()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2L_ROLE_SELECT);
            _loc_1.add32(Player._playerId);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function handlePlayGameRcv(event:SocketEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = event.data;
            _loc_2 = event.data.readUnsignedShort();
            if (_loc_2 != 0)
            {
                if (_loc_2 == 1)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 23), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 2)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 25), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 3)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 26), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1001)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 27), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1002)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 28), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1003)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 29), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1004)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 30), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1005)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 31), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1006)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 32), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1007)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 33), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1008)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 34), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1009)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 35), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1011)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 36), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1012)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 37), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_2 == 1010)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 38), [Config.language("Login", 39), Config.language("Login", 24)], [this.goActive], null, false, true, true);
                }
                else if (_loc_2 == 1050)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 40), [Config.language("Login", 24)]);
                }
                else if (_loc_2 == 1051)
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 41), [Config.language("Login", 24)]);
                }
                else
                {
                    AlertUI.alert(Config.language("Login", 22), Config.language("Login", 42, _loc_2), [Config.language("Login", 24)]);
                }
                this.unlock();
                return;
            }
            _loc_3 = _loc_4.readUnsignedShort();
            var _loc_5:* = _loc_4.readUTFBytes(_loc_3);
            var _loc_6:* = _loc_4.readUnsignedShort();
            _loc_3 = _loc_4.readUnsignedShort();
            var _loc_7:* = _loc_4.readUTFBytes(_loc_3);
            this._loginSessionKey = _loc_7;
            ClientSocket._socket.close();
            ClientSocket._socket.addEventListener(Event.CONNECT, this.handleGameConnect);
            ClientSocket.connect(_loc_5, _loc_6);
            return;
        }// end function

        private function handleGameConnect(param1)
        {
            ClientSocket._socket.removeEventListener(Event.CONNECT, this.handleGameConnect);
            Main._main.reconnectComplete();
            return;
        }// end function

        public function loginGamerServer()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.CMSG_LOGIN);
            _loc_1.addUTF("t1");
            _loc_1.add32(this._loginAccountId);
            _loc_1.addUTF(this._loginSessionKey);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        private function handleLoginGame(param1)
        {
            var _loc_2:* = param1.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            if (_loc_3 != 0)
            {
                AlertUI.alert(Config.language("Login", 43), Config.language("Login", 42, _loc_3), [Config.language("Login", 7)]);
                return;
            }
            Config.serverTime = _loc_2.readUnsignedInt();
            Player._playerId = this._charStack[this._selectedChar].id;
            Player.name = this._charStack[this._selectedChar].name;
            Player.sex = this._charStack[this._selectedChar].sex;
            Player.job = this._charStack[this._selectedChar].job;
            Player.level = this._charStack[this._selectedChar].level;
            Config.main.handleEnterGame();
            Loading.buffAllPic();
            this.destroy();
            return;
        }// end function

        private function handleRemoveRcv(event:SocketEvent)
        {
            var _loc_5:* = 0;
            var _loc_7:* = undefined;
            this._listRectArray[this._selectedChar - this._p * 3].selected = false;
            this._beginBtn.highlight = false;
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedShort();
            var _loc_4:* = _loc_2.readUnsignedShort();
            var _loc_6:* = 0;
            while (_loc_6 < this._charStack.length)
            {
                
                if (this._charStack[_loc_6].id == this._preRemoveID)
                {
                    _loc_5 = _loc_6;
                    break;
                }
                _loc_6 = _loc_6 + 1;
            }
            if (_loc_3 == 0 || _loc_3 == 1)
            {
                if (_loc_4 != 0)
                {
                    if (_loc_4 == 1)
                    {
                        AlertUI.alert(Config.language("Login", 44), Config.language("Login", 45), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 2)
                    {
                        AlertUI.alert(Config.language("Login", 44), Config.language("Login", 46), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 3)
                    {
                        AlertUI.alert(Config.language("Login", 44), Config.language("Login", 47), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 4)
                    {
                        AlertUI.alert(Config.language("Login", 44), Config.language("Login", 66), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 5)
                    {
                        AlertUI.alert(Config.language("Login", 44), Config.language("Login", 67), [Config.language("Login", 7)]);
                    }
                    else
                    {
                        AlertUI.alert(Config.language("Login", 44), Config.language("Login", 42, _loc_4), [Config.language("Login", 7)]);
                    }
                    return;
                }
                if (this._charStack[_loc_5] != null)
                {
                    if (_loc_3 == 0)
                    {
                        this._charStack[_loc_5].status = 5;
                        this._charStack[_loc_5].realDelTime = int(Config.now.getTime() / 1000) + this._removeTimeTotal;
                    }
                    else
                    {
                        this._charStack[_loc_5].status = 1;
                        this._charStack[_loc_5].realDelTime = 0;
                    }
                }
            }
            else
            {
                if (_loc_4 != 0)
                {
                    if (_loc_4 == 1)
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 76), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 2)
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 77), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 3)
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 78), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 4)
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 79), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 5)
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 80), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 6)
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 81), [Config.language("Login", 7)]);
                    }
                    else if (_loc_4 == 7)
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 82), [Config.language("Login", 7)]);
                    }
                    else
                    {
                        AlertUI.alert(Config.language("Login", 75), Config.language("Login", 83) + _loc_4, [Config.language("Login", 7)]);
                    }
                    return;
                }
                _loc_7 = _loc_2.readUnsignedShort();
                if (this._charStack[_loc_5] != null)
                {
                    this._charStack[_loc_5].name = _loc_2.readUTFBytes(_loc_7);
                }
            }
            this.setLogin();
            return;
        }// end function

        private function handleCreateRcv(event:SocketEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_13:* = null;
            var _loc_12:* = event.data;
            _loc_4 = event.data.readUnsignedShort();
            if (_loc_4 != 0)
            {
                switch(_loc_4)
                {
                    case 1:
                    {
                        _loc_13 = Config.language("Login", 48);
                        break;
                    }
                    case 2:
                    {
                        _loc_13 = Config.language("Login", 49);
                        break;
                    }
                    case 3:
                    {
                        _loc_13 = Config.language("Login", 46);
                        break;
                    }
                    case 4:
                    {
                        _loc_13 = Config.language("Login", 50);
                        break;
                    }
                    case 5:
                    {
                        _loc_13 = Config.language("Login", 51);
                        break;
                    }
                    case 6:
                    {
                        _loc_13 = Config.language("Login", 52);
                        break;
                    }
                    default:
                    {
                        _loc_13 = Config.language("Login", 42, _loc_4);
                        break;
                        break;
                    }
                }
                AlertUI.alert(Config.language("Login", 53), _loc_13, [Config.language("Login", 7)]);
                return;
            }
            this._charStack.push(this.getRoleInfo(_loc_12));
            this._charStack.sortOn("level", Array.NUMERIC | Array.DESCENDING);
            this.setLogin();
            this._selectedChar = this._charStack.length - 1;
            Config._firstInGame = true;
            Config._firstInGameSession = true;
            this.enterGame();
            return;
        }// end function

        private function handleLogoutRcv(event:SocketEvent)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = event.data;
            _loc_2 = _loc_3.readByte();
            if (_loc_2 != 0)
            {
                AlertUI.alert(Config.language("Login", 54), Config.language("Login", 42, _loc_2), [Config.language("Login", 7)]);
                return;
            }
            this.switchPage("LOGIN");
            return;
        }// end function

        private function handleLoginRcv(event:SocketEvent)
        {
            var _loc_2:* = undefined;
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
            var _loc_13:* = event.data;
            _loc_4 = event.data.readUnsignedShort();
            if (_loc_4 != 0)
            {
                if (_loc_4 == 1)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 23), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 2)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 25), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 3)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 26), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1001)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 27), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1002)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 28), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1003)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 29), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1004)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 30), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1005)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 31), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1006)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 32), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1007)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 33), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1008)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 34), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1009)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 35), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1011)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 36), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1012)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 37), [Config.language("Login", 24)], null, null, false, true, true);
                }
                else if (_loc_4 == 1010)
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 38), [Config.language("Login", 39), Config.language("Login", 24)], [this.goActive], null, false, true, true);
                }
                else
                {
                    AlertUI.alert(Config.language("Login", 54), Config.language("Login", 42, _loc_4), [Config.language("Login", 24)]);
                }
                return;
            }
            _loc_5 = _loc_13.readUnsignedInt();
            this._loginAccountId = _loc_5;
            _loc_3 = _loc_13.readUnsignedShort();
            _loc_12 = _loc_13.readUTFBytes(_loc_3);
            Config.serverTime = _loc_13.readUnsignedInt();
            var _loc_14:* = _loc_13.readUnsignedInt();
            this.doQueue(_loc_14);
            return;
        }// end function

        private function goActive(param1)
        {
            var _loc_2:* = "http://item.kunlun.com/xj/sendcode/";
            var _loc_3:* = new URLRequest(_loc_2);
            navigateToURL(_loc_3, "_self");
            return;
        }// end function

        private function drawPageButtons()
        {
            var _loc_1:* = undefined;
            if (this._mp > 1)
            {
                _loc_1 = 0;
                while (_loc_1 < this._pButtons.length)
                {
                    
                    this._pButtons[_loc_1].parent.removeChild(this._pButtons[_loc_1]);
                    _loc_1 = _loc_1 + 1;
                }
                this._pButtons = [];
                _loc_1 = 0;
                while (_loc_1 < this._mp)
                {
                    
                    this._pButtons[_loc_1] = new PushButton(this._pButtonLayer, (-(this._mp - 1)) * 20 / 2 + 20 * _loc_1 - 6, 0, "", this.handlePageButtonClick, Config.findUI("login").page);
                    this._pButtons[_loc_1].width = 40;
                    this._pButtons[_loc_1].overshow = true;
                    this._pButtons[_loc_1].mode = 1;
                    this._pButtons[_loc_1].data = _loc_1;
                    _loc_1 = _loc_1 + 1;
                }
            }
            return;
        }// end function

        private function handlePageButtonClick(param1)
        {
            var _loc_2:* = PushButton(param1.currentTarget);
            if (this._p != int(_loc_2.data))
            {
                this._p = int(_loc_2.data);
                this.setLogin();
            }
            return;
        }// end function

        private function handleRoleList(param1)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            var _loc_2:* = param1.data;
            this.roleNum = _loc_2.readUnsignedShort();
            if (this.roleNum >= 6)
            {
                this._createpbtn.enabled = false;
            }
            else
            {
                this._createpbtn.enabled = true;
            }
            this._p = 0;
            this._mp = Math.ceil(this.roleNum / 3);
            this.drawPageButtons();
            _loc_3 = 0;
            while (_loc_3 < this.roleNum)
            {
                
                _loc_12 = this.getRoleInfo(_loc_2);
                this._charStack.push(_loc_12);
                this._charStack.sortOn("level", Array.NUMERIC | Array.DESCENDING);
                if (_loc_12.id == Config.loginCharIdCookie)
                {
                    this._autoLoginSelectedChar = _loc_3;
                    _loc_13 = 10;
                    AlertUI.alert(Config.language("Login", 55), Config.language("Login", 56, _loc_13, _loc_12.name), [Config.language("Login", 14)], [this.autoLoginCancel]);
                    clearTimeout(this._autoLoginTimer);
                    this._autoLoginTimer = setTimeout(this.subAutoLogin, 1000, (_loc_13 - 1), _loc_12.name);
                }
                _loc_3 = _loc_3 + 1;
            }
            this.setLogin();
            var _loc_10:* = 0;
            var _loc_11:* = 0;
            _loc_3 = 0;
            while (_loc_3 < this._charStack.length)
            {
                
                if (this._charStack[_loc_3].initTime > _loc_10)
                {
                    _loc_10 = this._charStack[_loc_3].initTime;
                    _loc_11 = this._charStack[_loc_3].id;
                }
                _loc_3 = _loc_3 + 1;
            }
            if (Config._autoEnterGameIn30 && int(Config.now.getTime() / 1000) - _loc_10 - int(Config._serverTimeZoneOffset / 1000) < 30)
            {
                this._selectedChar = this._charStack.length - 1;
                Config._firstInGame = true;
                Config._firstInGameSession = true;
                this.enterGame();
            }
            else
            {
                this.switchPage("LIST");
                if (this.roleNum == 0)
                {
                    this.switchPage("CREATE");
                }
            }
            return;
        }// end function

        private function autoLoginCancel(param1 = null)
        {
            Config.loginCharIdCookie = null;
            clearTimeout(this._autoLoginTimer);
            AlertUI.close();
            return;
        }// end function

        private function subAutoLogin(param1, param2)
        {
            clearTimeout(this._autoLoginTimer);
            if (param1 > 0)
            {
                AlertUI.msg = Config.language("Login", 56, param1, param2);
                this._autoLoginTimer = setTimeout(this.subAutoLogin, 1000, (param1 - 1), param2);
            }
            else
            {
                AlertUI.close();
                this._selectedChar = this._autoLoginSelectedChar;
                this.enterGame();
                Config.autoLogin = true;
            }
            return;
        }// end function

        private function selectChar(param1 = null)
        {
            if (this._selectedChar != null)
            {
                if (this._selectedChar >= this._p * 3 && this._selectedChar < (this._p + 1) * 3)
                {
                    this._listRectArray[this._selectedChar - this._p * 3].selected = false;
                }
            }
            if (param1 != null)
            {
                this._selectedChar = param1 + this._p * 3;
                if (this._selectedChar != null)
                {
                    if (this._charStack[this._selectedChar].status != 5)
                    {
                        this._beginBtn.highlight = true;
                        this._beginBtn.enabled = true;
                        this._listRectArray[param1].selected = true;
                        this._removePB.label = Config.language("Login", 58);
                    }
                    else
                    {
                        this._beginBtn.highlight = false;
                        this._beginBtn.enabled = false;
                        this._listRectArray[param1].selected = true;
                        this._removePB.label = Config.language("Login", 57);
                    }
                    if (this._removePB.parent == null)
                    {
                        this._listPanel.addChild(this._removePB);
                    }
                }
                else
                {
                    if (this._removePB.parent != null)
                    {
                        this._removePB.parent.removeChild(this._removePB);
                    }
                    this._beginBtn.highlight = false;
                    this._beginBtn.enabled = false;
                }
            }
            return;
        }// end function

        private function handleListPanelInfoClick(param1, param2:int)
        {
            var _loc_3:* = undefined;
            if (this._listRectArray[param2].clip != null)
            {
                this.selectChar(param2);
                _loc_3 = this._charStack[this._selectedChar];
                if (_loc_3.name.indexOf(":") == -1)
                {
                    this._beginBtn.label = Config.language("Login", 9);
                }
                else
                {
                    this._beginBtn.label = Config.language("Login", 68);
                }
            }
            else
            {
                if (this.roleNum >= 6)
                {
                    AlertUI.alert(Config.language("Login", 53), Config.language("Login", 49), [Config.language("Login", 7)]);
                    return;
                }
                this.switchPage("CREATE");
            }
            return;
        }// end function

        private function handleListPanelInfoDblClick(param1, param2:int)
        {
            this.selectChar(param2);
            var _loc_3:* = this._charStack[this._selectedChar];
            if (_loc_3.name.indexOf(":") == -1)
            {
                this.enterGame();
            }
            else
            {
                AlertUI.alert("修改重名", "由于您的角色名合服后出现重复，请对角色进行更名。（注：只可更改一次）", ["确定", "取消"], [this.realRename], _loc_3, true);
            }
            return;
        }// end function

        private function handleListPanelClick(param1)
        {
            var _loc_2:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < 3)
            {
                
                if (this._listRectArray[_loc_2] == param1.currentTarget)
                {
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            this.selectChar(_loc_2);
            var _loc_3:* = this._charStack[this._selectedChar];
            if (_loc_3.name.indexOf(":") == -1)
            {
                this._beginBtn.label = Config.language("Login", 9);
            }
            else
            {
                this._beginBtn.label = Config.language("Login", 68);
            }
            return;
        }// end function

        public function removeChar(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            this._charStack[param1] = null;
            _loc_3 = [];
            _loc_2 = 0;
            while (_loc_2 < this._charStack.length)
            {
                
                if (this._charStack[_loc_2] != null)
                {
                    _loc_3.push(this._charStack[_loc_2]);
                }
                _loc_2 = _loc_2 + 1;
            }
            this._charStack = _loc_3;
            this._mp = Math.ceil(this._charStack.length / 3);
            if (this._p >= this._mp)
            {
                this._p = this._mp - 1;
            }
            return;
        }// end function

        private function soundfuc(param1) : void
        {
            SoundManager.musicOn = param1.currentTarget.selected;
            GameSystem._preMusicOn = param1.currentTarget.selected;
            return;
        }// end function

        private function getSoundCookie()
        {
            Config.startLoop(this.subGetCookie);
            return;
        }// end function

        private function subGetCookie(param1 = null)
        {
            Config.stopLoop(this.subGetCookie);
            var _loc_2:* = Config.cookie.get("systemSet");
            if (_loc_2 != null)
            {
                this._soundbtn.selected = _loc_2[3];
                SoundManager.musicOn = this._soundbtn.selected;
            }
            return;
        }// end function

        private function getRoleInfo(param1:ByteArray)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            _loc_3 = param1.readUnsignedInt();
            _loc_2 = param1.readUnsignedShort();
            _loc_4 = param1.readUTFBytes(_loc_2);
            _loc_5 = param1.readByte();
            _loc_6 = param1.readByte();
            _loc_7 = param1.readUnsignedShort();
            _loc_8 = param1.readByte();
            var _loc_9:* = param1.readUnsignedInt();
            var _loc_10:* = param1.readByte();
            var _loc_11:* = param1.readByte().toString(2);
            if (param1.readByte().toString(2).substr((param1.readByte().toString(2).length - 1), 1) != "1")
            {
                _loc_10 = 0;
            }
            else
            {
                _loc_10 = 1;
            }
            var _loc_12:* = param1.readUnsignedInt();
            var _loc_13:* = param1.readUnsignedInt();
            var _loc_14:* = param1.readUnsignedInt();
            var _loc_15:* = param1.readUnsignedInt();
            var _loc_16:* = param1.readUnsignedInt();
            var _loc_17:* = param1.readUnsignedInt();
            return {id:_loc_3, name:_loc_4, sex:_loc_5, job:_loc_6, level:_loc_7, status:_loc_8, initTime:_loc_17, realDelTime:_loc_16, weaponId:_loc_12, hair:_loc_9, szId:_loc_13, wingId:_loc_14, wingLevel:_loc_15, showEquip:_loc_10};
        }// end function

        private function handleQueueUpdate(event:SocketEvent)
        {
            var _loc_2:* = event.data;
            var _loc_3:* = _loc_2.readUnsignedInt();
            this.doQueue(_loc_3);
            return;
        }// end function

        private function doQueue(param1:uint)
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            clearTimeout(this._queueTimer);
            if (param1 == 0)
            {
                if (this._queueBG != null)
                {
                    Config.stopLoop(this.queueBGLoop);
                    this._queueBG.graphics.clear();
                    if (this._queueBG.parent != null)
                    {
                        this._queueBG.parent.removeChild(this._queueBG);
                    }
                    if (this._queuePanel.parent != null)
                    {
                        this._queuePanel.parent.removeChild(this._queuePanel);
                    }
                    if (this._queuePanelContent.parent != null)
                    {
                        this._queuePanelContent.parent.removeChild(this._queuePanelContent);
                    }
                    this._queuePanelContentMask.graphics.clear();
                    if (this._queuePanelContentMask.parent != null)
                    {
                        this._queuePanelContentMask.parent.removeChild(this._queuePanelContentMask);
                    }
                    if (this._queueTF.parent != null)
                    {
                        this._queueTF.parent.removeChild(this._queueTF);
                    }
                    if (this._queuePB.parent != null)
                    {
                        this._queuePB.parent.removeChild(this._queuePB);
                    }
                    this._preQueue = -1;
                    this._queueBG = null;
                }
                _loc_2 = new DataSet();
                _loc_2.addHead(CONST_ENUM.C2L_ROLE_LIST);
                ClientSocket.send(_loc_2);
            }
            else
            {
                if (this._queueBG == null)
                {
                    this._preQueue = -1;
                    this._queueBG = new Shape();
                    this._queueBG.graphics.clear();
                    this._queueBG.graphics.beginFill(0, 1);
                    this._queueBG.graphics.drawRect(0, 0, this._width, this._height);
                    this._queueBG.graphics.endFill();
                    this._queueBG.alpha = 0;
                    addChild(this._queueBG);
                    Config.startLoop(this.queueBGLoop);
                    this._queuePanel = new Table("table8");
                    this._queuePanel.resize(300, 0);
                    this._queuePanel.x = (this._width - this._queuePanel.width) / 2;
                    this._queuePanel.y = (this._height - this._queuePanel.height) / 2;
                    this._queuePanel.filters = [new DropShadowFilter(6, 45, 0, 0.5, 6, 6, 1, BitmapFilterQuality.HIGH)];
                    addChild(this._queuePanel);
                    this._queuePanelContent = new Sprite();
                    this._queuePanel.addChild(this._queuePanelContent);
                    this._queuePanelContentMask = new Shape();
                    this._queuePanel.addChild(this._queuePanelContentMask);
                    this._queuePanelContent.mask = this._queuePanelContentMask;
                    this._queueTF = this.getSimpleTxt();
                    this._queueTF.x = 10;
                    this._queueTF.y = 15;
                    this._queueTF.width = 280;
                    this._queueTF.autoSize = TextFieldAutoSize.CENTER;
                    this._queuePanelContent.addChild(this._queueTF);
                    this._queueTF.defaultTextFormat = new TextFormat(null, 16, null, null, null, null, null, null, "center");
                    this._queueTF.filters = [new DropShadowFilter(2, 45, 0, 0.2, 2, 2)];
                    this._queueTF.textColor = Style.WINDOW_FONT;
                    this._queuePB = new PushButton(this._queuePanelContent, 100, 85, "退出");
                }
                if (this._preQueue == -1)
                {
                    this._queueTF.htmlText = "当前服务器已满\n队列位置：<font color=\'#ad1b2e\'>" + param1 + "</font>\n预估排队时间： <font color=\'#ad1b2e\'>正在估算</font>";
                }
                else
                {
                    _loc_3 = 2;
                    _loc_4 = int(param1 * _loc_3 / (param1 - this._preQueue + _loc_3 / 60) / 60);
                    this._queueTF.htmlText = "当前服务器已满\n队列位置：<font color=\'#ad1b2e\'>" + param1 + "</font>\n预估排队时间： <font color=\'#ad1b2e\'>" + _loc_4 + "</font> 分钟";
                }
                this._preQueue = param1;
                this._queueTimer = setTimeout(this.queueAuto, 5000);
            }
            return;
        }// end function

        private function queueAuto()
        {
            this.doQueue(this._preQueue);
            return;
        }// end function

        private function queueBGLoop(param1)
        {
            this._queueBG.alpha = Math.min(this._queueBG.alpha + 0.2, 0.81);
            this._queuePanel.resize(300, int(this._queueBG.alpha / 0.8 * 120));
            this._queuePanelContentMask.graphics.clear();
            this._queuePanelContentMask.graphics.beginFill(0, 1);
            this._queuePanelContentMask.graphics.drawRect(4, 4, this._queuePanel.width - 8, this._queuePanel.height - 8);
            this._queuePanelContentMask.graphics.endFill();
            this._queuePanel.y = (this._height - this._queuePanel.height) / 2;
            if (this._queueBG.alpha >= 0.8)
            {
                this._queueBG.alpha = 0.8;
                Config.stopLoop(this.queueBGLoop);
            }
            return;
        }// end function

        private function handlebtnOut(event:MouseEvent) : void
        {
            if (this._infoSpr != null)
            {
                while (this._infoSpr.numChildren > 0)
                {
                    
                    this._infoSpr.removeChildAt((this._infoSpr.numChildren - 1));
                }
                this._sprceate.removeChild(this._infoSpr);
            }
            return;
        }// end function

        private function handlebtnOver(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = Config.language("Login", 87);
            if (!this._createpbtn.enabled)
            {
                _loc_3 = Config.language("Login", 88);
                _loc_2 = 20;
            }
            this._infoSpr = new Sprite();
            this._infoSpr.graphics.beginFill(0, 0.4);
            this._infoSpr.graphics.drawRoundRect(0, 0, 105 + _loc_2, 20, 5);
            this._infoSpr.graphics.endFill();
            this._infoSpr.x = -170 - _loc_2 / 2;
            this._infoSpr.y = -10;
            var _loc_4:* = Config.getSimpleTextField();
            Config.getSimpleTextField().multiline = true;
            _loc_4.textColor = 16777215;
            _loc_4.htmlText = "<p align=\'left\'>" + _loc_3 + "</p>";
            this._infoSpr.addChild(_loc_4);
            this._sprceate.addChild(this._infoSpr);
            return;
        }// end function

    }
}
