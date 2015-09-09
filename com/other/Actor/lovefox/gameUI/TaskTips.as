package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import lovefox.component.*;
    import lovefox.socket.*;

    public class TaskTips extends Sprite
    {
        private var _open:Boolean = true;
        private var mainpanel:Sprite;
        public var _autobtn:PushButton;
        private var _openbtn:PushButton;
        private var _panelbtn:PushButton;
        private var _autoaddbtn:PushButton;
        private var autoicon:Sprite;
        private var acolor:int = 6614260;
        private var bcolor:int = 2092116;
        private var ccolor:int = 15590939;
        private var container:DisplayObjectContainer;
        private var _tasklistarr:Array;
        private var _taskliparr:Array;
        private var _autaskid:int = -1;
        private var recStr:String;

        public function TaskTips(param1:DisplayObjectContainer = null, param2:Number = 0, param3:Number = 0)
        {
            if (param1 != null)
            {
                this.container = param1;
                param1.addChild(this);
            }
            this.x = param2;
            this.y = param3;
            this.mainpanel = new Sprite();
            this.addChild(this.mainpanel);
            this._panelbtn = new PushButton(null, 3, 10, "", this.opentaskpanel);
            this._panelbtn.width = 40;
            this._autoaddbtn = new PushButton(null, 43, 10, "", this.autoadd);
            this._autoaddbtn.width = 40;
            this._autobtn = new PushButton(null, 83, 10, "", this.autobtnfuc);
            this._autobtn.width = 40;
            this.autoicon = new Sprite();
            this.autoicon.graphics.beginFill(10040064);
            this.autoicon.graphics.moveTo(0, 5);
            this.autoicon.graphics.lineTo(0, 15);
            this.autoicon.graphics.lineTo(5, 10);
            this.autoicon.graphics.lineTo(0, 5);
            this.autoicon.graphics.endFill();
            this.autoicon.x = 5;
            return;
        }// end function

        public function open() : void
        {
            this._open = true;
            if (this.parent == null && !FbUI._fbing)
            {
                Config.ui._radar.addChild(this);
                if (!Config._switchMobage)
                {
                    Config.ui._radar.addChild(Config.ui._radar._recorderUI);
                }
                Config.ui._radar.addChild(Config.ui._radar.linebtn);
            }
            return;
        }// end function

        public function close(param1 = false) : void
        {
            if (!param1)
            {
                this._open = false;
            }
            if (this.parent != null)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        private function opentaskpanel(event:MouseEvent) : void
        {
            Config.ui._taskpanel.open();
            return;
        }// end function

        private function autoadd(event:MouseEvent) : void
        {
            Config.ui._taskpanel.autoadd();
            return;
        }// end function

        private function autobtnfuc(event:Event) : void
        {
            if (event.currentTarget.mouseEnabled)
            {
                Config.ui._taskpanel.autobtnfuc();
            }
            return;
        }// end function

        private function showlip(event:MouseEvent) : void
        {
            this.close();
            return;
        }// end function

        public function set autobtnlabel(param1:String) : void
        {
            this._autobtn.label = param1;
            Config.ui._taskpanel.autobtn.label = param1;
            return;
        }// end function

        private function handleCloseBtn(event:MouseEvent, param2:int) : void
        {
            Config.ui._taskpanel.delfromlip(param2);
            return;
        }// end function

        public function uptask(param1:Array, param2:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = false;
            var _loc_18:* = 0;
            var _loc_19:* = null;
            var _loc_20:* = null;
            var _loc_21:* = null;
            var _loc_22:* = null;
            var _loc_23:* = null;
            var _loc_24:* = null;
            var _loc_25:* = null;
            var _loc_26:* = null;
            var _loc_27:* = null;
            var _loc_28:* = null;
            var _loc_29:* = null;
            var _loc_30:* = null;
            var _loc_31:* = null;
            var _loc_32:* = null;
            var _loc_33:* = 0;
            var _loc_34:* = 0;
            var _loc_35:* = undefined;
            var _loc_36:* = 0;
            var _loc_37:* = 0;
            var _loc_38:* = null;
            if (this.recStr != param2.toString())
            {
                this.recStr = param2.toString();
                _loc_8 = "";
                _loc_9 = 0;
                while (_loc_9 < param2.length)
                {
                    
                    _loc_8 = _loc_8 + param2[_loc_9];
                    if (_loc_9 < (param2.length - 1))
                    {
                        _loc_8 = _loc_8 + ",";
                    }
                    _loc_9 = _loc_9 + 1;
                }
                _loc_10 = new DataSet();
                _loc_10.addHead(CONST_ENUM.C2G_QUEST_TRACE);
                _loc_10.addUTF(_loc_8);
                ClientSocket.send(_loc_10);
            }
            this.removeallchild(this.mainpanel);
            var _loc_3:* = new Sprite();
            this.mainpanel.addChild(_loc_3);
            _loc_3.y = 10;
            _loc_3.x = 3;
            this._tasklistarr = param1;
            _loc_4 = param2.slice(0, param2.length);
            this._taskliparr = _loc_4;
            _loc_5 = [new GlowFilter(0, 1, 2, 2, 10)];
            _loc_6 = 10;
            _loc_7 = 0;
            while (_loc_7 < _loc_4.length)
            {
                
                _loc_11 = 0;
                while (_loc_11 < param1.length)
                {
                    
                    if (param1[_loc_11].id == _loc_4[_loc_7])
                    {
                        _loc_12 = Config.getSimpleTextField();
                        _loc_12.mouseEnabled = true;
                        _loc_12.height = 18;
                        this.mainpanel.addChild(_loc_12);
                        _loc_12.width = 150;
                        _loc_12.y = _loc_6;
                        _loc_13 = "";
                        _loc_12.htmlText = "<FONT SIZE=\'12\' COLOR=\'#FF9E3E\'><a href=\'event:1\'>" + Config._taskMap[_loc_4[_loc_7]].title + _loc_13 + "</a></FONT>";
                        _loc_12.addEventListener(TextEvent.LINK, Config.create(this.opentask, _loc_4[_loc_7]));
                        _loc_12.filters = _loc_5;
                        _loc_12.x = 115 - _loc_12.width;
                        param1[_loc_11].ypos = _loc_6;
                        _loc_14 = new PushButton(null, 120, _loc_6 + 5, "×", Config.create(this.handleCloseBtn, _loc_4[_loc_7]));
                        _loc_14.overshow = true;
                        _loc_14.setStyle(Config.findUI("window")["closebutton"]);
                        this.mainpanel.addChild(_loc_14);
                        _loc_14.filters = _loc_5;
                        _loc_6 = _loc_6 + 20;
                        _loc_15 = new Array();
                        _loc_16 = true;
                        _loc_17 = true;
                        switch(int(Config._taskMap[_loc_4[_loc_7]].exeType))
                        {
                            case 2:
                            {
                                if (param1[_loc_11].type != 1)
                                {
                                    _loc_22 = new Label(this.mainpanel, 20, _loc_6, Config.language("TaskInfor", 22) + Config._taskMap[_loc_4[_loc_7]].levelCdt);
                                    _loc_22.textColor = 16777215;
                                    _loc_16 = false;
                                    _loc_22.filters = _loc_5;
                                    _loc_15.push(_loc_22);
                                    _loc_23 = new Label(this.mainpanel, 20, _loc_6, "");
                                    _loc_23.textColor = 16777215;
                                    _loc_15.push(_loc_23);
                                }
                                break;
                            }
                            case 3:
                            {
                                if (Config._taskMap[_loc_4[_loc_7]].mapCdt != 0)
                                {
                                    _loc_22 = new Label(null, 20, _loc_6, Config.language("TaskInfor", 23));
                                    _loc_22.filters = _loc_5;
                                    _loc_22.textColor = 16777215;
                                    _loc_24 = new ClickLabel(null, 45, _loc_6, Config._mapMap[Config._taskMap[_loc_4[_loc_7]].mapCdt].mapData.name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_24.clickColor([this.acolor, this.ccolor]);
                                    _loc_16 = false;
                                    if (param1[_loc_11].type >= 1)
                                    {
                                        _loc_24.clickColor([this.bcolor, this.ccolor]);
                                        _loc_16 = true;
                                    }
                                    _loc_15.push(_loc_22);
                                    _loc_15.push(_loc_24);
                                }
                                break;
                            }
                            case 0:
                            {
                                _loc_18 = int(Config._taskMap[param1[_loc_11].id].eventCdt);
                                _loc_20 = new ClickLabel(null, 20, _loc_6, "", Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                _loc_20.clickColor([this.acolor, this.ccolor]);
                                _loc_15.push(_loc_20);
                                if (_loc_18 == 1)
                                {
                                    _loc_19 = Config.language("TaskInfor", 24);
                                }
                                else if (_loc_18 == 2)
                                {
                                    _loc_19 = Config.language("TaskInfor", 25);
                                }
                                else if (_loc_18 == 3)
                                {
                                    _loc_19 = Config.language("TaskInfor", 26);
                                }
                                else if (_loc_18 == 4)
                                {
                                    _loc_19 = Config.language("TaskInfor", 27);
                                }
                                else if (_loc_18 == 5)
                                {
                                    _loc_19 = Config.language("TaskInfor", 28);
                                }
                                else if (_loc_18 == 6)
                                {
                                    _loc_19 = Config._taskMap[_loc_4[_loc_7]].mapCdt + Config.language("TaskInfor", 29);
                                }
                                else if (_loc_18 == 7)
                                {
                                    _loc_19 = Config._taskMap[_loc_4[_loc_7]].mapCdt + Config.language("TaskInfor", 30);
                                }
                                else if (_loc_18 == 8)
                                {
                                    _loc_19 = Config._taskMap[_loc_4[_loc_7]].mapCdt + Config.language("TaskInfor", 31);
                                }
                                else if (_loc_18 == 9)
                                {
                                    _loc_19 = Config._taskMap[_loc_4[_loc_7]].mapCdt + Config.language("TaskInfor", 32);
                                }
                                else if (_loc_18 == 10)
                                {
                                    _loc_19 = Config.language("TaskInfor", 33);
                                }
                                else if (_loc_18 == 11)
                                {
                                    _loc_19 = Config.language("TaskInfor", 34);
                                }
                                else if (_loc_18 == 12)
                                {
                                    _loc_19 = Config.language("TaskInfor", 35);
                                }
                                else if (_loc_18 == 13)
                                {
                                    _loc_19 = Config.language("TaskInfor", 36);
                                }
                                else if (_loc_18 == 14)
                                {
                                    _loc_19 = Config.language("TaskInfor", 37);
                                }
                                else if (_loc_18 == 15)
                                {
                                    _loc_19 = Config.language("TaskInfor", 38);
                                }
                                else if (_loc_18 == 16)
                                {
                                    _loc_19 = Config.language("TaskInfor", 39);
                                }
                                else if (_loc_18 == 17)
                                {
                                    _loc_19 = Config.language("TaskInfor", 40);
                                }
                                else if (_loc_18 == 18)
                                {
                                    _loc_19 = Config.language("TaskInfor", 41);
                                }
                                else if (_loc_18 == 19)
                                {
                                    _loc_19 = Config.language("TaskInfor", 42);
                                }
                                else if (_loc_18 == 20)
                                {
                                    _loc_19 = Config.language("TaskInfor", 43);
                                }
                                else if (_loc_18 == 21)
                                {
                                    _loc_19 = Config.language("TaskInfor", 44);
                                }
                                else if (_loc_18 == 22)
                                {
                                    _loc_19 = Config.language("TaskInfor", 45);
                                }
                                else if (_loc_18 == 23)
                                {
                                    _loc_19 = Config.language("TaskInfor", 46);
                                }
                                else if (_loc_18 == 24)
                                {
                                    _loc_19 = Config.language("TaskInfor", 47);
                                }
                                else if (_loc_18 == 25)
                                {
                                    _loc_19 = Config.language("TaskInfor", 48);
                                }
                                else if (_loc_18 == 26)
                                {
                                    _loc_19 = Config.language("TaskInfor", 49);
                                }
                                else if (_loc_18 == 27)
                                {
                                    _loc_19 = Config.language("TaskInfor", 50);
                                }
                                else if (_loc_18 == 28)
                                {
                                    _loc_19 = Config.language("TaskInfor", 51);
                                }
                                else if (_loc_18 == 29)
                                {
                                    _loc_19 = Config.language("TaskInfor", 52);
                                }
                                else if (_loc_18 == 30)
                                {
                                    _loc_19 = Config.language("TaskInfor", 64);
                                }
                                else if (_loc_18 == 31)
                                {
                                    _loc_19 = Config.language("TaskInfor", 65);
                                }
                                else if (_loc_18 == 32)
                                {
                                    _loc_19 = Config.language("TaskInfor", 66);
                                }
                                _loc_20.text = _loc_19;
                                _loc_20.filters = _loc_5;
                                _loc_21 = new Label(null, _loc_20.x + _loc_20.width, _loc_6);
                                _loc_21.filters = _loc_5;
                                if (param1[_loc_11].type == 1)
                                {
                                    _loc_21.text = Config._taskMap[_loc_4[_loc_7]].mapCdt + "/" + Config._taskMap[_loc_4[_loc_7]].mapCdt;
                                    _loc_20.clickColor([this.bcolor, this.ccolor]);
                                    _loc_21.textColor = this.bcolor;
                                }
                                else
                                {
                                    _loc_21.text = param1[_loc_11].spnum + "/" + Config._taskMap[_loc_4[_loc_7]].mapCdt;
                                    _loc_16 = false;
                                    _loc_21.textColor = 16777215;
                                }
                                _loc_15.push(_loc_21);
                                break;
                            }
                            case 4:
                            {
                                if (Config._taskMap[_loc_4[_loc_7]].mon1 != 0)
                                {
                                    _loc_25 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon1].name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_25.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_25.x + _loc_25.width, _loc_6, String(param1[_loc_11].hadmon1 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum1));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].hadmon1 >= int(Config._taskMap[_loc_4[_loc_7]].monNum1))
                                    {
                                        _loc_25.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_25);
                                    _loc_15.push(_loc_21);
                                    if (Config._taskMap[_loc_4[_loc_7]].mon2 != 0)
                                    {
                                        _loc_26 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon2].name, Config.create(this.autothistask, _loc_4[_loc_7], 2), true);
                                        _loc_26.clickColor([this.acolor, this.ccolor]);
                                        _loc_21 = new Label(null, _loc_26.x + _loc_26.width, _loc_6, String(param1[_loc_11].hadmon2 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum2));
                                        _loc_21.textColor = 16777215;
                                        _loc_17 = false;
                                        if (param1[_loc_11].hadmon2 >= int(Config._taskMap[_loc_4[_loc_7]].monNum2))
                                        {
                                            _loc_26.clickColor([this.bcolor, this.ccolor]);
                                            _loc_21.textColor = this.bcolor;
                                            _loc_17 = true;
                                        }
                                        if (!_loc_17)
                                        {
                                            _loc_16 = false;
                                        }
                                        _loc_15.push(_loc_26);
                                        _loc_15.push(_loc_21);
                                        if (Config._taskMap[_loc_4[_loc_7]].mon3 != 0)
                                        {
                                            _loc_27 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon3].name, Config.create(this.autothistask, _loc_4[_loc_7], 3), true);
                                            _loc_27.clickColor([this.acolor, this.ccolor]);
                                            _loc_21 = new Label(null, _loc_27.x + _loc_27.width, _loc_6, String(param1[_loc_11].hadmon3 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum3));
                                            _loc_21.textColor = 16777215;
                                            _loc_17 = false;
                                            if (param1[_loc_11].hadmon3 >= int(Config._taskMap[_loc_4[_loc_7]].monNum3))
                                            {
                                                _loc_27.clickColor([this.bcolor, this.ccolor]);
                                                _loc_21.textColor = this.bcolor;
                                                _loc_17 = true;
                                            }
                                            if (!_loc_17)
                                            {
                                                _loc_16 = false;
                                            }
                                            _loc_15.push(_loc_27);
                                            _loc_15.push(_loc_21);
                                        }
                                    }
                                }
                                break;
                            }
                            case 5:
                            case 6:
                            {
                                if (Config._taskMap[_loc_4[_loc_7]].item1 != 0)
                                {
                                    _loc_28 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item1].name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_28.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_28.x + _loc_28.width, _loc_6, String(param1[_loc_11].haditem1 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum1));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].haditem1 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum1))
                                    {
                                        _loc_28.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_28);
                                    _loc_15.push(_loc_21);
                                    if (Config._taskMap[_loc_4[_loc_7]].item2 != 0 && int(Config._taskMap[_loc_4[_loc_7]].item2) != int(Config._taskMap[_loc_4[_loc_7]].item1))
                                    {
                                        _loc_29 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item2].name, Config.create(this.autothistask, _loc_4[_loc_7], 2), true);
                                        _loc_29.clickColor([this.acolor, this.ccolor]);
                                        _loc_21 = new Label(null, _loc_29.x + _loc_29.width, _loc_6, String(param1[_loc_11].haditem2 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum2));
                                        _loc_21.textColor = 16777215;
                                        _loc_17 = false;
                                        if (param1[_loc_11].haditem2 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum2))
                                        {
                                            _loc_29.clickColor([this.bcolor, this.ccolor]);
                                            _loc_21.textColor = this.bcolor;
                                            _loc_17 = true;
                                        }
                                        if (!_loc_17)
                                        {
                                            _loc_16 = false;
                                        }
                                        _loc_15.push(_loc_29);
                                        _loc_15.push(_loc_21);
                                        if (Config._taskMap[_loc_4[_loc_7]].item3 != 0 && int(Config._taskMap[_loc_4[_loc_7]].item3) != int(Config._taskMap[_loc_4[_loc_7]].item2))
                                        {
                                            _loc_30 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item3].name, Config.create(this.autothistask, _loc_4[_loc_7], 3), true);
                                            _loc_30.clickColor([this.acolor, this.ccolor]);
                                            _loc_21 = new Label(null, _loc_30.x + _loc_30.width, _loc_6, String(param1[_loc_11].haditem3 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum3));
                                            _loc_21.textColor = 16777215;
                                            _loc_17 = false;
                                            if (param1[_loc_11].haditem3 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum3))
                                            {
                                                _loc_30.clickColor([this.bcolor, this.ccolor]);
                                                _loc_21.textColor = this.bcolor;
                                                _loc_17 = true;
                                            }
                                            if (!_loc_17)
                                            {
                                                _loc_16 = false;
                                            }
                                            _loc_15.push(_loc_30);
                                            _loc_15.push(_loc_21);
                                        }
                                    }
                                }
                                break;
                            }
                            case 8:
                            {
                                if (Config._taskMap[_loc_4[_loc_7]].item1 != 0)
                                {
                                    _loc_28 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item1].name + this.pStr(Config._taskMap[_loc_4[_loc_7]].itemQuality1), Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_28.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_28.x + _loc_28.width, _loc_6, String(param1[_loc_11].haditem1 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum1));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].haditem1 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum1))
                                    {
                                        _loc_28.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_28);
                                    _loc_15.push(_loc_21);
                                    if (Config._taskMap[_loc_4[_loc_7]].item2 != 0 && int(Config._taskMap[_loc_4[_loc_7]].item2) != int(Config._taskMap[_loc_4[_loc_7]].item1))
                                    {
                                        _loc_29 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item2].name + this.pStr(Config._taskMap[_loc_4[_loc_7]].itemQuality2), Config.create(this.autothistask, _loc_4[_loc_7], 2), true);
                                        _loc_29.clickColor([this.acolor, this.ccolor]);
                                        _loc_21 = new Label(null, _loc_29.x + _loc_29.width, _loc_6, String(param1[_loc_11].haditem2 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum2));
                                        _loc_21.textColor = 16777215;
                                        _loc_17 = false;
                                        if (param1[_loc_11].haditem2 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum2))
                                        {
                                            _loc_29.clickColor([this.bcolor, this.ccolor]);
                                            _loc_21.textColor = this.bcolor;
                                            _loc_17 = true;
                                        }
                                        if (!_loc_17)
                                        {
                                            _loc_16 = false;
                                        }
                                        _loc_15.push(_loc_29);
                                        _loc_15.push(_loc_21);
                                        if (Config._taskMap[_loc_4[_loc_7]].item3 != 0 && int(Config._taskMap[_loc_4[_loc_7]].item3) != int(Config._taskMap[_loc_4[_loc_7]].item2))
                                        {
                                            _loc_30 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item3].name + this.pStr(Config._taskMap[_loc_4[_loc_7]].itemQuality3), Config.create(this.autothistask, _loc_4[_loc_7], 3), true);
                                            _loc_30.clickColor([this.acolor, this.ccolor]);
                                            _loc_21 = new Label(null, _loc_30.x + _loc_30.width, _loc_6, String(param1[_loc_11].haditem3 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum3));
                                            _loc_21.textColor = 16777215;
                                            _loc_17 = false;
                                            if (param1[_loc_11].haditem3 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum3))
                                            {
                                                _loc_30.clickColor([this.bcolor, this.ccolor]);
                                                _loc_21.textColor = this.bcolor;
                                                _loc_17 = true;
                                            }
                                            if (!_loc_17)
                                            {
                                                _loc_16 = false;
                                            }
                                            _loc_15.push(_loc_30);
                                            _loc_15.push(_loc_21);
                                        }
                                    }
                                }
                                break;
                            }
                            case 7:
                            {
                                if (Config._taskMap[_loc_4[_loc_7]].mon1 != 0)
                                {
                                    _loc_25 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon1].name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_25.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_25.x + _loc_25.width, _loc_6, String(param1[_loc_11].hadmon1 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum1));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].hadmon1 >= int(Config._taskMap[_loc_4[_loc_7]].monNum1))
                                    {
                                        _loc_25.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_25);
                                    _loc_15.push(_loc_21);
                                    if (Config._taskMap[_loc_4[_loc_7]].mon2 != 0)
                                    {
                                        _loc_26 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon2].name, Config.create(this.autothistask, _loc_4[_loc_7], 2), true);
                                        _loc_26.clickColor([this.acolor, this.ccolor]);
                                        _loc_21 = new Label(null, _loc_26.x + _loc_26.width, _loc_6, String(param1[_loc_11].hadmon2 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum2));
                                        _loc_21.textColor = 16777215;
                                        _loc_17 = false;
                                        if (param1[_loc_11].hadmon2 >= int(Config._taskMap[_loc_4[_loc_7]].monNum2))
                                        {
                                            _loc_26.clickColor([this.bcolor, this.ccolor]);
                                            _loc_21.textColor = this.bcolor;
                                            _loc_17 = true;
                                        }
                                        if (!_loc_17)
                                        {
                                            _loc_16 = false;
                                        }
                                        _loc_15.push(_loc_26);
                                        _loc_15.push(_loc_21);
                                        if (Config._taskMap[_loc_4[_loc_7]].mon3 != 0)
                                        {
                                            _loc_27 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon3].name, Config.create(this.autothistask, _loc_4[_loc_7], 3), true);
                                            _loc_27.clickColor([this.acolor, this.ccolor]);
                                            _loc_21 = new Label(null, _loc_27.x + _loc_27.width, _loc_6, String(param1[_loc_11].hadmon3 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum3));
                                            _loc_21.textColor = 16777215;
                                            _loc_17 = false;
                                            if (param1[_loc_11].hadmon3 >= int(Config._taskMap[_loc_4[_loc_7]].monNum3))
                                            {
                                                _loc_27.clickColor([this.bcolor, this.ccolor]);
                                                _loc_21.textColor = this.bcolor;
                                                _loc_17 = true;
                                            }
                                            if (!_loc_17)
                                            {
                                                _loc_16 = false;
                                            }
                                            _loc_15.push(_loc_27);
                                            _loc_15.push(_loc_21);
                                        }
                                    }
                                }
                                if (Config._taskMap[_loc_4[_loc_7]].item1 != 0)
                                {
                                    _loc_28 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item1].name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_28.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_28.x + _loc_28.width, _loc_6, String(param1[_loc_11].haditem1 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum1));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].haditem1 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum1))
                                    {
                                        _loc_28.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_28);
                                    _loc_15.push(_loc_21);
                                    if (Config._taskMap[_loc_4[_loc_7]].item2 != 0 && int(Config._taskMap[_loc_4[_loc_7]].item2) != int(Config._taskMap[_loc_4[_loc_7]].item1))
                                    {
                                        _loc_29 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item2].name, Config.create(this.autothistask, _loc_4[_loc_7], 2), true);
                                        _loc_29.clickColor([this.acolor, this.ccolor]);
                                        _loc_21 = new Label(null, _loc_29.x + _loc_29.width, _loc_6, String(param1[_loc_11].haditem2 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum2));
                                        _loc_21.textColor = 16777215;
                                        _loc_17 = false;
                                        if (param1[_loc_11].haditem2 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum2))
                                        {
                                            _loc_29.clickColor([this.bcolor, this.ccolor]);
                                            _loc_21.textColor = this.bcolor;
                                            _loc_17 = true;
                                        }
                                        if (!_loc_17)
                                        {
                                            _loc_16 = false;
                                        }
                                        _loc_15.push(_loc_29);
                                        _loc_15.push(_loc_21);
                                        if (Config._taskMap[_loc_4[_loc_7]].item3 != 0 && int(Config._taskMap[_loc_4[_loc_7]].item3) != int(Config._taskMap[_loc_4[_loc_7]].item2))
                                        {
                                            _loc_30 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item3].name, Config.create(this.autothistask, _loc_4[_loc_7], 3), true);
                                            _loc_30.clickColor([this.acolor, this.ccolor]);
                                            _loc_21 = new Label(null, _loc_30.x + _loc_30.width, _loc_6, String(param1[_loc_11].haditem3 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum3));
                                            _loc_21.textColor = 16777215;
                                            _loc_17 = false;
                                            if (param1[_loc_11].haditem3 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum3))
                                            {
                                                _loc_30.clickColor([this.bcolor, this.ccolor]);
                                                _loc_21.textColor = this.bcolor;
                                                _loc_17 = true;
                                            }
                                            if (!_loc_17)
                                            {
                                                _loc_16 = false;
                                            }
                                            _loc_15.push(_loc_30);
                                            _loc_15.push(_loc_21);
                                        }
                                    }
                                }
                                break;
                            }
                            case 9:
                            {
                                if (Config._taskMap[_loc_4[_loc_7]].mon1 != 0 && param1[_loc_11].random == 1)
                                {
                                    _loc_25 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon1].name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_25.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_25.x + _loc_25.width, _loc_6, String(param1[_loc_11].hadmon1 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum1));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].hadmon1 >= int(Config._taskMap[_loc_4[_loc_7]].monNum1))
                                    {
                                        _loc_25.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_25);
                                    _loc_15.push(_loc_21);
                                }
                                if (Config._taskMap[_loc_4[_loc_7]].mon2 != 0 && param1[_loc_11].random == 2)
                                {
                                    _loc_26 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon2].name, Config.create(this.autothistask, _loc_4[_loc_7], 2), true);
                                    _loc_26.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_26.x + _loc_26.width, _loc_6, String(param1[_loc_11].hadmon2 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum2));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].hadmon2 >= int(Config._taskMap[_loc_4[_loc_7]].monNum2))
                                    {
                                        _loc_26.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_26);
                                    _loc_15.push(_loc_21);
                                }
                                if (Config._taskMap[_loc_4[_loc_7]].mon3 != 0 && param1[_loc_11].random == 3)
                                {
                                    _loc_27 = new ClickLabel(null, 20, _loc_6, Config._monsterMap[Config._taskMap[_loc_4[_loc_7]].mon3].name, Config.create(this.autothistask, _loc_4[_loc_7], 3), true);
                                    _loc_27.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_27.x + _loc_27.width, _loc_6, String(param1[_loc_11].hadmon3 + "/" + Config._taskMap[_loc_4[_loc_7]].monNum3));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].hadmon3 >= int(Config._taskMap[_loc_4[_loc_7]].monNum3))
                                    {
                                        _loc_27.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_27);
                                    _loc_15.push(_loc_21);
                                }
                                break;
                            }
                            case 10:
                            case 11:
                            {
                                if (Config._taskMap[_loc_4[_loc_7]].item1 != 0 && param1[_loc_11].random == 1)
                                {
                                    _loc_28 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item1].name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                                    _loc_28.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_28.x + _loc_28.width, _loc_6, String(param1[_loc_11].haditem1 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum1));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].haditem1 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum1))
                                    {
                                        _loc_28.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_28);
                                    _loc_15.push(_loc_21);
                                }
                                if (Config._taskMap[_loc_4[_loc_7]].item2 != 0 && param1[_loc_11].random == 2)
                                {
                                    _loc_29 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item2].name, Config.create(this.autothistask, _loc_4[_loc_7], 2), true);
                                    _loc_29.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_29.x + _loc_29.width, _loc_6, String(param1[_loc_11].haditem2 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum2));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].haditem2 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum2))
                                    {
                                        _loc_29.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_29);
                                    _loc_15.push(_loc_21);
                                }
                                if (Config._taskMap[_loc_4[_loc_7]].item3 != 0 && param1[_loc_11].random == 3)
                                {
                                    _loc_30 = new ClickLabel(null, 20, _loc_6, Config._itemMap[Config._taskMap[_loc_4[_loc_7]].item3].name, Config.create(this.autothistask, _loc_4[_loc_7], 3), true);
                                    _loc_30.clickColor([this.acolor, this.ccolor]);
                                    _loc_21 = new Label(null, _loc_30.x + _loc_30.width, _loc_6, String(param1[_loc_11].haditem3 + "/" + Config._taskMap[_loc_4[_loc_7]].itemNum3));
                                    _loc_21.textColor = 16777215;
                                    _loc_17 = false;
                                    if (param1[_loc_11].haditem3 >= int(Config._taskMap[_loc_4[_loc_7]].itemNum3))
                                    {
                                        _loc_30.clickColor([this.bcolor, this.ccolor]);
                                        _loc_21.textColor = this.bcolor;
                                        _loc_17 = true;
                                    }
                                    if (!_loc_17)
                                    {
                                        _loc_16 = false;
                                    }
                                    _loc_15.push(_loc_30);
                                    _loc_15.push(_loc_21);
                                }
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        if (_loc_16 || param1[_loc_11].type == 1)
                        {
                            _loc_21 = new Label(this.mainpanel, 20, _loc_6, Config.language("TaskInfor", 53));
                            _loc_21.filters = _loc_5;
                            _loc_21.textColor = 16777215;
                            _loc_31 = new ClickLabel(this.mainpanel, 45, _loc_6, Config._npcMap[Config._taskMap[_loc_4[_loc_7]].finishNpc].name, Config.create(this.autothistask, _loc_4[_loc_7], 1), true);
                            _loc_31.clickColor([this.bcolor, this.ccolor]);
                            _loc_31.filters = _loc_5;
                            _loc_32 = this.getFlyBtn(_loc_4[_loc_7], 1);
                            _loc_32.x = _loc_31.x + _loc_31.width + 5;
                            _loc_32.y = _loc_6;
                            this.mainpanel.addChild(_loc_32);
                            _loc_31.x = 115 - _loc_31.width;
                            _loc_21.x = _loc_31.x - 30;
                            _loc_32.x = 120;
                            _loc_6 = _loc_6 + 20;
                        }
                        else
                        {
                            _loc_33 = 1;
                            _loc_34 = 0;
                            while (_loc_34 < _loc_15.length)
                            {
                                
                                this.mainpanel.addChild(_loc_15[_loc_34]);
                                _loc_15[_loc_34].filters = _loc_5;
                                _loc_15[_loc_34].y = _loc_6;
                                if (_loc_34 % 2 > 0)
                                {
                                    _loc_37 = int(Config._taskMap[_loc_4[_loc_7]].exeType);
                                    if ((_loc_37 == 1 || _loc_37 == 4 || _loc_37 == 5 || _loc_37 == 9 || _loc_37 == 10) && param1[_loc_11].type == 0)
                                    {
                                        if (param1[_loc_11].hasOwnProperty("random"))
                                        {
                                            if (param1[_loc_11].random > 0)
                                            {
                                                _loc_33 = param1[_loc_11].random;
                                            }
                                        }
                                        _loc_38 = this.getFlyBtn(_loc_4[_loc_7], _loc_33);
                                        _loc_38.x = 120;
                                        _loc_38.y = _loc_6;
                                        this.mainpanel.addChild(_loc_38);
                                        _loc_33++;
                                    }
                                    _loc_6 = _loc_6 + 20;
                                }
                                _loc_34 = _loc_34 + 1;
                            }
                            _loc_35 = 115;
                            _loc_36 = _loc_15.length - 1;
                            while (_loc_36 >= 0)
                            {
                                
                                _loc_15[_loc_36].x = _loc_35 - _loc_15[_loc_36].width;
                                _loc_35 = _loc_15[_loc_36].x;
                                if (_loc_36 % 2 == 0)
                                {
                                    _loc_35 = 115;
                                }
                                _loc_36 = _loc_36 - 1;
                            }
                        }
                    }
                    _loc_11 = _loc_11 + 1;
                }
                _loc_7 = _loc_7 + 1;
            }
            this._panelbtn.y = _loc_6;
            this._autoaddbtn.y = _loc_6;
            this._autobtn.y = _loc_6;
            _loc_6 = _loc_6 + 20;
            return;
        }// end function

        public function get opening() : Boolean
        {
            return this._open;
        }// end function

        private function openawad(event:MouseEvent, param2:int) : void
        {
            Config.ui._taskpanel.open();
            Config.ui._taskpanel.opentaskinfor(param2, true);
            return;
        }// end function

        private function opentask(event:TextEvent, param2:int) : void
        {
            Config.ui._taskpanel.open();
            Config.ui._taskpanel.opentaskinfor(param2, true);
            return;
        }// end function

        private function removeallchild(param1:Sprite) : void
        {
            while (param1.numChildren > 0)
            {
                
                param1.removeChildAt((param1.numChildren - 1));
            }
            return;
        }// end function

        public function autoiconfuc(param1:int) : void
        {
            if (this._tasklistarr == null)
            {
                return;
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._tasklistarr.length)
            {
                
                if (this._tasklistarr[_loc_2].id == param1)
                {
                    if (this.autoicon.parent == null)
                    {
                        this.mainpanel.addChild(this.autoicon);
                    }
                    this.autoicon.y = this._tasklistarr[_loc_2].ypos;
                    this._autaskid = param1;
                    break;
                }
                _loc_2 = _loc_2 + 1;
            }
            var _loc_3:* = true;
            var _loc_4:* = 0;
            while (_loc_4 < this._taskliparr.length)
            {
                
                if (this._taskliparr[_loc_4] == this._autaskid)
                {
                    _loc_3 = false;
                }
                _loc_4 = _loc_4 + 1;
            }
            if (_loc_3)
            {
                this.stopautoicon();
            }
            return;
        }// end function

        public function stopautoicon() : void
        {
            if (this.autoicon.parent != null)
            {
                this.mainpanel.removeChild(this.autoicon);
                this._autaskid = -1;
            }
            return;
        }// end function

        private function autothistask(event:TextEvent, param2:int = 0, param3:int = 1) : void
        {
            trace(param2);
            Config.ui._taskpanel._tasksite = param3;
            Config.ui._taskpanel.autotaskid = param2;
            return;
        }// end function

        private function getFlyBtn(param1:int, param2:int) : Sprite
        {
            var _loc_3:* = new Sprite();
            var _loc_4:* = new Bitmap();
            var _loc_5:* = Config.ui._mousepointer._cursorStack["jump"];
            _loc_4.bitmapData = _loc_5.bmpd;
            _loc_3.addChild(_loc_4);
            _loc_3.buttonMode = true;
            _loc_3.addEventListener(MouseEvent.CLICK, Config.create(this.flycheck, param1, param2));
            return _loc_3;
        }// end function

        private function flycheck(event:MouseEvent, param2:int, param3:int) : void
        {
            this.findMap(param2, param3);
            return;
        }// end function

        private function findMap(param1:int, param2:int) : void
        {
            var _loc_4:* = 0;
            var _loc_3:* = 0;
            while (_loc_3 < this._tasklistarr.length)
            {
                
                if (this._tasklistarr[_loc_3].id == param1)
                {
                    _loc_4 = 0;
                    switch(this._tasklistarr[_loc_3].type)
                    {
                        case 0:
                        {
                            switch(int(Config._taskMap[param1].exeType))
                            {
                                case 1:
                                {
                                    _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, int(Config._taskMap[param1].finishNpc));
                                    Config.ui._taskpanel.setMapNext(1, int(Config._taskMap[param1].finishNpc));
                                    break;
                                }
                                case 4:
                                case 5:
                                {
                                    _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[param1]["mon" + param2]));
                                    Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[param1]["mon" + param2]));
                                    break;
                                }
                                case 6:
                                case 7:
                                {
                                    if (int(Config._taskMap[param1]["mon" + param2]) != 0)
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[param1]["mon" + param2]));
                                        Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[param1]["mon" + param2]));
                                    }
                                    else
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[param1]["item" + param2]));
                                        Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[param1]["mon" + param2]));
                                    }
                                    break;
                                }
                                case 9:
                                case 10:
                                {
                                    if (this._tasklistarr[_loc_3].random == 1)
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[param1].mon1));
                                        Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[param1].mon1));
                                    }
                                    else if (this._tasklistarr[_loc_3].random == 2)
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[param1].mon2));
                                        Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[param1].mon2));
                                    }
                                    else if (this._tasklistarr[_loc_3].random == 3)
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[param1].mon3));
                                        Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[param1].mon3));
                                    }
                                    break;
                                }
                                case 11:
                                {
                                    if (this._tasklistarr[_loc_3].random == 1)
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[param1].mon1));
                                        Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[param1].mon1));
                                    }
                                    else if (this._tasklistarr[_loc_3].random == 2)
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[param1].mon2));
                                        Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[param1].mon2));
                                    }
                                    else if (this._tasklistarr[_loc_3].random == 3)
                                    {
                                        _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[param1].mon3));
                                        Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[param1].mon3));
                                    }
                                    break;
                                }
                                default:
                                {
                                    break;
                                }
                            }
                            break;
                        }
                        case 1:
                        {
                            _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, int(Config._taskMap[param1].finishNpc));
                            Config.ui._taskpanel.setMapNext(1, int(Config._taskMap[param1].finishNpc));
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    if (_loc_4 > 0)
                    {
                        if (_loc_4 == Config.map._id)
                        {
                            Config.message(Config.language("TaskInfor", 62));
                        }
                        else
                        {
                            Config.ui._zoommap.flyMapAlert(_loc_4);
                        }
                    }
                    else
                    {
                        switch(int(Config._taskMap[param1]["roadType" + param2]))
                        {
                            case 0:
                            {
                                Config.message(Config.language("TaskInfor", 63));
                                return;
                            }
                            case 1:
                            {
                                _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_NPC, int(Config._taskMap[param1]["road" + param2]));
                                Config.ui._taskpanel.setMapNext(1, int(Config._taskMap[param1]["road" + param2]));
                                break;
                            }
                            case 2:
                            {
                                _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_UNIT, int(Config._taskMap[param1]["road" + param2]));
                                Config.ui._taskpanel.setMapNext(2, int(Config._taskMap[param1]["road" + param2]));
                                break;
                            }
                            case 3:
                            {
                                _loc_4 = DistrictMap.findMap(UNIT_TYPE_ENUM.TYPEID_GATHER, int(Config._taskMap[param1]["road" + param2]));
                                Config.ui._taskpanel.setMapNext(3, int(Config._taskMap[param1]["road" + param2]));
                                break;
                            }
                            case 4:
                            {
                                break;
                            }
                            case 5:
                            {
                                _loc_4 = int(Config._taskMap[param1]["road" + param2]);
                                break;
                            }
                            case 6:
                            {
                                return;
                            }
                            default:
                            {
                                break;
                            }
                        }
                        if (_loc_4 > 0)
                        {
                            Config.ui._zoommap.flyMapAlert(_loc_4);
                        }
                        else
                        {
                            Config.message(Config.language("TaskInfor", 69));
                        }
                    }
                    break;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        private function pStr(param1:int) : String
        {
            var _loc_2:* = "";
            var _loc_3:* = {0:"", 1:"", 2:Config.language("TaskInfor", 70), 4:Config.language("TaskInfor", 71), 8:Config.language("TaskInfor", 72), 16:Config.language("TaskInfor", 73), 30:Config.language("TaskInfor", 70), 28:Config.language("TaskInfor", 71), 24:Config.language("TaskInfor", 72)};
            if (_loc_3[param1] != null)
            {
                _loc_2 = _loc_3[param1];
            }
            return _loc_2;
        }// end function

    }
}
