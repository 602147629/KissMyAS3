package lovefox.unit
{
    import flash.events.*;
    import lovefox.socket.*;

    public class Npc extends Unit
    {
        public var _sky:Boolean = false;
        private var _oriData:Object;
        private var _poolPushed:Boolean = false;
        private var _pushPoolTimer:Object;
        private var _modifiedX:Object;
        private var _modifiedY:Object;
        private var _finalAngle:Object;
        private var _finalPt:Object;
        private var _initModifiedYTime:Object = 1;
        private var _modifiedYTime:Object;
        private var _moveState:Object = 0;
        private var _rumorTimer:Object;
        private var _rumorLock:Object;
        private var _taskState:Object;
        private var _talkTime:Object;
        private var _talkMode:uint;
        private var _talkIndex:uint = 0;
        private var _sayArr:Array;
        private var _layer:uint;
        private var _say0Timer:Number;
        private var _effectOnly:int = 0;
        private var _bard:Boolean = false;
        private var _bardSayArray:Array;
        private var _bardSayIndex:uint;
        private var _bardSayCount:int;
        private var _bardSayTimer:Number;
        private var _playTimer:Number;
        private var _bardFlag:Boolean = false;
        private var _menuArr:Array;
        private var _nowMusic:String = "";
        public static var _idIndexMap:Object = {};
        public static var _objectPool:Array = [];
        public static var _skyNpcStack:Object = {};
        private static var _npcIdMap:Object = {};
        public static var _npcId:Object = 0;

        public function Npc(param1, param2, param3, param4, param5)
        {
            super(param1, param2, param3, param4, param5);
            this._layer = Number(param1.layer);
            this.baseData = param1;
            this.check();
            return;
        }// end function

        public function check()
        {
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = undefined;
            var _loc_1:* = false;
            var _loc_2:* = false;
            var _loc_3:* = String(_data.canBeSee);
            var _loc_4:* = Number(_data.conditionItem);
            var _loc_5:* = Number(_data.conditionDoTask);
            var _loc_6:* = Number(_data.conditionCompleteTask);
            if (Config.ui != null)
            {
                if (_loc_4 != 0)
                {
                    _loc_1 = true;
                    trace("conditionItem", _loc_4);
                    if (_loc_4 > 0)
                    {
                        if (Config.ui._charUI.getItemArr(_loc_4).length > 0)
                        {
                            _loc_2 = true;
                        }
                    }
                    else if (Config.ui._charUI.getItemArr(-_loc_4).length <= 0)
                    {
                        _loc_2 = true;
                    }
                }
                if (_loc_5 != 0)
                {
                    _loc_1 = true;
                    _loc_7 = Config.ui._taskpanel.getTaskState(_loc_5);
                    trace("conditionDoTask", _loc_5, _loc_7);
                    if (_loc_7 == 0 || _loc_7 == 1 || _loc_7 == 2)
                    {
                        _loc_2 = true;
                    }
                }
                if (_loc_6 != 0)
                {
                    _loc_1 = true;
                    _loc_7 = Config.ui._taskpanel.getTaskState(_loc_6);
                    trace("conditionCompleteTask", _loc_6, _loc_7);
                    if (_loc_7 == 3)
                    {
                        _loc_2 = true;
                    }
                }
            }
            if (_loc_1)
            {
                trace("fit", _loc_2, name, _loc_3);
                _loc_8 = false;
                if (_loc_3 == "-1")
                {
                    if (_loc_2)
                    {
                        if (forceClip != 0)
                        {
                            this.forceClip = 0;
                        }
                    }
                    else if (forceClip != -1)
                    {
                        this.forceClip = -1;
                    }
                }
                else if (_loc_3 == "0")
                {
                    if (_loc_2)
                    {
                        if (forceClip != -1)
                        {
                            this.forceClip = -1;
                        }
                    }
                    else if (forceClip != 0)
                    {
                        this.forceClip = 0;
                    }
                }
                else if (_loc_2)
                {
                    if (_loc_3.indexOf("#") == 0)
                    {
                        _loc_9 = Config._npcMap[Number(_loc_3.substring(1, _loc_3.length))];
                        if (_loc_9 != _data)
                        {
                            this.baseData = _loc_9;
                            _loc_8 = true;
                        }
                    }
                    else
                    {
                        this.forceClip = Number(_loc_3);
                    }
                }
                else if (_loc_3.indexOf("#") == 0)
                {
                }
                else
                {
                    this.forceClip = 0;
                }
                if (_loc_8)
                {
                    this.check();
                }
            }
            if (Config.ui != null)
            {
                Config.ui._gildwar.npctitle(this);
            }
            return;
        }// end function

        override public function set forceClip(param1)
        {
            trace("forceClip", param1);
            super.forceClip = param1;
            this.clearTimer();
            if (_forceClip < 0)
            {
                if (Config.ui != null)
                {
                    Config.ui._radar.removeNpc(this);
                }
            }
            else
            {
                if (this._sayArr != null)
                {
                    if (this._talkTime == 0)
                    {
                        this._say0Timer = setTimeout(this.handleSay0, 1000);
                    }
                    else if (this._talkTime != null)
                    {
                        this.rumor(false);
                    }
                }
                if (Config.ui != null)
                {
                    Config.ui._radar.addNpc(this);
                }
            }
            return;
        }// end function

        public function sing()
        {
            this.clearTimer();
            this._bardFlag = true;
            Bard.getBard(_data.id, this.singObj);
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMoveBard);
                Config.player.addEventListener("move", this.handlePlayerMoveBard);
            }
            return;
        }// end function

        private function handlePlayerMoveBard(param1)
        {
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMoveBard);
            }
            this._bardFlag = false;
            return;
        }// end function

        public function play(param1 = 30000)
        {
            this.clearTimer();
            this._bardFlag = false;
            this.stopBard();
            this._playTimer = setTimeout(this.subPlay, param1);
            return;
        }// end function

        private function stopBard()
        {
            if (this._bard)
            {
                say();
                this.changeStateTo("idle");
            }
            return;
        }// end function

        public function subPlay()
        {
            this.clearTimer();
            Bard.getBard(_data.id, this.singObj);
            return;
        }// end function

        private function singObj(param1:Array, param2:String, param3, param4 = false, param5 = 0)
        {
            if (_data.id != 170000)
            {
                return;
            }
            this._bardSayIndex = 0;
            this._bardSayCount = 0;
            if (param2 == null || param2 == "" || param2.indexOf("http") != 0)
            {
                this._nowMusic = "";
                Music.playList(Bard._bardMusicList);
            }
            else if (this._nowMusic != param2)
            {
                this._nowMusic = param2;
                Music.playList([param2], param4);
            }
            if (param5 == 1)
            {
                UnitEffect.motionEffectParam(_map, this, this, "1051_7_0_80_0_10_50_-1_0.5_0.2_0_0_0_0_0_0_0_32_30_-2_0.1_0_0_0_10_0_0_0");
            }
            else if (param5 == 2)
            {
                UnitEffect.motionEffectParam(_map, this, this, "1221_7_0_80_0_10_50_-1_0.5_0.2_0_0_0_0_0_0_0_32_30_-2_0.1_0_0_0_10_0_0_0");
            }
            else if (param5 == 3)
            {
                UnitEffect.motionEffectParam(_map, this, this, "1214_7_0_80_0_10_50_-1_0.5_0.2_0_0_0_0_0_0_0_32_30_-2_0.1_0_0_0_10_0_0_0");
            }
            else
            {
                UnitEffect.motionEffectParam(_map, this, this, "1218_7_0_80_0_10_50_-1_0.5_0.2_0_0_0_0_0_0_0_32_30_-2_0.1_0_0_0_10_0_0_0");
            }
            this._bardSayArray = param1;
            changeStateTo(param3);
            this.singLoop();
            return;
        }// end function

        private function singLoop()
        {
            this.clearTimer();
            var _loc_1:* = "<f:10>" + this._bardSayArray[this._bardSayIndex];
            var _loc_2:* = 0;
            while (_loc_2 < this._bardSayCount)
            {
                
                _loc_1 = _loc_1 + "。";
                _loc_2 = _loc_2 + 1;
            }
            say(_loc_1);
            var _loc_3:* = this;
            var _loc_4:* = this._bardSayCount + 1;
            _loc_3._bardSayCount = _loc_4;
            if (this._bardSayCount > 3)
            {
                var _loc_3:* = this;
                var _loc_4:* = this._bardSayIndex + 1;
                _loc_3._bardSayIndex = _loc_4;
                if (this._bardSayIndex >= this._bardSayArray.length)
                {
                    if (this._bardFlag)
                    {
                        this.sing();
                    }
                    else
                    {
                        this.play();
                    }
                    return;
                }
                this._bardSayCount = 0;
            }
            this._bardSayTimer = setTimeout(this.singLoop, 1000);
            return;
        }// end function

        override public function set baseData(param1)
        {
            this._oriData = _data;
            _data = param1;
            if (_data != null)
            {
                this._effectOnly = _data.effectOnly;
                if (Config.ui != null)
                {
                    Config.ui._radar.removeNpc(this);
                }
                this.clearTimer();
                if (this._effectOnly == 0)
                {
                    if (_forceClip >= 0)
                    {
                        if (Config.ui != null)
                        {
                            Config.ui._radar.addNpc(this);
                        }
                    }
                    this._layer = _data.layer;
                    this._talkTime = _data.talkTime;
                    this._talkMode = _data.talkMode;
                    if (_data.name != null)
                    {
                        name = _data.name;
                    }
                    if (_data.title != null)
                    {
                        title = _data.title;
                    }
                    this.clearTimer();
                    if (_data.id == 170000)
                    {
                        this._bard = true;
                        this.play(5000);
                    }
                    else
                    {
                        if (_data.rumor != null && _data.rumor is String)
                        {
                            this._sayArr = _data.rumor.split(";");
                        }
                        if (this._sayArr != null)
                        {
                            if (this._talkTime == 0)
                            {
                                this._say0Timer = setTimeout(this.handleSay0, 1000);
                            }
                            else if (this._talkTime != null)
                            {
                                this.rumor(false);
                            }
                        }
                    }
                }
                if (_mc != null)
                {
                    reDraw();
                }
            }
            else
            {
                this.forceClip = -1;
                if (Config.ui != null)
                {
                    Config.ui._radar.removeNpc(this);
                }
            }
            return;
        }// end function

        private function handleSay0()
        {
            say(DescriptionTranslate.translate(this._sayArr[0]), 0);
            return;
        }// end function

        public function set mood(param1)
        {
            if (_stateBar != null)
            {
                _stateBar.mood = param1;
            }
            return;
        }// end function

        public function set taskState(param1:int)
        {
            var _loc_2:* = undefined;
            if (Config.ui != null)
            {
                if (this._taskState != param1)
                {
                    this._taskState = param1;
                    _loc_2 = Config.ui._radar.getNpcIcon(this);
                    switch(this._taskState)
                    {
                        case 0:
                        {
                            this.mood = "task4";
                            if (_loc_2 != null)
                            {
                                _loc_2.style = "task4_1";
                            }
                            break;
                        }
                        case 1:
                        case 2:
                        {
                            this.mood = "task2";
                            if (_loc_2 != null)
                            {
                                _loc_2.style = "task2_1";
                            }
                            break;
                        }
                        case 4:
                        {
                            this.mood = "task1";
                            if (_loc_2 != null)
                            {
                                _loc_2.style = "task1_1";
                            }
                            break;
                        }
                        default:
                        {
                            this.mood = this.getNormalMood();
                            if (_loc_2 != null)
                            {
                                _loc_2.style = this.getNormalIcon();
                            }
                            break;
                            break;
                        }
                    }
                }
            }
            return;
        }// end function

        public function getNormalMood()
        {
            switch(this.npcid)
            {
                case 30002:
                case 30005:
                case 30006:
                case 30007:
                {
                    return "forge_1";
                }
                case 50001:
                case 50002:
                case 50003:
                case 50004:
                {
                    return "depot_1";
                }
                case 60001:
                case 60002:
                {
                    return "guild_1";
                }
                case 60007:
                case 60009:
                {
                    return "act_1";
                }
                case 60008:
                {
                    return "wish_1";
                }
                case 10012:
                {
                    return "gift_1";
                }
                case 10017:
                case 12015:
                case 14017:
                {
                    return "task_1";
                }
                case 60016:
                case 60017:
                case 60018:
                case 60019:
                {
                    return "escort_1";
                }
                default:
                {
                    if (_data.shopId != null && _data.shopId != 0)
                    {
                        return "shop_1";
                    }
                    if (_data.portalId != null && _data.portalId != 0 && _data.npcFunction != 512)
                    {
                        return "portal_1";
                    }
                    break;
                    break;
                }
            }
            return;
        }// end function

        public function getNormalIcon()
        {
            switch(this.npcid)
            {
                case 30002:
                case 30005:
                case 30006:
                case 30007:
                {
                    return "forge_0";
                }
                case 50001:
                case 50002:
                case 50003:
                case 50004:
                {
                    return "depot_0";
                }
                case 60001:
                case 60002:
                {
                    return "guild_0";
                }
                case 60007:
                {
                    return "act_0";
                }
                case 60008:
                {
                    return "wish_0";
                }
                case 60009:
                {
                    return "act_0";
                }
                case 60016:
                case 60017:
                case 60018:
                case 60019:
                {
                    return "escort_0";
                }
                default:
                {
                    if (_data.shopId != null && _data.shopId != 0)
                    {
                        return "shop_0";
                    }
                    if (_data.portalId != null && _data.portalId != 0)
                    {
                        return "portal_0";
                    }
                    return "task0_1";
                    break;
                }
            }
        }// end function

        public function get taskState()
        {
            return this._taskState;
        }// end function

        public function forceSay(param1, param2 = null)
        {
            say(param1, 0, param2);
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMove);
                Config.player.addEventListener("move", this.handlePlayerMove);
            }
            return;
        }// end function

        public function openMenu(param1 = null) : void
        {
            var _loc_3:* = undefined;
            var _loc_12:* = null;
            var _loc_13:* = undefined;
            var _loc_14:* = undefined;
            var _loc_15:* = undefined;
            var _loc_16:* = undefined;
            var _loc_17:* = undefined;
            var _loc_18:* = undefined;
            var _loc_19:* = null;
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMove);
                Config.player.addEventListener("move", this.handlePlayerMove);
            }
            _npcId = this.id;
            if (_data.id == 40020)
            {
                _loc_12 = new DataSet();
                _loc_12.addHead(CONST_ENUM.C2G_LEAVEINSTANCE);
                ClientSocket.send(_loc_12);
                return;
            }
            if (_data.id == 170000)
            {
                if (this._nowMusic == "")
                {
                    Music.playList(Bard._bardMusicList, true);
                }
                this.sing();
                return;
            }
            else if (_data.npcFunction == 512)
            {
                _loc_15 = {};
                for (_loc_16 in Config._portalMap)
                {
                    
                    _loc_18 = Config._portalMap[_loc_16];
                    if (_loc_15[Number(_loc_18.portalId)] == null)
                    {
                        _loc_15[Number(_loc_18.portalId)] = [];
                    }
                    _loc_15[Number(_loc_18.portalId)].push(_loc_18);
                }
                _loc_13 = _loc_15[Number(_data.portalId)];
                _loc_17 = 0;
                while (_loc_17 < _loc_13.length)
                {
                    
                    _loc_14 = _loc_13[_loc_17];
                    _loc_12 = new DataSet();
                    _loc_12.addHead(CONST_ENUM.C2G_PLAYER_PORTOL);
                    _loc_12.add32(this.id);
                    _loc_12.add32(_loc_14.id);
                    ClientSocket.send(_loc_12);
                    return;
                    _loc_17 = _loc_17 + 1;
                }
            }
            else if (_data.npcFunction == 16384)
            {
                return;
            }
            this._rumorLock = true;
            var _loc_2:* = "";
            var _loc_4:* = [];
            var _loc_5:* = Config.ui._taskpanel.npctalkarr(this.npcid);
            var _loc_6:* = false;
            var _loc_7:* = false;
            var _loc_8:* = false;
            var _loc_9:* = false;
            if (_data.dialog != null)
            {
                _loc_6 = true;
                _loc_3 = _data.dialog.split(";");
                _loc_2 = _loc_2 + _loc_3[Math.floor(Math.random() * _loc_3.length)];
            }
            var _loc_10:* = 0;
            while (_loc_10 < _loc_5.length)
            {
                
                _loc_7 = true;
                _loc_19 = "";
                if (_loc_5[_loc_10].type == 0)
                {
                    _loc_19 = Config.language("Npc", 1);
                }
                else if (_loc_5[_loc_10].type == 1)
                {
                    _loc_19 = Config.language("Npc", 2);
                    Config.ui._taskpanel.autolingshang(this.id, _loc_5[_loc_10].id);
                }
                else if (_loc_5[_loc_10].type == 2)
                {
                    _loc_19 = Config.language("Npc", 2);
                }
                else if (_loc_5[_loc_10].type == 4)
                {
                    _loc_19 = Config.language("Npc", 3);
                }
                _loc_4.push({label:Config.language("Npc", 4, Config._taskMap[_loc_5[_loc_10].id].title, _loc_19), handler:this.create(this.taskshow, _loc_5[_loc_10])});
                if (Config.ui._taskpanel.autotaskid == _loc_5[_loc_10].id && _loc_5[_loc_10].type == 1)
                {
                    _loc_4 = [];
                    this.taskshow(null, _loc_5[_loc_10]);
                    return;
                }
                _loc_10 = _loc_10 + 1;
            }
            if (_data.shopId != null && _data.shopId != 0)
            {
                _loc_8 = true;
                _loc_4.push({label:Config.language("Npc", 6), handler:this.handleShop});
            }
            if (_data.portalId != null && _data.portalId != 0)
            {
                _loc_9 = true;
                this.handlePortal(null, _loc_4);
            }
            this.npctasklist(_data.id, _loc_4);
            var _loc_11:* = this.opendialogue(_loc_2, _loc_4);
            if (_data.id == 60016 && _loc_11[0] != null)
            {
                GuideUI.testDoId(70, _loc_11[0]);
            }
            return;
        }// end function

        public function opendialogue(param1:String, param2:Array)
        {
            Config.ui._dialogue.closedialogue();
            var _loc_3:* = Config.ui._dialogue.showdialog(this.npcid, param1, param2);
            return _loc_3;
        }// end function

        private function npctasklist(param1:int, param2:Array) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (Config._npcMap[param1].npcFunction != 0)
            {
                _loc_3 = Number(Config._npcMap[param1].npcFunction).toString(2);
                _loc_4 = 0;
                while (_loc_4 < _loc_3.length)
                {
                    
                    if (_loc_3.substr(_loc_4, 1) != "0")
                    {
                        _loc_5 = "1";
                        _loc_6 = 1;
                        while (_loc_6 < _loc_3.length - _loc_4)
                        {
                            
                            _loc_5 = _loc_5 + "0";
                            _loc_6 = _loc_6 + 1;
                        }
                        switch(parseInt(_loc_5, 2))
                        {
                            case 1:
                            {
                                param2.push({label:Config.language("Npc", 8), handler:this.handware});
                                break;
                            }
                            case 2:
                            {
                                Config.ui._gildwar.npcTalk(param1, param2, this.openMenu);
                                break;
                            }
                            case 4:
                            {
                                param2.push({label:Config.language("Npc", 9), handler:this.handwish});
                                break;
                            }
                            case 8:
                            {
                                trace(param1);
                                param2.push({label:Config.language("Npc", 10), handler:this.temptaskopen});
                                this._menuArr = [];
                                this._menuArr = param2;
                                break;
                            }
                            case 16:
                            {
                                break;
                            }
                            case 32:
                            {
                                break;
                            }
                            case 64:
                            {
                                break;
                            }
                            case 128:
                            {
                                break;
                            }
                            case 256:
                            {
                                Config.ui._taskpanel.dayListNpcTalk(param1, param2, this.openMenu);
                                break;
                            }
                            case 2048:
                            {
                                param2.push({label:Config.language("Npc", 14), handler:this.handleBout, closeflag:true});
                                break;
                            }
                            case 4096:
                            {
                                Config.ui._bigWar.npcTalkEnterWar(param1, param2, this.openMenu);
                                break;
                            }
                            case 8192:
                            {
                                param2.push({label:Config.language("Npc", 15), handler:this.showActivity});
                                param2.push({label:Config.language("Npc", 16), handler:this.codeExchange, closeflag:true});
                                if (Config.ui._activeprize.oldplayer)
                                {
                                    param2.push({label:Config.language("Npc", 35), handler:this.prizePlayer, closeflag:true});
                                }
                                Config.ui._nationalDayPanel.addNpcShow(param1, param2, this.openMenu);
                                Config.ui._mbbPanel.npcTalk(param1, param2, this.openMenu);
                                break;
                            }
                            case 32768:
                            {
                                param2.push({label:Config.language("Npc", 36), handler:this.backGiftMap});
                                break;
                            }
                            case 65536:
                            {
                                Config.ui._dayGiftPanel.dayListNpcTalk(param1, param2, this.openMenu);
                                break;
                            }
                            case 131072:
                            {
                                Config.ui._transport.transpNpcTalk(param1, param2, this.openMenu);
                                break;
                            }
                            case 262144:
                            {
                                Config.ui._randompetegg.addListNpcTalk(param1, param2, this.openMenu);
                                break;
                            }
                            default:
                            {
                                break;
                            }
                        }
                    }
                    _loc_4 = _loc_4 + 1;
                }
            }
            if (Config._giftNpcMap[param1] != null)
            {
                _loc_6 = 0;
                while (_loc_6 < Config._giftNpcMap[param1].arr.length)
                {
                    
                    param2.push({label:Config._giftNpcMap[param1].arr[_loc_6].desc, handler:Config.create(this.goGiftMap, Config._giftNpcMap[param1].arr[_loc_6].mapId)});
                    _loc_6 = _loc_6 + 1;
                }
            }
            return;
        }// end function

        public function codeExchange(param1) : void
        {
            AlertUI.alert(Config.language("Npc", 17), Config.language("Npc", 18), [Config.language("Npc", 19), Config.language("Npc", 20)], [this.subCodeExchange], null, true);
            return;
        }// end function

        public function subCodeExchange(param1, param2) : void
        {
            var _loc_3:* = null;
            if (param2 != "" && param2 != null)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_GIFT_CODE);
                _loc_3.add32(id);
                _loc_3.addUTF(param2);
                ClientSocket.send(_loc_3);
            }
            else
            {
                AlertUI.alert(Config.language("Npc", 21), Config.language("Npc", 22), [Config.language("Npc", 23)]);
            }
            return;
        }// end function

        private function prizePlayer(param1)
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_OLDUSER_GET);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        public function showActivity(param1) : void
        {
            var _loc_4:* = undefined;
            var _loc_2:* = [];
            var _loc_3:* = Config.ui._activeprize.getactiveId();
            _loc_4 = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                _loc_2.push({label:Config.language("Npc", 24, _loc_3[_loc_4]._name), handler:Config.create(this.handleMoneyActivity, Number(_loc_3[_loc_4]._id)), closeflag:true});
                _loc_4 = _loc_4 + 1;
            }
            this.opendialogue(Config.language("Npc", 26), _loc_2);
            return;
        }// end function

        private function backGiftMap(param1) : void
        {
            var _loc_2:* = new DataSet();
            _loc_2.addHead(CONST_ENUM.C2G_LEFT_UMAP);
            ClientSocket.send(_loc_2);
            return;
        }// end function

        private function goGiftMap(param1, param2:int) : void
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_ENTER_UMAP);
            _loc_3.add32(int(Config._giftMap[param2].id));
            ClientSocket.send(_loc_3);
            return;
        }// end function

        private function handleMoneyActivity(param1, param2)
        {
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_MONEYGIFT_QUERY);
            _loc_3.add32(param2);
            ClientSocket.send(_loc_3);
            trace(param2, "id++++++++++");
            return;
        }// end function

        private function handleBout(param1)
        {
            Config.ui._fbDetailUI.openBout();
            return;
        }// end function

        private function temptaskopen(param1) : void
        {
            var _loc_2:* = Config._activMap[1].information;
            Config.ui._dialogue.showdialog(60013, _loc_2, this._menuArr);
            return;
        }// end function

        private function handlePlayerMove(param1)
        {
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMove);
            }
            Config.ui._dialogue.closedialogue();
            this._rumorLock = false;
            if (Config.ui._bagware.parent != null)
            {
                Config.ui._bagware.close();
                if (Config.ui._bagUI.parent != null)
                {
                    Config.ui._bagUI.close();
                }
            }
            return;
        }// end function

        private function rumor(param1 = true)
        {
            this.clearTimer();
            var _loc_2:* = "";
            if (param1)
            {
                if (!this._rumorLock && _data.rumor != null)
                {
                    this._sayArr = _data.rumor.split(";");
                    if (this._talkMode == 0)
                    {
                        if (this._talkIndex >= this._sayArr.length)
                        {
                            this._talkIndex = 0;
                        }
                        _loc_2 = DescriptionTranslate.translate(this._sayArr[this._talkIndex]);
                    }
                    else
                    {
                        _loc_2 = DescriptionTranslate.translate(this._sayArr[Math.floor(Math.random() * this._sayArr.length)]);
                    }
                    if (this._talkTime != null && this._talkTime > 0)
                    {
                        say(_loc_2, _loc_2.length * 0.4);
                    }
                }
            }
            if (this._talkTime > 0)
            {
                this._rumorTimer = setTimeout(this.rumor, Math.floor((this._talkTime + _loc_2.length * 0.4) * 1000));
            }
            return;
        }// end function

        public function get npcid() : int
        {
            return _data.id;
        }// end function

        private function handleShop(param1)
        {
            _npcId = this.id;
            Config.ui._shopUI.open();
            Config.ui._dialogue.closedialogue();
            return;
        }// end function

        private function handlePortal(param1, param2:Array)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = undefined;
            _loc_4 = [];
            for (_loc_3 in Config._portalMap)
            {
                
                if (Number(Config._portalMap[_loc_3].portalId) == Number(_data.portalId))
                {
                    _loc_4.splice(0, 0, Config._portalMap[_loc_3]);
                    if (Number(_data.portalId) == 343)
                    {
                        if (GuideUI.testId(100))
                        {
                            _loc_5 = Config.ui._taskpanel.getTaskState(727);
                            if (_loc_5 == 0 || _loc_5 == 1)
                            {
                                GuideUI.doId(100);
                            }
                        }
                    }
                }
            }
            _loc_3 = 0;
            while (_loc_3 < _loc_4.length)
            {
                
                param2.splice(0, 0, {label:_loc_4[_loc_3].name, handler:Config.create(this.goportmap, _loc_4[_loc_3])});
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function autoPortal(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            for (_loc_2 in Config._portalMap)
            {
                
                if (Number(Config._portalMap[_loc_2].id) == param1)
                {
                    _loc_3 = Config._portalMap[_loc_2];
                }
            }
            if (_loc_3 != null)
            {
                return this.goportmap(null, _loc_3);
            }
            return false;
        }// end function

        private function goportmap(event:TextEvent = null, param2:Object = null) : Boolean
        {
            if (Config.player.money3 < param2.price)
            {
                Config.message(Config.language("Npc", 28));
                return false;
            }
            if (Config.player.level < param2.lv)
            {
                Config.message(Config.language("Npc", 29, param2.lv));
                return false;
            }
            if (param2.taskId > 0)
            {
                if (Config.ui._taskpanel.getTaskState(param2.taskId) != 3)
                {
                    Config.message(Config.language("Npc", 31, Config._taskMap[param2.taskId].name));
                    return false;
                }
            }
            if (param2.id == 10044)
            {
                if (Config.now.getDay() == 0 || Config.now.getDay() == 2 || Config.now.getDay() == 4 || Config.now.getDay() == 6)
                {
                    Config.message(Config.language("Npc", 33));
                    return false;
                }
            }
            if (param2.id == 10045)
            {
                if (Config.now.getDay() == 0 || Config.now.getDay() == 1 || Config.now.getDay() == 3 || Config.now.getDay() == 5)
                {
                    Config.message(Config.language("Npc", 34));
                    return false;
                }
            }
            trace("C2G_PLAYER_PORTOL", this.id, param2.id);
            var _loc_3:* = new DataSet();
            _loc_3.addHead(CONST_ENUM.C2G_PLAYER_PORTOL);
            _loc_3.add32(this.id);
            _loc_3.add32(param2.id);
            ClientSocket.send(_loc_3);
            Config.ui._dialogue.closedialogue();
            return true;
        }// end function

        public function taskshow(param1, param2:Object) : void
        {
            Config.ui._taskpanel.npctalk(this.npcid, int(param2.id), this.openMenu);
            return;
        }// end function

        private function handeproduce(param1) : void
        {
            Config.ui._producepanel.open();
            Config.ui._bagUI.open();
            Config.ui._dialogue.closedialogue();
            return;
        }// end function

        private function handware(param1) : void
        {
            Config.ui._bagware.npcid = _data.id;
            Config.ui._bagware.open();
            Config.ui._bagUI.open();
            Config.ui._dialogue.closedialogue();
            return;
        }// end function

        private function handwish(param1)
        {
            Config.ui._wishPool.clickAccept();
            Config.ui._dialogue.closedialogue();
            return;
        }// end function

        private function canceltask(param1) : void
        {
            this.openMenu();
            return;
        }// end function

        override function subDisplay(param1 = null)
        {
            super.subDisplay();
            if (this._effectOnly == 0)
            {
                if (Config.ui != null)
                {
                    if (Config.ui._radar != null)
                    {
                        if (_forceClip >= 0)
                        {
                            Config.ui._radar.addNpc(this);
                        }
                    }
                }
            }
            else
            {
                if (_img != null)
                {
                    _img.shadow = false;
                }
                _selectable = false;
                _walkBlock = false;
                _stateBar.visible = false;
            }
            if (_img != null)
            {
                _img.scaleX = 1;
                if (_data.face != null)
                {
                    _img.changeDirectionTo(_data.face);
                }
                if (_data.mirror != null)
                {
                    if (Number(_data.mirror) == 1)
                    {
                        _img.scaleX = -1;
                    }
                }
            }
            this.visible = true;
            return;
        }// end function

        override public function set visible(param1:Boolean)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = 0;
            if (_mc == null)
            {
                return;
            }
            if (param1)
            {
                if (_mc.parent == null)
                {
                    if (this._layer == 0)
                    {
                        _map._rootMap.addChild(_mc);
                    }
                    else if (this._layer == 1)
                    {
                        _map._textMap.addChild(_mc);
                        if (_currTile != null)
                        {
                            _currTile.removeUnit(this);
                        }
                    }
                    else
                    {
                        _map._footMap.addChild(_mc);
                        if (_currTile != null)
                        {
                            _currTile.removeUnit(this);
                        }
                    }
                }
                if (!_stateBar.visible)
                {
                    _stateBar.check();
                }
            }
            else
            {
                if (_mc.parent != null)
                {
                    _mc.parent.removeChild(_mc);
                }
                _stateBar.visible = false;
                _loc_2 = _enterframeListenerArray.concat();
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    stopLoop(_loc_2[_loc_3]);
                    _loc_3 = _loc_3 + 1;
                }
                if (EventMouse._hoverUnit == this)
                {
                    EventMouse._hoverUnit = null;
                }
                _map.removeHalo(this);
            }
            return;
        }// end function

        override public function destroy()
        {
            this._sky = false;
            if (this._bard)
            {
                _map.playMusic();
                this._nowMusic = "";
            }
            this.stopBard();
            if (Config.player != null)
            {
                Config.player.removeEventListener("move", this.handlePlayerMove);
                Config.player.removeEventListener("move", this.handlePlayerMoveBard);
            }
            this._bard = false;
            this._bardFlag = false;
            this._effectOnly = 0;
            delete _npcIdMap[Number(_data.id)];
            this.taskState = null;
            clearTimeout(this._say0Timer);
            this.mood = null;
            if (Config.ui != null)
            {
                if (Config.ui._radar != null)
                {
                    Config.ui._radar.removeNpc(this);
                }
            }
            this.clearTimer();
            this._rumorLock = null;
            this._sayArr = null;
            super.destroy();
            clearTimeout(this._pushPoolTimer);
            if (!this._poolPushed)
            {
                this._poolPushed = true;
                this._pushPoolTimer = setTimeout(this.pushPool, 1000);
            }
            return;
        }// end function

        private function pushPool()
        {
            clearTimeout(this._pushPoolTimer);
            _objectPool.push(this);
            return;
        }// end function

        public function interact(param1)
        {
            param1.target = this;
            return;
        }// end function

        private function handleActionEnd()
        {
            changeStateTo("idle");
            return;
        }// end function

        private function create(param1:Function, ... args) : Function
        {
            args = new activation;
            var F:Boolean;
            var f:* = param1;
            var arg:* = args;
            F;
            var _f:* = function (param1) : void
            {
                var _loc_2:* = arg;
                if (!F)
                {
                    F = true;
                    _loc_2.unshift(param1);
                }
                f.apply(null, _loc_2);
                return;
            }// end function
            ;
            return ;
        }// end function

        private function clearTimer()
        {
            clearTimeout(this._rumorTimer);
            clearTimeout(this._say0Timer);
            clearTimeout(this._bardSayTimer);
            clearTimeout(this._playTimer);
            return;
        }// end function

        public static function checkAll()
        {
            Config.startLoop(doCheckAll);
            return;
        }// end function

        private static function doCheckAll(param1)
        {
            var _loc_2:* = undefined;
            Config.stopLoop(doCheckAll);
            var _loc_3:* = 0;
            for (_loc_2 in Unit._unitStack[UNIT_TYPE_ENUM.TYPEID_NPC])
            {
                
                Unit._unitStack[UNIT_TYPE_ENUM.TYPEID_NPC][_loc_2].check();
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public static function twinNpc(param1, param2)
        {
            _idIndexMap[param1] = param2;
            return;
        }// end function

        public static function newNpc(param1, param2, param3, param4, param5)
        {
            var _loc_6:* = null;
            _idIndexMap[Number(param1.id)] = param5;
            _npcIdMap[Number(param1.id)] = param5;
            if (_objectPool.length == 0)
            {
                _loc_6 = new Npc(param1, param2, param3, param4, param5);
            }
            else
            {
                _loc_6 = _objectPool.shift();
                _loc_6._poolPushed = false;
                _loc_6._data = param1;
                _loc_6._oriData = param1;
                _loc_6._x = param2;
                _loc_6._y = param3;
                _loc_6._type = param4;
                _loc_6._id = param5;
                _loc_6._walkBlock = true;
                _loc_6._selectable = true;
                _loc_6._forceClip = 0;
                _loc_6._layer = Number(_loc_6._data.layer);
                _loc_6.visible = true;
                if (Unit._unitStack[_loc_6._type] == null)
                {
                    Unit._unitStack[_loc_6._type] = {};
                }
                Unit._unitStack[_loc_6._type][_loc_6._id] = _loc_6;
                _loc_6.baseData = param1;
                _loc_6.check();
                var _loc_8:* = _allCount + 1;
                _allCount = _loc_8;
            }
            taskChangeStatus(_loc_6);
            return _loc_6;
        }// end function

        private static function taskChangeStatus(param1:Npc) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            if (Config.ui == null)
            {
                return;
            }
            if (param1._effectOnly == 1)
            {
                return;
            }
            var _loc_2:* = Config.ui._taskpanel.tasklist();
            param1.taskState = 5;
            var _loc_6:* = {5:0, 0:1, 4:2, 1:3, 2:4};
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                if (_loc_2[_loc_3].state == 4)
                {
                    if (int(_loc_2[_loc_3].startnpc) == int(param1._data.id))
                    {
                        if (_loc_6[param1.taskState] < _loc_6[_loc_2[_loc_3].state])
                        {
                            param1.taskState = _loc_2[_loc_3].state;
                        }
                    }
                }
                else if (int(_loc_2[_loc_3].endnpc) == int(param1._data.id))
                {
                    if (_loc_6[param1.taskState] < _loc_6[_loc_2[_loc_3].state])
                    {
                        param1.taskState = _loc_2[_loc_3].state;
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public static function getNpcList(param1:Number)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = [];
            for (_loc_2 in Config._npcMap)
            {
                
                if (Number(Config._npcMap[_loc_2].finishTask) == param1)
                {
                    _loc_3.push(Number(Config._npcMap[_loc_2].id));
                }
            }
            return _loc_3;
        }// end function

        public static function findNpcId(param1)
        {
            return _npcIdMap[param1];
        }// end function

    }
}
