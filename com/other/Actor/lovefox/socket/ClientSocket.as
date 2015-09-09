package lovefox.socket
{
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import lovefox.unit.*;

    public class ClientSocket extends Socket
    {
        private var response:String;
        public static var _socket:ClientSocket;
        private static var _bInit:Boolean = false;
        private static var _msgLenMax:Object = 5000;
        private static var _headLen:Object = 4;
        private static var _isReadHead:Object = true;
        private static var _ip:Object;
        private static var _port:Object;
        private static var _bytes:ByteArray;
        private static var _pingInterval:int;
        private static var _ppTime:int = -1;
        public static var _preMoveTime:int = -1;
        private static var _pingTime:int = -1;
        private static var _prePingTime:Number = -1;
        private static var msgLen:Object;
        private static var cmd:Object;
        private static var compressed:Boolean = false;
        private static var _silent:Boolean = false;
        private static var _autoLoginTimer:Object;
        private static var _fbExitBuffObjectArray:Array = [];
        private static var _skyExitBuffObjectArray:Array = [];
        private static var bytesBuff:ByteArray;

        public function ClientSocket()
        {
            var _loc_1:* = undefined;
            return;
        }// end function

        public static function set silent(param1)
        {
            _silent = param1;
            return;
        }// end function

        public static function get silent()
        {
            return _silent;
        }// end function

        private static function ping()
        {
            clearTimeout(_pingInterval);
            if (_bInit)
            {
                if (_socket.connected)
                {
                    _socket.endian = Endian.BIG_ENDIAN;
                    _socket.writeShort(10);
                    _socket.endian = Endian.LITTLE_ENDIAN;
                    _socket.writeShort(CONST_ENUM.CMSG_PING);
                    _prePingTime = Config.time;
                    _socket.writeUnsignedInt(_prePingTime);
                    if (Config.ui != null)
                    {
                        Config.ui._radar.lag = _ppTime;
                    }
                    if (_ppTime == -1)
                    {
                        _socket.writeUnsignedInt(0);
                    }
                    else
                    {
                        _socket.writeUnsignedInt(_ppTime / 2);
                    }
                    _socket.flush();
                    _pingInterval = setTimeout(ping, 8000);
                }
            }
            return;
        }// end function

        public static function init() : void
        {
            if (_socket == null)
            {
                _socket = new ClientSocket;
                _socket.addEventListener(ProgressEvent.SOCKET_DATA, onServerData, false, 0, true);
                _socket.endian = Endian.LITTLE_ENDIAN;
                _socket.addEventListener(Event.CONNECT, OnConnect, false, 0, true);
                _socket.addEventListener(Event.CLOSE, OnClose, false, 0, true);
                _socket.addEventListener(IOErrorEvent.IO_ERROR, handleIO_ERROR, false, 0, true);
                _socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSECURITY_ERROR, false, 0, true);
                _bytes = new ByteArray();
                _bytes.endian = Endian.LITTLE_ENDIAN;
            }
            return;
        }// end function

        public static function connect(param1:String, param2:int) : void
        {
            trace("connect", param1, param2);
            _ip = param1;
            _port = param2;
            _socket.connect(param1, param2);
            _bInit = true;
            return;
        }// end function

        public static function close() : void
        {
            if (_bInit)
            {
                _socket.close();
                _socket.removeEventListener(ProgressEvent.SOCKET_DATA, onServerData);
                _socket.removeEventListener(Event.CONNECT, OnConnect);
                _socket.removeEventListener(Event.CLOSE, OnClose);
                _socket.removeEventListener(IOErrorEvent.IO_ERROR, handleIO_ERROR);
                _socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleSECURITY_ERROR);
                _socket = null;
                _bytes = null;
                _bInit = false;
            }
            return;
        }// end function

        private static function handleIO_ERROR(event:IOErrorEvent)
        {
            AlertUI.alert(Config.language("ClientSocket", 1), Config.language("ClientSocket", 2), [Config.language("ClientSocket", 3)]);
            return;
        }// end function

        private static function reconnect(param1)
        {
            if (_bInit)
            {
                _socket.connect(_ip, _port);
            }
            return;
        }// end function

        private static function handleSECURITY_ERROR(event:SecurityErrorEvent)
        {
            if (Config.loginCharIdCookie == null)
            {
                AlertUI.alert(Config.language("ClientSocket", 4), Config.language("ClientSocket", 5), [Config.language("ClientSocket", 6)]);
            }
            else
            {
                AlertUI.alert(Config.language("ClientSocket", 4), Config.language("ClientSocket", 7), [Config.language("ClientSocket", 8)], [autoLoginCancel1], null, false, true, true);
                clearTimeout(_autoLoginTimer);
                _autoLoginTimer = setTimeout(autoLoginLoop1, 1000, 29);
            }
            return;
        }// end function

        private static function autoLoginCancel1(param1)
        {
            Config.loginCharIdCookie = null;
            AlertUI.alert(Config.language("ClientSocket", 4), Config.language("ClientSocket", 5), [Config.language("ClientSocket", 6)]);
            clearTimeout(_autoLoginTimer);
            return;
        }// end function

        private static function autoLoginLoop1(param1)
        {
            var sec:* = param1;
            clearTimeout(_autoLoginTimer);
            AlertUI.msg = Config.language("ClientSocket", 9, sec);
            if (sec > 0)
            {
                _autoLoginTimer = setTimeout(autoLoginLoop1, 1000, (sec - 1));
            }
            else
            {
                try
                {
                    ExternalInterface.call("eval", "location.reload();");
                }
                catch (e)
                {
                }
            }
            return;
        }// end function

        public static function send(param1:DataSet) : void
        {
            var _loc_2:* = undefined;
            if (!_silent && _bInit)
            {
                if (_socket.connected)
                {
                    _loc_2 = param1.output();
                    _socket.writeBytes(_loc_2, 0, _loc_2.length);
                    _socket.flush();
                }
            }
            return;
        }// end function

        private static function onServerData(event:ProgressEvent) : void
        {
            parseNetData();
            return;
        }// end function

        private static function parseNetData() : void
        {
            if (_isReadHead)
            {
                if (_socket.bytesAvailable >= _headLen)
                {
                    _socket.endian = Endian.BIG_ENDIAN;
                    msgLen = _socket.readUnsignedShort() - 2;
                    _socket.endian = Endian.LITTLE_ENDIAN;
                    cmd = _socket.readUnsignedShort();
                    if (cmd >>> 15 == 1)
                    {
                        compressed = true;
                    }
                    else
                    {
                        compressed = false;
                    }
                    cmd = cmd & 32767;
                    if (msgLen == 0)
                    {
                        return;
                    }
                    _isReadHead = false;
                }
            }
            else
            {
                trace("Error state!");
            }
            if (!_isReadHead && msgLen <= _socket.bytesAvailable)
            {
                if (msgLen == 0)
                {
                    return;
                }
                if (_socket.bytesAvailable >= msgLen)
                {
                    _bytes.position = 0;
                    _socket.readBytes(_bytes, 0, msgLen);
                    if (Recorder.recording)
                    {
                        bytesBuff = new ByteArray();
                        bytesBuff.endian = Endian.LITTLE_ENDIAN;
                        bytesBuff.writeShort(cmd);
                        bytesBuff.writeBytes(_bytes, 0, msgLen);
                        bytesBuff.position = 0;
                    }
                    if (compressed)
                    {
                        _bytes.uncompress();
                    }
                    doSocket();
                }
            }
            else
            {
                trace("data len not enough,rcv next data!");
                return;
            }
            _isReadHead = true;
            if (_socket.bytesAvailable >= _headLen)
            {
                parseNetData();
            }
            return;
        }// end function

        private static function doSocket()
        {
            var i:*;
            var j:*;
            var k:*;
            var l:*;
            var speed:*;
            var unit:*;
            var unit1:*;
            var char_id:*;
            var type_id:*;
            var catalog_id:*;
            var time:*;
            var x:*;
            var y:*;
            var angle:*;
            var name:*;
            var attacker_id:*;
            var attacker_type:*;
            var target_id:*;
            var target_type:*;
            var attack_rs:*;
            var temp:*;
            var chat:*;
            var title_id:*;
            var sex:*;
            var job_id:*;
            var level:*;
            var hp:*;
            var hpMax:*;
            var mp:*;
            var mpMax:*;
            var item_id:*;
            var skill_id:*;
            var skill_type:*;
            var skill_rs:*;
            var skill_instance_id:*;
            var skill_instance:*;
            var temp1:*;
            var temp2:*;
            var temp3:*;
            var temp4:*;
            var temp5:*;
            var temp6:*;
            var temp7:*;
            var temp8:*;
            var temp9:*;
            var temp10:*;
            var temp11:*;
            var temp12:*;
            var temp13:*;
            var temp14:*;
            var temp15:*;
            var temp16:*;
            var temp17:*;
            var temp18:*;
            var temp19:*;
            var temp20:*;
            var temp21:*;
            var temp22:*;
            var temp23:*;
            var temp24:*;
            var temp25:*;
            var temp26:*;
            var temp27:*;
            var temp28:*;
            var temp29:*;
            var temp30:*;
            var lineid:int;
            var linenum:int;
            var followerID:int;
            var allexp:int;
            var addexp:int;
            var str:String;
            var _mflag:int;
            var cesStr:String;
            var lghtnStrstart:int;
            var lghtnStr:String;
            var lghtnColor:int;
            var elem4:int;
            var elem5:int;
            var itemID:int;
            var item:Item;
            var pickerr:int;
            var pickBigError:Boolean;
            var tlkArr:Array;
            var count:int;
            var playerlist:Object;
            var playerid:int;
            var flagnum:int;
            var num:int;
            var errCode:int;
            var strlen:int;
            var errMsg:String;
            var npcID:int;
            var doorNPC:Unit;
            var playerID:int;
            var followID:int;
            switch(cmd)
            {
                case CONST_ENUM.SMSG_LOGOUT:
                {
                    temp1 = _bytes.readUnsignedShort();
                    Config.normalQuit = true;
                    break;
                }
                case CONST_ENUM.SMSG_RESULT:
                {
                    temp1 = _bytes.readUnsignedShort();
                    temp2 = _bytes.readUnsignedShort();
                    try
                    {
                        ErrorCode.groupError(temp1, temp2);
                    }
                    catch (e)
                    {
                    }
                    break;
                }
                case CONST_ENUM.G2C_MAP_ENTER:
                {
                    Recorder.pushAction(bytesBuff);
                    Config.ui._radar.clearchangeline();
                    temp2 = _bytes.readUnsignedInt();
                    if (Config.player != null)
                    {
                        Config.player.actionLock = false;
                        Config.player.thinkLock = false;
                        Config.player.confirmPosition(true);
                        Config.player.clearEnterMap();
                        if (temp2 > 1000000000)
                        {
                            Config.ui._radar._fbUI.handleEnter();
                        }
                        else if (temp2 >= 901 && temp2 <= 905)
                        {
                            Config.ui._interBigwar.starttimer();
                        }
                        else
                        {
                            Config.ui._radar._fbUI.handleLeave();
                        }
                    }
                    Config.main.enterMapId(temp2);
                    lineid = _bytes.readUnsignedByte();
                    linenum = _bytes.readUnsignedByte();
                    Config.ui._radar.linenum(linenum, lineid);
                    Config.ui._teamUI.teamoutlen(Config.player.id);
                    temp5 = _bytes.readUnsignedShort();
                    temp6 = _bytes.readUnsignedShort();
                    temp7 = Config.map.tileToMap({_x:temp5, _y:temp6});
                    Player._playerX = temp7._x;
                    Player._playerY = temp7._y;
                    Config.serverID = _bytes.readUnsignedByte();
                    break;
                }
                case CONST_ENUM.G2C_ROLE_ADD:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedShort();
                    temp3 = _bytes.readUnsignedShort();
                    temp4 = getAppear(_bytes);
                    temp10 = getStandStill(_bytes);
                    temp11 = getWalk(_bytes);
                    followerID = _bytes.readUnsignedInt();
                    temp9 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp1);
                    temp5 = Config.map.tileToMap({_x:temp2, _y:temp3});
                    if (temp9 == null)
                    {
                        if (Player._playerId != temp1)
                        {
                            temp9 = Dummy.newDummy(Config._charactorMap[temp4.job + (temp4.sex - 1) * 12], temp5._x, temp5._y, UNIT_TYPE_ENUM.TYPEID_PLAYER, temp1);
                            temp9.display(Config.map);
                        }
                        else
                        {
                            temp9 = Config.player;
                            temp9.unLockMove();
                        }
                        Unit(temp9)._stateBar.checkFlag();
                        Unit(temp9)._stateBar.checkWinflag();
                    }
                    else
                    {
                        temp9.forcePosition(temp5);
                    }
                    if (followerID != 0)
                    {
                        Unit(temp9).setFollower(followerID);
                    }
                    temp9.angle = temp11.angle;
                    temp9._legalPt = {_x:temp2, _y:temp3};
                    temp9.name = temp4.name;
                    temp9.titleId = temp4.titleId;
                    temp9.job = temp4.job;
                    temp9.sex = temp4.sex;
                    temp9.level = temp4.level;
                    temp9.fighting = temp4.fighting;
                    temp9.speed = temp4.speed;
                    temp9.hpMax = temp4.hpMax;
                    temp9.hp = temp4.hp;
                    temp9.mpMax = temp4.mpMax;
                    temp9.mp = temp4.mp;
                    temp9.pkState = temp4.pkmode;
                    temp9.weaponId = temp4.weaponId;
                    temp9.setWeaponElement(temp4.elementID, temp4.elementLevel);
                    temp9.clothId = temp4.clothId;
                    temp9.horseId = {id:temp4.horseId, star:temp4.horseStar};
                    temp9.wingId = {id:temp4.wingId, star:temp4.wingStar};
                    temp9.forceClip = temp4.avatarId;
                    temp9.forceHue = temp4.avatarColor;
                    temp9.hairId = temp4.hair;
                    temp9.setgildinfor(temp4.guildId, temp4.guildName, temp4.guildPower, temp4.camp, temp4.gildTeam);
                    temp9.gildid = temp4.guildId;
                    if (Config.map._type == 21)
                    {
                        temp9.LandLife = temp4.warTeam;
                    }
                    else
                    {
                        temp9.warTeam = temp4.warTeam;
                        temp9.LandLife = 0;
                    }
                    if (temp4.death == 1 && temp9 != Config.player)
                    {
                        temp9.dying();
                    }
                    temp9.boothAd = temp4.boothNote;
                    if (temp4.booth == 0)
                    {
                        temp9.boothing = false;
                    }
                    else if (temp4.booth == 1)
                    {
                        temp9.boothing = true;
                    }
                    if (temp9 == Config.player)
                    {
                        Config.ui._pkmode.combattype = temp9.pkState;
                    }
                    if (Config.ui != null)
                    {
                        Config.ui._teamUI.teamlen(temp1, true);
                        Config.ui._teamUI.leaderFlag(temp1, temp4.isTeamLeader);
                        Config.ui._teamUI.teamMemberInit(temp1, temp9.hp, temp9.hpMax, temp9.mp, temp9.mpMax, temp9.level);
                    }
                    if (temp10.standStillType == 1)
                    {
                        temp9.startGather(temp10.standStillTimeLeft * 1000, temp10.standStillPeriod * 1000, temp10.standStillType);
                    }
                    else if (temp10.standStillType == 2)
                    {
                        temp9.startGather(temp10.standStillTimeLeft * 1000, temp10.standStillPeriod * 1000, temp10.standStillType);
                    }
                    else if (temp10.standStillType == 3)
                    {
                        temp9.startGather(temp10.standStillTimeLeft * 1000, temp10.standStillPeriod * 1000, temp10.standStillType);
                    }
                    else if (temp10.standStillType == 4)
                    {
                        temp9.resting = true;
                    }
                    if (Player._playerId != temp1)
                    {
                        if (temp11.walkFlag == 1)
                        {
                            temp9.go({_x:temp11.x, _y:temp11.y}, temp11.angle, {_x:temp11.desX, _y:temp11.desY});
                        }
                    }
                    Config.ui._yabiao.setYbiaoName();
                    Config.ui._landGravePanel.setLandWarName();
                    break;
                }
                case CONST_ENUM.G2C_ROLE_REMOVE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp1);
                    if (temp2 != null)
                    {
                        temp2.destroy();
                        if (Config.ui != null)
                        {
                            Config.ui._teamUI.teamlen(temp1, false);
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_OBJECT_ADD:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedByte();
                    temp12 = _bytes.readUnsignedByte();
                    temp10 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedByte();
                    temp4 = _bytes.readUnsignedByte();
                    temp21 = _bytes.readUnsignedInt();
                    temp22 = _bytes.readUnsignedInt();
                    if (temp2 == 1)
                    {
                        temp20 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp1);
                        temp19 = Config.map.tileToMap({_x:temp3, _y:temp4});
                        if (temp20 == null)
                        {
                            temp20 = Dummy.newDummy(Config._monsterMap[temp10], temp19._x, temp19._y, UNIT_TYPE_ENUM.TYPEID_UNIT, temp1);
                            temp20.display(Config.map);
                        }
                        else
                        {
                            Dummy(temp20)._die = false;
                            Dummy(temp20)._dying = false;
                            temp20.forcePosition(temp19);
                        }
                        temp5 = _bytes.readUnsignedInt();
                        temp6 = _bytes.readUnsignedInt();
                        temp7 = _bytes.readUnsignedInt();
                        temp8 = _bytes.readUnsignedInt();
                        temp9 = _bytes.readUnsignedByte();
                        temp11 = _bytes.readUnsignedInt();
                        temp20.name = temp20._data.name;
                        temp20.title = temp20._data.title;
                        temp13 = getWalk(_bytes);
                        temp14 = _bytes.readUnsignedInt();
                        temp15 = _bytes.readUnsignedInt();
                        if (temp20 != null)
                        {
                            temp20.angle = temp13.angle;
                            temp20.hpMax = temp6;
                            temp20.hp = temp5;
                            temp20.mpMax = temp8;
                            temp20.mp = temp7;
                            temp20.level = temp9;
                            temp20.speed = temp11;
                            if (temp13.walkFlag == 1)
                            {
                                temp20.go({_x:temp13.x, _y:temp13.y}, temp13.angle, {_x:temp13.desX, _y:temp13.desY});
                            }
                            temp20.belongPlayer = temp14;
                            temp20.belongTeam = temp15;
                            temp20.monsterCamp = temp21;
                            temp20.gildid = temp22;
                        }
                    }
                    else if (temp2 == 2)
                    {
                        temp5 = _bytes.readUnsignedByte();
                        temp6 = _bytes.readFloat();
                        temp7 = _bytes.readUnsignedInt();
                        temp8 = _bytes.readUnsignedByte();
                        temp9 = _bytes.readUnsignedByte();
                        if (temp12 == 1)
                        {
                            if (temp9 == 1)
                            {
                                Npc.twinNpc(temp10, temp1);
                            }
                            else
                            {
                                temp20 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, temp1);
                                temp19 = Config.map.tileToMap({_x:temp3, _y:temp4});
                                if (temp20 == null)
                                {
                                    temp20 = Npc.newNpc(Config._npcMap[temp10], temp19._x, temp19._y, UNIT_TYPE_ENUM.TYPEID_NPC, temp1);
                                    temp20.display(Config.map);
                                }
                                else
                                {
                                    temp20.forcePosition(temp19);
                                }
                            }
                            Config.ui._landGravePanel.setnewFreshLand();
                        }
                        else if (temp12 == 2)
                        {
                            temp20 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_GATHER, temp1);
                            temp19 = Config.map.tileToMap({_x:temp3, _y:temp4});
                            if (temp20 == null)
                            {
                                temp20 = Gather.newGather(Config._gatherMap[temp10], temp19._x, temp19._y, UNIT_TYPE_ENUM.TYPEID_GATHER, temp1);
                                trace(temp20.id, temp1);
                                temp20.display(Config.map);
                            }
                            else
                            {
                                temp20.forcePosition(temp19);
                            }
                            if (Number(temp20._data.fire) == 1)
                            {
                                if (GuideUI.testId(134))
                                {
                                    if (Config.player != null && Config.player.testDistance(temp20) < 300)
                                    {
                                        GuideUI.doId(134, temp20);
                                    }
                                }
                            }
                            if (temp5 == 0)
                            {
                                temp20.canGather = true;
                            }
                            else
                            {
                                temp20.canGather = false;
                            }
                        }
                        else if (temp12 == 3)
                        {
                        }
                        else if (temp12 == 4)
                        {
                        }
                        else if (temp12 == 5)
                        {
                        }
                        else if (temp12 == 6)
                        {
                            temp19 = Config.map.tileToMap({_x:temp3, _y:temp4});
                            temp20 = Item.newItem(Config._itemMap[temp10], temp19._x, temp19._y, UNIT_TYPE_ENUM.TYPEID_ITEM_MAP, temp1);
                            temp20.display(Config.map);
                            if (temp10 == 91001 || temp10 == 91002 || temp10 == 91003)
                            {
                                GuideUI.testDoId(126);
                            }
                        }
                        else if (temp12 == 7)
                        {
                            temp19 = Config.map.tileToMap({_x:temp3, _y:temp4});
                            temp18 = Config._skillMap[temp10];
                            if (Number(temp18.flyEffectId) != 0)
                            {
                                if (String(temp18.flyEffectId).indexOf("_") == -1)
                                {
                                    temp20 = FlyProp.newFlyProp(UNIT_TYPE_ENUM.TYPEID_FLY, temp1, Config._model[temp18.flyEffectId], temp19._x, temp19._y, temp6, temp7);
                                }
                                else
                                {
                                    temp23 = String(temp18.flyEffectId).split("_");
                                    temp20 = FlyProp.newFlyProp(UNIT_TYPE_ENUM.TYPEID_FLY, temp1, Config._model[Number(temp23[0])], temp19._x, temp19._y, temp6, temp7, null, Number(temp23[1]));
                                }
                                temp20.display(Config.map);
                                temp20.launch();
                            }
                            else
                            {
                                temp20 = FlyProp.newFlyProp(UNIT_TYPE_ENUM.TYPEID_FLY, temp1, null, temp19._x, temp19._y, temp6, temp7);
                            }
                        }
                        else if (temp12 == 9)
                        {
                            addFbExit(temp1, temp3, temp4);
                        }
                        else if (temp12 == 11)
                        {
                            temp19 = Config.map.tileToMap({_x:temp3, _y:temp4});
                            temp20 = Door.newDoor(temp10, temp19._x, temp19._y, UNIT_TYPE_ENUM.TYPEID_DOOR, temp1);
                            if (temp8 == 0)
                            {
                                temp20.opening = true;
                            }
                            else
                            {
                                temp20.opening = false;
                            }
                            temp20.display(Config.map);
                        }
                        else if (temp12 == 13)
                        {
                            addSkyExit(temp1, temp3, temp4);
                        }
                    }
                    if (temp20 is Unit)
                    {
                        temp20.gildid = temp22;
                        temp20.LandLife = 0;
                    }
                    break;
                }
                case CONST_ENUM.G2C_OBJECT_REMOVE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedByte();
                    temp3 = _bytes.readUnsignedByte();
                    if (temp2 == 1)
                    {
                        temp3 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp1);
                        if (temp3 != null)
                        {
                            if (!temp3._dying)
                            {
                                temp3.destroy();
                            }
                        }
                    }
                    else if (temp3 == 1)
                    {
                        temp20 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, temp1);
                        if (temp20 != null)
                        {
                            temp20.destroy();
                        }
                    }
                    else if (temp3 == 2)
                    {
                        temp20 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_GATHER, temp1);
                        if (temp20 != null)
                        {
                            temp20.destroy();
                        }
                    }
                    else if (temp3 == 3)
                    {
                        delete Config.eventStack[temp3 + "_" + temp4];
                    }
                    else if (temp3 == 4)
                    {
                    }
                    else if (temp3 == 5)
                    {
                    }
                    else if (temp3 == 6)
                    {
                        temp4 = Item.getItem(UNIT_TYPE_ENUM.TYPEID_ITEM_MAP, temp1);
                        if (temp4 != null)
                        {
                            temp4.destroy();
                        }
                    }
                    else if (temp3 == 7)
                    {
                        temp4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_FLY, temp1);
                        if (temp4 != null)
                        {
                            temp4.over();
                        }
                    }
                    else if (temp3 == 9)
                    {
                        delete Config.eventStack[temp3 + "_" + temp4];
                        delete Config.eventStack[(temp3 - 1) + "_" + (temp4 - 1)];
                        delete Config.eventStack[(temp3 - 1) + "_" + temp4];
                        delete Config.eventStack[(temp3 - 1) + "_" + (temp4 + 1)];
                        delete Config.eventStack[temp3 + "_" + (temp4 - 1)];
                        delete Config.eventStack[temp3 + "_" + (temp4 + 1)];
                        delete Config.eventStack[(temp3 + 1) + "_" + (temp4 - 1)];
                        delete Config.eventStack[(temp3 + 1) + "_" + temp4];
                        delete Config.eventStack[(temp3 + 1) + "_" + (temp4 + 1)];
                    }
                    else if (temp3 == 11)
                    {
                        temp4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_DOOR, temp1);
                        if (temp4 != null)
                        {
                            temp4.destroy();
                        }
                    }
                    else if (temp12 == 13)
                    {
                        if (Npc._skyNpcStack[temp3 + "_" + temp4] != null)
                        {
                            Npc._skyNpcStack[temp3 + "_" + temp4].destroy();
                            delete Npc._skyNpcStack[temp3 + "_" + temp4];
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_OBJECT_DESTRORY:
                {
                    Recorder.pushAction(bytesBuff);
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp2);
                    if (temp3 != null)
                    {
                        if (Config.player != null && Config.player.target == temp3)
                        {
                            Bard.killMon(temp3._data.id);
                        }
                        temp3.dying();
                    }
                    break;
                }
                case CONST_ENUM.G2C_CHANGE_LOCATION:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedByte();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedShort();
                    temp4 = _bytes.readUnsignedShort();
                    unit = Unit.getUnit(temp1, temp2);
                    if (unit != null)
                    {
                        temp5 = Config.map.tileToMap({_x:temp3, _y:temp4});
                        unit.forcePosition(temp5);
                        if (Config.player == unit)
                        {
                            Config.player.actionLock = false;
                            Config.player.thinkLock = false;
                            Config.player.stop(true, true);
                            Config.player.confirmPosition(true);
                            Config.player.think();
                        }
                    }
                    break;
                }
                case CONST_ENUM.SMSG_MOVE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = _bytes.readUnsignedShort();
                    temp5 = _bytes.readUnsignedShort();
                    temp6 = _bytes.readFloat();
                    temp7 = _bytes.readUnsignedShort();
                    temp8 = _bytes.readUnsignedShort();
                    if (Player._playerId != temp2)
                    {
                        unit = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp2);
                        if (unit != null)
                        {
                            unit.go({_x:temp4, _y:temp5}, temp6, {_x:temp7, _y:temp8});
                        }
                    }
                    else if (Config.player != null)
                    {
                        if (Config.player._binding == 1)
                        {
                            Config.player.dummyGo({_x:temp4, _y:temp5}, temp6, {_x:temp7, _y:temp8});
                        }
                    }
                    break;
                }
                case CONST_ENUM.SMSG_STOP:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = _bytes.readUnsignedShort();
                    temp5 = _bytes.readUnsignedShort();
                    temp6 = _bytes.readFloat();
                    if (temp1 != UNIT_TYPE_ENUM.TYPEID_PLAYER || Player._playerId != temp2)
                    {
                        unit = Unit.getUnit(temp1, temp2);
                        if (unit != null)
                        {
                            unit._legalAngle = temp6;
                            unit._legalPt = {_x:temp4, _y:temp5};
                            unit.stop({_x:temp4, _y:temp5}, temp6);
                        }
                    }
                    else if (temp1 == UNIT_TYPE_ENUM.TYPEID_PLAYER && Player._playerId == temp2)
                    {
                        if (Config.player != null)
                        {
                            if (Config.player._binding == 1)
                            {
                                Config.player.dummyStop({_x:temp4, _y:temp5}, temp6);
                            }
                            else
                            {
                                Config.player._legalAngle = temp6;
                                Config.player._legalPt = {_x:temp4, _y:temp5};
                                if (!Config.player._moveFlag)
                                {
                                }
                            }
                        }
                    }
                    break;
                }
                case CONST_ENUM.SMSG_MOVE_ERROR:
                {
                    temp1 = _bytes.readUnsignedShort();
                    temp2 = _bytes.readUnsignedShort();
                    temp3 = _bytes.readFloat();
                    temp4 = _bytes.readUnsignedByte();
                    trace("SMSG_MOVE_ERROR", temp4, temp1, temp2);
                    if (Config.debug)
                    {
                        Config.ui._chatUI.showSys("SMSG_MOVE_ERROR:" + temp4);
                    }
                    if (Config.player != null)
                    {
                        Config.player._legalAngle = temp3;
                        Config.player._legalPt = {_x:temp1, _y:temp2};
                        Config.player.fixPosition(Config.player._legalPt);
                    }
                    break;
                }
                case CONST_ENUM.SMSG_MOVE_CORRECT:
                {
                    temp1 = _bytes.readUnsignedShort();
                    temp2 = _bytes.readUnsignedShort();
                    temp3 = _bytes.readFloat();
                    if (Config.player != null)
                    {
                        Config.player._legalAngle = temp3;
                        Config.player._legalPt = {_x:temp1, _y:temp2};
                        Config.player.confirmPosition();
                    }
                    break;
                }
                case CONST_ENUM.G2C_MONSTER_MOVE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = _bytes.readUnsignedShort();
                    temp5 = _bytes.readUnsignedShort();
                    temp6 = _bytes.readFloat();
                    temp7 = _bytes.readUnsignedShort();
                    temp8 = _bytes.readUnsignedShort();
                    unit = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp2);
                    if (unit != null)
                    {
                        unit._legalAngle = temp6;
                        unit._legalPt = {_x:temp4, _y:temp5};
                        unit.go({_x:temp4, _y:temp5}, temp6, {_x:temp7, _y:temp8});
                    }
                    break;
                }
                case CONST_ENUM.G2C_MONSTER_STOP:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = _bytes.readUnsignedShort();
                    temp5 = _bytes.readUnsignedShort();
                    temp6 = _bytes.readFloat();
                    unit = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp2);
                    if (unit != null)
                    {
                        unit._legalAngle = temp6;
                        unit._legalPt = {_x:temp4, _y:temp5};
                        unit.stop({_x:temp4, _y:temp5}, temp6);
                    }
                    break;
                }
                case CONST_ENUM.G2C_JUMP:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedByte();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = _bytes.readUnsignedByte();
                    temp5 = _bytes.readUnsignedByte();
                    temp6 = _bytes.readFloat();
                    temp7 = _bytes.readUnsignedByte();
                    unit = Unit.getUnit(temp1, temp2);
                    if (unit != null)
                    {
                        temp10 = Config.map.tileToMap({_x:temp4, _y:temp5});
                        if (Config.player == unit)
                        {
                            Config.player._legalAngle = temp3;
                            Config.player._legalPt = temp10;
                        }
                        if (temp7 == 10)
                        {
                            UnitEffect.flash(unit);
                            unit.addEffect("1042");
                            unit.forcePosition(temp10);
                            if (unit == Config.player)
                            {
                                unit.think();
                            }
                        }
                        else
                        {
                            unit.slip(temp10, temp6);
                        }
                        unit.directTo(temp6);
                    }
                    break;
                }
                case CONST_ENUM.G2C_ATTACK_ID:
                {
                    temp1 = _bytes.readUnsignedInt();
                    Player._playerAttackMode = Config._skillMap[temp1];
                    if (Config.player != null)
                    {
                        Config.player.attackMode = Config._skillMap[temp1];
                    }
                    break;
                }
                case CONST_ENUM.G2C_EQUIP_CHANGE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedShort();
                    temp4 = _bytes.readUnsignedInt();
                    temp6 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp1);
                    if (temp6 != null)
                    {
                        if (temp2 == 1001)
                        {
                            temp6.weaponId = temp4;
                        }
                        else if (temp2 == 1011)
                        {
                            temp6.clothId = temp4;
                        }
                        else if (temp2 == 1012)
                        {
                            temp7 = _bytes.readUnsignedByte();
                            temp6.horseId = {id:temp4, star:temp7};
                        }
                        else if (temp2 == 1013)
                        {
                        }
                        else if (temp2 == 1014)
                        {
                            temp7 = _bytes.readUnsignedByte();
                            temp6.wingId = {id:temp4, star:temp7};
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_CAN_GATHER:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readShort();
                    temp3 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_GATHER, temp1);
                    if (temp3 != null)
                    {
                        if (temp2 == 0)
                        {
                            temp3.canGather = true;
                        }
                        else
                        {
                            temp3.canGather = false;
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_CAN_GATHER:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readShort();
                    temp3 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_GATHER, temp1);
                    if (temp3 != null)
                    {
                        if (temp2 == 0)
                        {
                            temp3.canGather = true;
                        }
                        else
                        {
                            temp3.canGather = false;
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_GET_EXP:
                {
                    allexp = _bytes.readUnsignedInt();
                    addexp = _bytes.readUnsignedInt();
                    str;
                    if (addexp > 0)
                    {
                        str = Config.language("ClientSocket", 11) + int(allexp - addexp) + Config.language("ClientSocket", 12) + addexp;
                    }
                    else
                    {
                        str = Config.language("ClientSocket", 11) + int(allexp);
                    }
                    BubbleUI.bubble(str, 16776960);
                    Config.addHistory(str);
                    break;
                }
                case CONST_ENUM.G2C_ATTACK_OBJ:
                {
                    attacker_type = _bytes.readUnsignedByte();
                    attacker_id = _bytes.readUnsignedInt();
                    target_type = _bytes.readUnsignedByte();
                    target_id = _bytes.readUnsignedInt();
                    attack_rs = _bytes.readUnsignedByte();
                    if (attack_rs == SKILL_RS_ENUM.SKILL_DISTANCE_TOO_LENGTH || attack_rs == SKILL_RS_ENUM.SKILL_ERROR_DEST_NULL || attack_rs == SKILL_RS_ENUM.SKILL_BLOCK)
                    {
                        if (Config.debug)
                        {
                            Config.message("G2C_ATTACK_OBJ:" + attack_rs);
                        }
                        unit = Unit.getUnit(attacker_type, attacker_id);
                        if (unit != null)
                        {
                            if (unit == Config.player)
                            {
                                if (Hang.hanging)
                                {
                                    unit1 = Unit.getUnit(target_type, target_id);
                                    if (unit1 != null && unit1 is Dummy)
                                    {
                                        if (unit1.hangErrorCount >= 3)
                                        {
                                            unit1.hangError = true;
                                            if (Hang.currTarget == unit.target)
                                            {
                                                unit.target = null;
                                                Hang.currTarget = null;
                                            }
                                            Hang.think();
                                        }
                                        else
                                        {
                                            var _loc_2:* = unit1;
                                            var _loc_3:* = unit1.hangErrorCount + 1;
                                            _loc_2.hangErrorCount = _loc_3;
                                        }
                                    }
                                }
                                else
                                {
                                    unit.think();
                                }
                            }
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_OBJECT_UPDATE:
                {
                    char_id = _bytes.readUnsignedInt();
                    type_id = _bytes.readUnsignedByte();
                    temp1 = _bytes.readUnsignedShort();
                    if (type_id == 0 || type_id == 1)
                    {
                        unit = Unit.getUnit(type_id, char_id);
                    }
                    else
                    {
                        unit = Unit.getGameObject(char_id);
                    }
                    temp2;
                    while (temp2 < temp1)
                    {
                        
                        temp3 = _bytes.readUnsignedShort();
                        temp4 = _bytes.readUnsignedByte();
                        if (temp4 == 0)
                        {
                            temp6 = _bytes.readInt();
                        }
                        else if (temp4 == 4)
                        {
                            temp6 = _bytes.readUnsignedByte();
                        }
                        else if (temp4 == 5)
                        {
                            temp6 = _bytes.readUnsignedShort();
                        }
                        else
                        {
                            temp6 = _bytes.readUnsignedInt();
                        }
                        if (unit != null)
                        {
                            objectUpdate(unit, temp3, temp6, bytesBuff);
                        }
                        temp2 = (temp2 + 1);
                    }
                    break;
                }
                case CONST_ENUM.SMSG_OBJECT_TYPE_CHANGE:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = Unit.getUnit(temp1, temp2);
                    if (temp4 != null)
                    {
                        if (temp4.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                        {
                            temp4.baseData = Config._monsterMap[temp3];
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_OBJECT_CHANG_ENTRY:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    if (temp1 == 0)
                    {
                        temp4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp2);
                    }
                    else if (temp1 == 1)
                    {
                        temp4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp2);
                    }
                    else if (temp1 == 2)
                    {
                        temp4 = Unit.getGameObject(temp2);
                    }
                    if (temp4 != null)
                    {
                        if (temp4.type == UNIT_TYPE_ENUM.TYPEID_PLAYER)
                        {
                            temp4.baseData = Config._monsterMap[temp3];
                        }
                        else if (temp4.type == UNIT_TYPE_ENUM.TYPEID_UNIT)
                        {
                            temp4.baseData = Config._monsterMap[temp3];
                        }
                        else if (temp4.type == UNIT_TYPE_ENUM.TYPEID_NPC)
                        {
                            temp4.baseData = Config._npcMap[temp3];
                        }
                        else if (temp4.type == UNIT_TYPE_ENUM.TYPEID_GATHER)
                        {
                            temp4.baseData = Config._gatherMap[temp3];
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_SKILL_POWER_COUNT:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    Skill.chantLevel = temp2;
                    break;
                }
                case CONST_ENUM.G2C_SKILL_CAST_ERROR:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedByte();
                    if (temp2 == SKILL_RS_ENUM.SKILL_DISTANCE_TOO_LENGTH || temp2 == SKILL_RS_ENUM.SKILL_ERROR_DEST_NULL || temp2 == SKILL_RS_ENUM.SKILL_BLOCK)
                    {
                        if (Config.debug)
                        {
                            Config.message("G2C_SKILL_CAST_ERROR:" + temp2);
                        }
                        if (temp2 == 21)
                        {
                            Config.message(Config.language("ClientSocket", 13));
                        }
                        Skill.selectedSkill = null;
                        unit = Config.player;
                        if (Hang.hanging)
                        {
                            unit1 = unit.target;
                            if (unit1 != null && unit1 is Dummy)
                            {
                                trace("hangError4");
                                if (unit1.hangErrorCount >= 3)
                                {
                                    unit1.hangError = true;
                                    if (Hang.currTarget == unit.target)
                                    {
                                        unit.target = null;
                                        Hang.currTarget = null;
                                    }
                                    Hang.think();
                                }
                                else
                                {
                                    var _loc_2:* = unit1;
                                    var _loc_3:* = unit1.hangErrorCount + 1;
                                    _loc_2.hangErrorCount = _loc_3;
                                }
                            }
                        }
                        else
                        {
                            unit.think();
                        }
                    }
                    else
                    {
                        if (temp2 == SKILL_RS_ENUM.SKILL_NO_SKILL)
                        {
                            BubbleUI.bubble(Config.language("ClientSocket", 14));
                            Config.message(Config.language("ClientSocket", 14));
                        }
                        if (temp2 == SKILL_RS_ENUM.SKILL_HAS_BUFFER)
                        {
                            Config.message(Config.language("ClientSocket", 28));
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_SKILL_CAST:
                {
                    temp2 = _bytes.readUnsignedByte();
                    temp1 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = _bytes.readUnsignedByte();
                    temp5 = _bytes.readUnsignedByte();
                    if (temp2 == UNIT_TYPE_ENUM.TYPEID_FLY)
                    {
                        temp6 = Unit.getUnit(temp2, temp1);
                        if (temp6 != null)
                        {
                            if (temp5 == SKILL_RS_ENUM.SKILL_SUCESS)
                            {
                                Recorder.pushAction(bytesBuff);
                                if (temp4 == SKILL_TYPE_ENUM.SKILL_PLAYER)
                                {
                                    temp7 = _bytes.readUnsignedByte();
                                    temp8 = _bytes.readUnsignedInt();
                                    temp6.rightCastSkill(temp2, temp3, temp7, temp8, temp4);
                                }
                                else if (temp4 == SKILL_TYPE_ENUM.SKILL_POSITON)
                                {
                                    temp7 = _bytes.readUnsignedShort();
                                    temp8 = _bytes.readUnsignedShort();
                                    temp6.rightCastSkill(temp2, temp3, temp7, temp8, temp4);
                                }
                                else if (temp4 == SKILL_TYPE_ENUM.SKILL_NO_TARGET)
                                {
                                    temp6.rightCastSkill(temp2, temp3, null, null, temp4);
                                }
                            }
                        }
                    }
                    else
                    {
                        temp6 = Unit.getUnit(temp2, temp1);
                        if (temp6 != null)
                        {
                            if (temp6 == Config.player)
                            {
                                Skill.stopChant();
                            }
                            if (Skill._skillMap[temp3] != null)
                            {
                                Skill._skillMap[temp3].locked = false;
                            }
                            if (temp5 == SKILL_RS_ENUM.SKILL_SUCESS)
                            {
                                Recorder.pushAction(bytesBuff);
                                if (temp6 == Config.player)
                                {
                                    Skill.selectedSkill = null;
                                }
                                if (temp4 == SKILL_TYPE_ENUM.SKILL_PLAYER)
                                {
                                    temp7 = _bytes.readUnsignedByte();
                                    temp8 = _bytes.readUnsignedInt();
                                    if (temp6 == Config.player && temp3 != Config.player.attackMode.id)
                                    {
                                        Hang._preSkillTargetId = temp7;
                                        if (temp3 == 3080 || temp3 == 3081 || temp3 == 3082 || temp3 == 3083)
                                        {
                                            Config.player.target = null;
                                        }
                                    }
                                    temp6.rightCastSkill(temp2, temp3, temp7, temp8, temp4);
                                }
                                else if (temp4 == SKILL_TYPE_ENUM.SKILL_POSITON)
                                {
                                    temp7 = _bytes.readUnsignedShort();
                                    temp8 = _bytes.readUnsignedShort();
                                    temp6.rightCastSkill(temp2, temp3, temp7, temp8, temp4);
                                }
                                else if (temp4 == SKILL_TYPE_ENUM.SKILL_NO_TARGET)
                                {
                                    temp6.rightCastSkill(temp2, temp3, null, null, temp4);
                                }
                            }
                            else if (temp5 == SKILL_RS_ENUM.SKILL_CANCEL)
                            {
                                temp6.actionLock = false;
                                temp6.rightSkillCancel();
                                if (temp6 == Config.player)
                                {
                                    temp6.target = temp6.tracingTarget;
                                }
                                if (Config.debug)
                                {
                                    Config.message(Config.language("ClientSocket", 15) + temp5);
                                }
                            }
                            else if (temp5 == SKILL_RS_ENUM.SKILL_PREPARE)
                            {
                                Recorder.pushAction(bytesBuff);
                                if (temp4 == SKILL_TYPE_ENUM.SKILL_PLAYER)
                                {
                                    temp7 = _bytes.readUnsignedByte();
                                    temp8 = _bytes.readUnsignedInt();
                                    temp6.rightSkillPrepare(temp2, temp3, temp7, temp8, temp4);
                                }
                                else if (temp4 == SKILL_TYPE_ENUM.SKILL_POSITON)
                                {
                                    temp7 = _bytes.readUnsignedShort();
                                    temp8 = _bytes.readUnsignedShort();
                                    temp6.rightSkillPrepare(temp2, temp3, temp7, temp8, temp4);
                                }
                                else if (temp4 == SKILL_TYPE_ENUM.SKILL_NO_TARGET)
                                {
                                    temp6.rightSkillPrepare(temp2, temp3, null, null, temp4);
                                }
                            }
                        }
                    }
                    break;
                }
                case CONST_ENUM.SMSG_SKILL_ARROW_ATTACK:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_FLY, temp1);
                    if (temp4 != null)
                    {
                        temp4.overFlag = true;
                    }
                    break;
                }
                case CONST_ENUM.G2C_SKILL_STATE_UPDATE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedByte();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedByte();
                    temp4 = _bytes.readUnsignedInt();
                    temp5 = _bytes.readUnsignedByte();
                    if (temp3 != 0)
                    {
                        temp6 = Unit.getUnit(temp1, temp2);
                        if (temp6 != null)
                        {
                            if (temp5 == 1)
                            {
                                temp6.addBuff(temp4);
                            }
                            else
                            {
                                temp6.removeBuff(temp4);
                            }
                        }
                    }
                    if (Config.player != null)
                    {
                        if (temp2 == Config.player.id)
                        {
                            Config.ui._playerHead.playerbuf(temp3, temp4, temp5);
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_STATUS_CHANGE:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedByte();
                    temp4 = _bytes.readUnsignedByte();
                    if (temp4 == 0)
                    {
                        temp5;
                    }
                    else
                    {
                        temp5;
                    }
                    temp6 = Unit.getUnit(temp1, temp2);
                    if (temp6 != null)
                    {
                        if (temp3 == 1)
                        {
                            temp6.silent = temp5;
                        }
                        else if (temp3 == 2)
                        {
                            temp6.stun = temp5;
                        }
                        else if (temp3 == 3)
                        {
                            temp6.taunt = temp5;
                        }
                        else if (temp3 == 4)
                        {
                            temp6.itemDisable = temp5;
                        }
                        else if (temp3 == 5)
                        {
                            temp6.attackDisable = temp5;
                        }
                        else if (temp3 == 6)
                        {
                            temp6.stealth = temp5;
                        }
                        else if (temp3 == 11)
                        {
                            temp6.ice = temp5;
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_ACTION_STANDSTILL:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedByte();
                    temp4 = _bytes.readUnsignedInt();
                    temp5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp1);
                    if (temp5 != null)
                    {
                        if (temp2 == 1)
                        {
                            temp5.startGather(temp4 * 1000, temp4 * 1000);
                        }
                        else if (temp2 == 2)
                        {
                            temp5.startGather(temp4 * 1000, temp4 * 1000);
                        }
                        else if (temp2 == 3)
                        {
                            temp5.startGather(temp4 * 1000, temp4 * 1000);
                        }
                        else if (temp2 == 4)
                        {
                            temp5.resting = true;
                        }
                        else if (temp2 == 5)
                        {
                            temp5.addHalo(1226);
                            temp5.addHalo(1036);
                            temp5.startGather(temp4 * 1000, temp4 * 1000);
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_ACTION_INTERRUPT:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedByte();
                    temp5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp1);
                    if (temp5 != null)
                    {
                        temp5.stopGather();
                        temp5.resting = false;
                        temp5.removeHalo(1226);
                        temp5.removeHalo(1036);
                        if (temp2 == 1)
                        {
                        }
                        else if (temp2 == 2)
                        {
                        }
                        else if (temp2 == 3)
                        {
                        }
                        else if (temp2 == 4)
                        {
                        }
                        else if (temp2 == 5)
                        {
                        }
                    }
                    break;
                }
                case CONST_ENUM.SMSG_COLLECT:
                {
                    _mflag = _bytes.readUnsignedByte();
                    Config.player.stopGather();
                    switch(_mflag)
                    {
                        case 0:
                        {
                            Config.message(Config.language("ClientSocket", 16));
                            break;
                        }
                        case 1:
                        {
                            break;
                        }
                        case 2:
                        {
                            Config.message(Config.language("ClientSocket", 17));
                            break;
                        }
                        case 3:
                        {
                            Config.message(Config.language("ClientSocket", 18));
                            break;
                        }
                        case 4:
                        {
                            Config.message(Config.language("ClientSocket", 19));
                            Config.ui._bagUI.handleFull();
                            break;
                        }
                        case 5:
                        {
                            break;
                        }
                        case 6:
                        {
                            Config.message(Config.language("ClientSocket", 20));
                            break;
                        }
                        case 7:
                        {
                            Config.message(Config.language("ClientSocket", 21));
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_SKILL_ATTACK_TYPE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp2 = _bytes.readUnsignedByte();
                    temp1 = _bytes.readUnsignedInt();
                    temp4 = _bytes.readUnsignedByte();
                    temp3 = _bytes.readUnsignedInt();
                    temp5 = _bytes.readUnsignedInt();
                    temp6 = _bytes.readUnsignedByte();
                    temp7 = _bytes.readInt();
                    temp8 = _bytes.readInt();
                    temp22 = _bytes.readUnsignedByte();
                    temp9 = Unit.getUnit(temp4, temp3);
                    temp10 = Unit.getUnit(temp2, temp1);
                    if (temp9 != null && temp10 != null && Config._skillMap[temp5] != null)
                    {
                        cesStr = String(Config._skillMap[temp5].castEffectSize);
                        if (cesStr.indexOf("32") == 0 || cesStr.indexOf("|32") != -1)
                        {
                            trace("lightning", temp1, temp3, temp5);
                            if (cesStr.indexOf("32") == 0)
                            {
                            }
                            else
                            {
                                lghtnStrstart = (cesStr.indexOf("|32") + 1);
                            }
                            if (cesStr.indexOf("|", lghtnStrstart) == -1)
                            {
                                lghtnStr = cesStr.substring(lghtnStrstart + 2);
                            }
                            else
                            {
                                lghtnStr = cesStr.substring(lghtnStrstart + 2, cesStr.indexOf("|", lghtnStrstart));
                            }
                            lghtnColor;
                            if (lghtnStr != "")
                            {
                                lghtnStr = lghtnStr.substring(1);
                                lghtnColor = parseInt(lghtnStr, 16);
                            }
                            if (temp10._follower != null)
                            {
                                UnitEffect.lightning(temp10._follower, temp9, lghtnColor);
                            }
                        }
                    }
                    if (temp6 != 4)
                    {
                        temp12 = Config._skillMap[temp5];
                        temp13 = Math.max(1, Number(temp12.dmgTime));
                        temp14 = Number(temp12.dmgInterval);
                        temp21 = Number(temp12.dmgDelay);
                    }
                    else
                    {
                        temp12 = Config._buffMap[temp5];
                        temp13;
                        temp14;
                        temp21;
                    }
                    if (temp14 == 0)
                    {
                        temp14;
                    }
                    if (temp9 != null)
                    {
                        temp18;
                        temp19;
                        if (temp9 == Config.player || temp10 == Config.player)
                        {
                            temp30;
                        }
                        else
                        {
                            temp30;
                        }
                        if (temp9 == Config.player && temp7 > 0 && temp10 != null && !temp10.die)
                        {
                            Config.player.attacked = true;
                            if (temp10 is Dummy && Config.player._hateStatePrepare)
                            {
                                Config.player.addHate(temp10);
                            }
                        }
                        temp20;
                        if (temp10 != null)
                        {
                            temp20 = Math.atan2(temp9._y - temp10._y, temp9._x - temp10._x);
                        }
                        temp15;
                        while (temp15 < temp13)
                        {
                            
                            if (temp13 > 1)
                            {
                                temp16 = temp7 / temp13 * ((temp15 + 1) + Math.random() * 0.4 - 0.2) - temp18;
                                temp17 = temp8 / temp13 * ((temp15 + 1) + Math.random() * 0.4 - 0.2) - temp19;
                            }
                            else
                            {
                                temp16 = temp7 / temp13 - temp18;
                                temp17 = temp8 / temp13 - temp19;
                            }
                            temp18 = temp18 + temp16;
                            temp19 = temp19 + temp17;
                            if (Math.abs(temp16) < 1)
                            {
                                temp16 = Math.round(temp16 * 10) / 10;
                            }
                            else
                            {
                                temp16 = Math.round(temp16);
                            }
                            if (Math.abs(temp17) < 1)
                            {
                                temp17 = Math.round(temp17 * 10) / 10;
                            }
                            else
                            {
                                temp17 = Math.round(temp17);
                            }
                            if (temp6 == 8)
                            {
                                temp9.jumpWord("-" + temp16 + " Cri", temp10, temp14, 13369344, 24);
                                Unit(temp9).addEffect("1165");
                                if (Config.ui._elementUI.getLevel(5) > 0)
                                {
                                    if (Config.ui._elementUI.getLevel(4) == 0)
                                    {
                                        elem4;
                                    }
                                    else
                                    {
                                        elem4 = Config._elementMap[Config.ui._elementUI.getLevel(4)].elem4;
                                    }
                                    if (Config.ui._elementUI.getLevel(5) == 0)
                                    {
                                        elem5;
                                    }
                                    else
                                    {
                                        elem5 = Config._elementMap[Config.ui._elementUI.getLevel(5)].elem5;
                                    }
                                    if (temp10 != null)
                                    {
                                        temp10.burstWord("+" + elem5 * (1 + elem4 / 100), temp9, temp14, 52224, 16);
                                        Unit(temp10).addEffect("1103");
                                    }
                                }
                            }
                            else if (temp6 == 7)
                            {
                                temp9.addEffect("1116");
                                if (temp30)
                                {
                                    temp9.burstWord(Config.language("ClientSocket", 22), temp10, temp14, 13369344, 32);
                                }
                            }
                            else if (temp6 == 6)
                            {
                                if (temp7 > 0)
                                {
                                    temp9.addEffect("1097");
                                    if (temp30)
                                    {
                                        temp9.burstWord("+" + temp16, temp10, temp14, 52224, 16);
                                    }
                                }
                            }
                            else if (temp6 == 1 || temp6 == 5)
                            {
                                if (temp7 > 0)
                                {
                                    if (temp15 == 0)
                                    {
                                        temp9.hitState(temp10, temp14, false, String(temp12.targetEffectId), temp20);
                                    }
                                    else
                                    {
                                        temp9.hitState(temp10, temp14, false, 0, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.jumpWord("-" + temp16, temp10, temp14, 16777215, 16);
                                    }
                                }
                                else if (temp7 < 0)
                                {
                                    if (String(temp12.targetEffectId) != "0")
                                    {
                                        temp9.addEffect(String(temp12.targetEffectId), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.burstWord("+" + (-temp16), temp10, temp14, 52224, 16);
                                    }
                                }
                                if (temp8 > 0)
                                {
                                    if (String(temp12.targetEffectId) != "0")
                                    {
                                        temp9.addEffect(String(temp12.targetEffectId), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.burstWord("-" + temp17, temp10, temp14, 57087, 16);
                                    }
                                }
                                else if (temp8 < 0)
                                {
                                    if (String(temp12.targetEffectId) != "0")
                                    {
                                        temp9.addEffect(String(temp12.targetEffectId), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.burstWord("+" + (-temp17), temp10, temp14, 57087, 16);
                                    }
                                }
                            }
                            else if (temp6 == 2)
                            {
                                if (temp7 > 0)
                                {
                                    if (temp15 == 0)
                                    {
                                        temp9.hitState(temp10, temp14, temp30, String(temp12.targetEffectId), temp20);
                                    }
                                    else
                                    {
                                        temp9.hitState(temp10, temp14, temp30, 0, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.jumpWord("-" + temp16, temp10, temp14, 13369344, 24, 1, 0.4);
                                    }
                                }
                                else if (temp7 < 0)
                                {
                                    if (String(temp12.targetEffectId) != "0")
                                    {
                                        temp9.addEffect(String(temp12.targetEffectId), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.burstWord("+" + (-temp16), temp10, temp14, 52224, 32);
                                    }
                                }
                                if (temp8 > 0)
                                {
                                    if (String(temp12.targetEffectId) != "0")
                                    {
                                        temp9.addEffect(String(temp12.targetEffectId), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.jumpWord("-" + temp17, temp10, temp14, 57087, 32);
                                    }
                                }
                                else if (temp8 < 0)
                                {
                                    if (String(temp12.targetEffectId) != "0")
                                    {
                                        temp9.addEffect(String(temp12.targetEffectId), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.burstWord("+" + (-temp17), temp10, temp14, 57087, 32);
                                    }
                                }
                            }
                            else if (temp6 == 3)
                            {
                                if (temp30)
                                {
                                    temp9.jumpWord("miss", temp10, temp14, 16777215, 16, 0.5);
                                }
                            }
                            else if (temp6 == 4)
                            {
                                if (temp7 > 0)
                                {
                                    if (temp15 == 0)
                                    {
                                        temp9.hitState(temp10, temp14, false, String(temp12.buffEffect), temp20);
                                    }
                                    else
                                    {
                                        temp9.hitState(temp10, temp14, false, 0, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.jumpWord("-" + temp16, temp10, temp14, 16777215, 16);
                                    }
                                }
                                else if (temp7 < 0)
                                {
                                    if (String(temp12.buffEffect) != "0")
                                    {
                                        temp9.addEffect(String(temp12.buffEffect), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.burstWord("+" + (-temp16), temp10, temp14, 52224, 16);
                                    }
                                }
                                if (temp8 > 0)
                                {
                                    if (String(temp12.buffEffect) != "0")
                                    {
                                        temp9.addEffect(String(temp12.buffEffect), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.jumpWord("-" + temp17, temp10, temp14, 57087, 16);
                                    }
                                }
                                else if (temp8 < 0)
                                {
                                    if (String(temp12.buffEffect) != "0")
                                    {
                                        temp9.addEffect(String(temp12.buffEffect), 1, null, temp20);
                                    }
                                    if (temp30)
                                    {
                                        temp9.burstWord("+" + (-temp17), temp10, temp14, 57087, 16);
                                    }
                                }
                            }
                            temp15 = (temp15 + 1);
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_COOL_DOWN:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    if (temp1 == 0)
                    {
                        var _loc_2:* = 0;
                        var _loc_3:* = Skill._skillMap;
                        while (_loc_3 in _loc_2)
                        {
                            
                            i = _loc_3[_loc_2];
                            if (i < 10000)
                            {
                                if (Skill._skillMap[i]._data != Config.player.attackMode)
                                {
                                    if (Skill._skillMap[i]._data.pubCDType == 0)
                                    {
                                        if (Skill._skillMap[i].cd == 0)
                                        {
                                            Skill._skillMap[i].cdMax = temp2;
                                        }
                                        if (temp2 > Skill._skillMap[i].cd)
                                        {
                                            Skill._skillMap[i].cd = temp2;
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else if (temp1 == 1)
                    {
                    }
                    else if (Skill._skillMap[temp1] != null)
                    {
                        Skill._skillMap[temp1].cd = Math.max(temp2, Skill._skillMap[temp1].cd);
                    }
                    if (temp2 == 0)
                    {
                        Config.player.think();
                    }
                    break;
                }
                case CONST_ENUM.G2C_SKILLCDLIST:
                {
                    temp1 = _bytes.readUnsignedInt();
                    i;
                    while (i < temp1)
                    {
                        
                        temp2 = _bytes.readUnsignedInt();
                        temp3 = _bytes.readUnsignedInt();
                        temp4 = Skill.getSkill(temp2);
                        temp4.cd = temp3;
                        i = (i + 1);
                    }
                    break;
                }
                case CONST_ENUM.G2C_ITEM_PICKUP:
                {
                    itemID = _bytes.readUnsignedInt();
                    item = Item.getItem(UNIT_TYPE_ENUM.TYPEID_ITEM_MAP, itemID);
                    pickerr = _bytes.readUnsignedInt();
                    if (pickerr > 0)
                    {
                        Config.message(Config._codeWords[WordsType.TYPEID_ERR][pickerr]);
                    }
                    else if (item != null)
                    {
                        item.flyToPlayer();
                    }
                    pickBigError;
                    if (pickerr != 0)
                    {
                        if (Config.ui._playerHead.fcmstatus > 0)
                        {
                            pickBigError;
                        }
                        if (pickerr == 433)
                        {
                        }
                        else if (pickerr == 401)
                        {
                            pickBigError;
                            BubbleUI.bubble(Config.language("ErrorCode", 1));
                            Config.ui._bagUI.handleFull();
                        }
                        else if (pickerr == 433)
                        {
                        }
                        else if (pickerr == 432)
                        {
                            pickBigError;
                            BubbleUI.bubble(Config.language("ErrorCode", 2));
                        }
                        else if (pickerr == 513)
                        {
                            pickBigError;
                        }
                        if (item != null)
                        {
                            if (pickBigError)
                            {
                                item.pickDisable = true;
                            }
                            if (Hang.currTarget == item)
                            {
                                Hang.currTarget = null;
                            }
                            if (Config.player.target == item)
                            {
                                Config.player.target = null;
                            }
                        }
                    }
                    break;
                }
                case CONST_ENUM.SMSG_ITEM_DESTROY:
                {
                    temp = _bytes.readUnsignedByte();
                    break;
                }
                case CONST_ENUM.G2C_PLAYER_DIE:
                {
                    trace("SMSG_PLAYER_DEATH");
                    Config.player.target = null;
                    Skill.stopChant();
                    Config.player.dying(_bytes.readUnsignedShort(), _bytes.readUnsignedByte(), _bytes.readUnsignedInt(), _bytes.readUnsignedInt());
                    if (Config.player.level <= 10)
                    {
                        GuideUI.testDoId(183);
                    }
                    else
                    {
                        GuideUI.testDoId(185);
                    }
                    break;
                }
                case CONST_ENUM.G2C_PLAYER_RELIVE:
                {
                    trace("SMSG_PLAYER_DEATH");
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp1);
                    if (temp2 != null)
                    {
                        temp2.revive();
                        temp2.removeHalo(1226);
                        temp2.removeHalo(1036);
                        temp2.stopGather();
                    }
                    if (Config.player.level <= 10)
                    {
                        GuideUI.testDoId(184);
                    }
                    else
                    {
                        GuideUI.testDoId(186);
                    }
                    break;
                }
                case CONST_ENUM.SMSG_BINDMONEYGOT:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    if (temp1 == UNIT_TYPE_ENUM.TYPEID_UNIT)
                    {
                        temp4 = Dummy._deadMonsterPosBuff[temp2];
                        if (temp4 != null)
                        {
                            UnitEffect.extract(temp4, Config.player.getScreenAngle(temp4) + Math.PI);
                        }
                        else
                        {
                            UnitEffect.extract(Config.player);
                        }
                        Config.ui._charUI.lockExtract();
                    }
                    break;
                }
                case CONST_ENUM.G2C_DEATH_SKILL:
                {
                    trace("SMSG_DEATH_SKILL");
                    break;
                }
                case CONST_ENUM.G2C_DEATH_SKILL_CANCEL:
                {
                    trace("SMSG_DEATH_SKILL_CANCEL");
                    break;
                }
                case CONST_ENUM.G2C_BINDING_ADD:
                {
                    trace("SMSG_BINDING_ADD");
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2;
                    while (temp2 < temp1)
                    {
                        
                        temp3 = _bytes.readUnsignedInt();
                        temp4 = _bytes.readUnsignedInt();
                        temp5 = _bytes.readUnsignedInt();
                        temp6 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp4);
                        temp7 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp5);
                        if (temp6 != null)
                        {
                            temp6.binding(temp7);
                        }
                        if (temp7 != null)
                        {
                            temp7.beBinding(temp6);
                        }
                        temp2 = (temp2 + 1);
                    }
                    break;
                }
                case CONST_ENUM.G2C_BINDING_REMOVE:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedInt();
                    temp2;
                    while (temp2 < temp1)
                    {
                        
                        temp3 = _bytes.readUnsignedInt();
                        temp4 = _bytes.readUnsignedInt();
                        temp5 = _bytes.readUnsignedInt();
                        temp6 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp4);
                        temp7 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp5);
                        if (temp6 != null)
                        {
                            temp6.stopBinding(temp7);
                        }
                        if (temp7 != null)
                        {
                            temp7.stopBinding(temp6);
                        }
                        temp2 = (temp2 + 1);
                    }
                    break;
                }
                case CONST_ENUM.G2C_SPECIAL_ACT:
                {
                    Recorder.pushAction(bytesBuff);
                    temp1 = _bytes.readUnsignedByte();
                    temp2 = _bytes.readUnsignedInt();
                    temp3 = _bytes.readUnsignedInt();
                    temp = _bytes.readUnsignedShort();
                    temp4 = _bytes.readUTFBytes(temp);
                    if (temp1 == 0)
                    {
                        temp5 = Config.map.tileToMap({_x:temp2, _y:temp3});
                    }
                    else if (temp1 == 1)
                    {
                        if (temp2 == 0)
                        {
                            temp5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, temp3);
                        }
                        else if (temp2 == 1)
                        {
                            temp5 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp3);
                        }
                        else if (temp2 == 2)
                        {
                            temp5 = Unit.getGameObject(temp3);
                        }
                    }
                    if (temp5 != null)
                    {
                        playEffect(temp5, temp4);
                    }
                    break;
                }
                case CONST_ENUM.G2C_BINDING_LIST:
                {
                    trace("G2C_BINDING_LIST");
                    break;
                }
                case CONST_ENUM.G2C_MONSTER_TALK_FACE:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedByte();
                    temp3 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_UNIT, temp1);
                    if (temp3 != null)
                    {
                        tlkArr = String(temp3._data.talkText).split("+");
                        if (tlkArr[(temp2 - 1)] != null)
                        {
                            temp3.sayArr(tlkArr[(temp2 - 1)]);
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_OBJECT_LABEL_UPDATE:
                {
                    temp1 = _bytes.readUnsignedInt();
                    temp2 = _bytes.readUnsignedByte();
                    temp3 = _bytes.readUnsignedByte();
                    if (temp2 == 0)
                    {
                        temp4 = _bytes.readUnsignedByte();
                        if (temp3 == 1)
                        {
                            temp5 = _bytes.readUnsignedShort();
                            temp6 = _bytes.readUTFBytes(temp5);
                        }
                        unit = Unit.getUnit(temp3, temp1);
                        if (unit != null)
                        {
                            if (temp3 == 0)
                            {
                                if (temp4 == 1)
                                {
                                    Unit(unit)._stateBar.setBiaoche(Config.language("ClientSocket", 30));
                                }
                                else
                                {
                                    Unit(unit)._stateBar.setBiaoche(Config.language("ClientSocket", 31));
                                }
                            }
                            else
                            {
                                Unit(unit)._stateBar.setBiaoche(Config.language("ClientSocket", 32, temp6));
                            }
                        }
                    }
                    else
                    {
                        unit = Unit.getUnit(temp3, temp1);
                        if (unit != null)
                        {
                            Unit(unit)._stateBar.setBiaoche();
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_FLAG_LIST:
                {
                    count = _bytes.readUnsignedByte();
                    Config._flagList = {};
                    i;
                    while (i < count)
                    {
                        
                        playerid = _bytes.readUnsignedInt();
                        flagnum = _bytes.readUnsignedByte();
                        Config._flagList[playerid] = flagnum;
                        i = (i + 1);
                    }
                    playerlist = Unit.getUnitList(UNIT_TYPE_ENUM.TYPEID_PLAYER);
                    var _loc_2:* = 0;
                    var _loc_3:* = playerlist;
                    while (_loc_3 in _loc_2)
                    {
                        
                        i = _loc_3[_loc_2];
                        Unit(playerlist[i])._stateBar.checkFlag();
                    }
                    break;
                }
                case CONST_ENUM.G2C_WINFLAG:
                {
                    playerid = _bytes.readUnsignedInt();
                    playerlist = Unit.getUnitList(UNIT_TYPE_ENUM.TYPEID_PLAYER);
                    Config._winflag = playerid;
                    var _loc_2:* = 0;
                    var _loc_3:* = playerlist;
                    while (_loc_3 in _loc_2)
                    {
                        
                        i = _loc_3[_loc_2];
                        Unit(playerlist[i])._stateBar.checkWinflag();
                    }
                    break;
                }
                case CONST_ENUM.G2C_VER_SET:
                {
                    num = _bytes.readUnsignedByte();
                    _bytes.readUnsignedInt();
                    _bytes.readUnsignedInt();
                    Config.ver_zhanhun = _bytes.readUnsignedInt();
                    if (!Config.ver_zhufu)
                    {
                        delete Config._taskMap[1359];
                    }
                    Config.ver_zhufu = _bytes.readUnsignedInt();
                    if (!Config.ver_zhufu)
                    {
                        delete Config._taskMap[1198];
                    }
                    Config.ver_yuansu = _bytes.readUnsignedInt();
                    if (!Config.ver_zhufu)
                    {
                        delete Config._taskMap[1388];
                    }
                    Config.ver_zuoji = _bytes.readUnsignedInt();
                    Config.ver_chibang = _bytes.readUnsignedInt();
                    if (Config.ui._producepanel != null)
                    {
                        Config.ui._producepanel.checkBarButtonVer();
                    }
                    Config.ver_emo = _bytes.readUnsignedInt();
                    Config.ver_kongju = _bytes.readUnsignedInt();
                    Config.ver_yabiao = _bytes.readUnsignedInt();
                    trace("版本开关");
                    trace(Config.ver_zhanhun);
                    trace(Config.ver_zhufu);
                    trace(Config.ver_yuansu);
                    trace(Config.ver_zuoji);
                    trace(Config.ver_emo);
                    trace(Config.ver_kongju);
                    trace(Config.ver_yabiao);
                    i;
                    while (i < (num + 1))
                    {
                        
                        _bytes.readUnsignedInt();
                        i = (i + 1);
                    }
                    break;
                }
                case CONST_ENUM.G2C_JPMOBAGE_ERROR:
                {
                    errCode = _bytes.readUnsignedInt();
                    strlen = _bytes.readUnsignedShort();
                    errMsg = _bytes.readUTFBytes(strlen);
                    AlertUI.alert(Config.language("ClientSocket", 4), errMsg, [Config.language("ClientSocket", 6)]);
                    break;
                }
                case CONST_ENUM.G2C_EXPCOPY_AUTO:
                {
                    npcID = _bytes.readUnsignedInt();
                    doorNPC = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_NPC, npcID);
                    if (doorNPC != null)
                    {
                        Hang._expCopyGateLock = true;
                        Hang._expCopyDoorID = npcID;
                        if (Config.ui._monsterIndexUI.hanging)
                        {
                            Config.player.target = doorNPC;
                        }
                    }
                    break;
                }
                case CONST_ENUM.G2C_ACCOMPANY_MODELID:
                {
                    playerID = _bytes.readUnsignedInt();
                    followID = _bytes.readUnsignedInt();
                    unit = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, playerID);
                    if (unit != null)
                    {
                        Unit(unit).setFollower(followID);
                    }
                    break;
                }
                case CONST_ENUM.SMSG_PONG:
                {
                    _ppTime = Config.time - _prePingTime;
                    break;
                }
                default:
                {
                    _socket.dispatchEvent(new SocketEvent("socket" + cmd, _bytes));
                    break;
                    break;
                }
            }
            return;
        }// end function

        private static function playEffect(param1, param2:String)
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            if (param2.indexOf("#") == 0)
            {
                _loc_4 = param2.substring(1).split("|");
                _loc_3 = 0;
                while (_loc_3 < _loc_4.length)
                {
                    
                    _loc_5 = _loc_4[_loc_3].split(":");
                    switch(Number(_loc_5[0]))
                    {
                        case 1:
                        {
                            if (_loc_5.length == 1)
                            {
                                UnitEffect.jump(param1);
                            }
                            else
                            {
                                _loc_6 = String(_loc_5[1]).split("_");
                                if (_loc_6.length == 1)
                                {
                                    UnitEffect.jump(param1, Number(_loc_6[0]));
                                }
                                else
                                {
                                    UnitEffect.jump(param1, Number(_loc_6[0]), Number(_loc_6[1]));
                                }
                            }
                            break;
                        }
                        case 2:
                        {
                            if (_loc_5.length == 1)
                            {
                                UnitEffect.afterimage(param1);
                            }
                            else
                            {
                                UnitEffect.afterimage(param1, Number(_loc_5[1]));
                            }
                            break;
                        }
                        case 3:
                        {
                            UnitEffect.flash(param1);
                            break;
                        }
                        case 4:
                        {
                            if (_loc_5.length == 1)
                            {
                                MapEffect.quake(Config.map);
                            }
                            else
                            {
                                _loc_6 = String(_loc_5[1]).split("_");
                                if (_loc_6.length == 1)
                                {
                                    MapEffect.quake(Config.map, Number(_loc_6[0]));
                                }
                                else
                                {
                                    MapEffect.quake(Config.map, Number(_loc_6[0]), Number(_loc_6[1]));
                                }
                            }
                            break;
                        }
                        case 5:
                        {
                            if (_loc_5.length == 1)
                            {
                                MapEffect.zoom(Config.map);
                            }
                            else
                            {
                                MapEffect.zoom(Config.map, Number(_loc_5[1]));
                            }
                            break;
                        }
                        case 6:
                        {
                            if (_loc_5.length == 1)
                            {
                                UnitEffect.whirl(param1);
                            }
                            else
                            {
                                UnitEffect.whirl(param1, Number(_loc_5[1]));
                            }
                            break;
                        }
                        case 7:
                        {
                            break;
                        }
                        case 8:
                        {
                            break;
                        }
                        case 9:
                        {
                            if (_loc_5.length == 1)
                            {
                                UnitEffect.stiff(param1);
                            }
                            else
                            {
                                UnitEffect.stiff(param1, Number(_loc_5[1]));
                            }
                            break;
                        }
                        case 10:
                        {
                            if (_loc_5.length == 1)
                            {
                            }
                            else
                            {
                                UnitEffect.motionEffectParam(Config.map, param1, param1, String(_loc_5[1]));
                            }
                            break;
                        }
                        case 13:
                        {
                            UnitEffect.smash(param1);
                            break;
                        }
                        case 14:
                        {
                            if (_loc_5.length == 1)
                            {
                                UnitEffect.burst(param1);
                            }
                            else
                            {
                                UnitEffect.burst(param1, Number(_loc_5[1]));
                            }
                            break;
                        }
                        case 21:
                        {
                            if (_loc_5.length == 1)
                            {
                            }
                            else
                            {
                                var _loc_8:* = String(_loc_5[1]).split("_");
                                _loc_6 = String(_loc_5[1]).split("_");
                                UnitEffect.twitch(param1, "attack", Number(_loc_6[0]), Number(_loc_6[1]), Number(_loc_6[2]), Number(_loc_6[3]), Number(_loc_6[4]));
                            }
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_3 = _loc_3 + 1;
                }
            }
            else if (param1 is Unit)
            {
                param1.addEffect(param2);
            }
            else
            {
                _loc_7 = Effect.newEffect(Config._model[Number(param2)], param1._x, param1._y, 3);
                _loc_7.display(Config.map);
            }
            return;
        }// end function

        private static function addSkyExit(param1, param2, param3)
        {
            _skyExitBuffObjectArray.push({temp1:param1, temp3:param2, temp4:param3});
            if (Config.map._state == "ready")
            {
                subAddSkyExit();
            }
            else
            {
                Config.map.removeEventListener("complete", subAddSkyExit);
                Config.map.addEventListener("complete", subAddSkyExit);
            }
            return;
        }// end function

        private static function subAddSkyExit(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            _loc_2 = 0;
            while (_loc_2 < _skyExitBuffObjectArray.length)
            {
                
                Config.map.removeEventListener("complete", subAddSkyExit);
                _loc_3 = _skyExitBuffObjectArray[_loc_2].temp1;
                _loc_4 = _skyExitBuffObjectArray[_loc_2].temp3;
                _loc_5 = _skyExitBuffObjectArray[_loc_2].temp4;
                _loc_6 = new XML("<list>\r\n\t\t\t\t\t\t\t<id>40020</id>\r\n\t\t\t\t\t\t\t<npclevel>1</npclevel>\r\n\t\t\t\t\t\t\t<npcEXP>0</npcEXP>\r\n\t\t\t\t\t\t\t<model>2603</model>\r\n\t\t\t\t\t\t\t<portrait>1</portrait>\r\n\t\t\t\t\t\t\t" + ("<name>" + Config.language("ClientSocket", 29) + "</name>") + "\r\n\t\t\t\t\t\t\t<shopId>0</shopId>\r\n\t\t\t\t\t\t\t<portalId>0</portalId>\r\n\t\t\t\t\t\t\t<talkTime>0</talkTime>\r\n\t\t\t\t\t\t\t<talkMode>0</talkMode>\r\n\t\t\t\t\t\t\t<effectOnly>0</effectOnly>\r\n\t\t\t\t\t\t\t<layer>0</layer>\r\n\t\t\t\t\t\t\t<canBeSee>0</canBeSee>\r\n\t\t\t\t\t\t\t<conditionItem>0</conditionItem>\r\n\t\t\t\t\t\t\t<conditionDoTask>0</conditionDoTask>\r\n\t\t\t\t\t\t\t<conditionCompleteTask>0</conditionCompleteTask>\r\n\t\t\t\t\t\t\t</list>");
                _loc_7 = Config.map.tileToMap({_x:_loc_4, _y:_loc_5});
                _loc_8 = Npc.newNpc(XML2Object.toObj(_loc_6), _loc_7._x, _loc_7._y, UNIT_TYPE_ENUM.TYPEID_NPC, _loc_3);
                var _loc_9:* = true;
                _loc_8._sky = true;
                _loc_8.display(Config.map);
                var _loc_9:* = _loc_8;
                Npc._skyNpcStack[_loc_4 + "_" + _loc_5] = _loc_8;
                _loc_2 = _loc_2 + 1;
            }
            var _loc_9:* = [];
            _skyExitBuffObjectArray = [];
            return;
        }// end function

        private static function addFbExit(param1, param2, param3)
        {
            _fbExitBuffObjectArray.push({temp1:param1, temp3:param2, temp4:param3});
            if (Config.map._state == "ready")
            {
                subAddFbExit();
            }
            else
            {
                Config.map.removeEventListener("complete", subAddFbExit);
                Config.map.addEventListener("complete", subAddFbExit);
            }
            return;
        }// end function

        private static function subAddFbExit(param1 = null)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            _loc_2 = 0;
            while (_loc_2 < _fbExitBuffObjectArray.length)
            {
                
                Config.map.removeEventListener("complete", subAddFbExit);
                _loc_3 = _fbExitBuffObjectArray[_loc_2].temp1;
                _loc_4 = _fbExitBuffObjectArray[_loc_2].temp3;
                _loc_5 = _fbExitBuffObjectArray[_loc_2].temp4;
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[_loc_4 + "_" + _loc_5] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[(_loc_4 - 1) + "_" + (_loc_5 - 1)] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[(_loc_4 - 1) + "_" + _loc_5] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[(_loc_4 - 1) + "_" + (_loc_5 + 1)] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[_loc_4 + "_" + (_loc_5 - 1)] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[_loc_4 + "_" + (_loc_5 + 1)] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[(_loc_4 + 1) + "_" + (_loc_5 - 1)] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[(_loc_4 + 1) + "_" + _loc_5] = {type:"fb_exit", id:_loc_3};
                var _loc_6:* = {type:"fb_exit", id:_loc_3};
                Config.eventStack[(_loc_4 + 1) + "_" + (_loc_5 + 1)] = {type:"fb_exit", id:_loc_3};
                _loc_2 = _loc_2 + 1;
            }
            var _loc_6:* = [];
            _fbExitBuffObjectArray = [];
            return;
        }// end function

        private static function OnConnect(event:Event) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            trace("连接成功！");
            if (Config._lanVersion == LanVersion.QQ_ZH_CN || Config._switchHttpHead)
            {
                _loc_2 = "GET / HTTP/1.1\r\nHost: " + _ip + ":" + _port + "\r\n\r\n";
                _loc_3 = new ByteArray();
                _loc_3.writeUTFBytes(_loc_2);
                _socket.writeBytes(_loc_3);
                _socket.flush();
            }
            ping();
            return;
        }// end function

        private static function OnClose(event:Event) : void
        {
            trace("Config.normalQuit", Config.normalQuit);
            if (!Config.normalQuit)
            {
                var _loc_2:* = Player._playerId;
                Config.loginCharIdCookie = Player._playerId;
                var _loc_2:* = Config.mapLine;
                Config.mapLineCookie = Config.mapLine;
                AlertUI.alert(Config.language("ClientSocket", 24), Config.language("ClientSocket", 25), [Config.language("ClientSocket", 8)], [autoLoginCancel], null, false, true, true);
                clearTimeout(_autoLoginTimer);
                var _loc_2:* = setTimeout(autoLoginLoop, 1000, 29);
                _autoLoginTimer = setTimeout(autoLoginLoop, 1000, 29);
            }
            else
            {
                AlertUI.alert(Config.language("ClientSocket", 24), Config.language("ClientSocket", 26), [Config.language("ClientSocket", 6)]);
                clearTimeout(_autoLoginTimer);
            }
            return;
        }// end function

        private static function autoLoginCancel(param1)
        {
            var _loc_2:* = null;
            Config.loginCharIdCookie = null;
            var _loc_2:* = null;
            Config.mapLineCookie = null;
            AlertUI.alert(Config.language("ClientSocket", 24), Config.language("ClientSocket", 26), [Config.language("ClientSocket", 6)]);
            clearTimeout(_autoLoginTimer);
            return;
        }// end function

        private static function autoLoginLoop(param1)
        {
            var sec:* = param1;
            clearTimeout(_autoLoginTimer);
            var _loc_3:* = Config.language("ClientSocket", 27, sec);
            AlertUI.msg = Config.language("ClientSocket", 27, sec);
            if (sec > 0)
            {
                var _loc_3:* = setTimeout(autoLoginLoop, 1000, (sec - 1));
                _autoLoginTimer = setTimeout(autoLoginLoop, 1000, (sec - 1));
            }
            else
            {
                try
                {
                    ExternalInterface.call("eval", "location.reload();");
                }
                catch (e)
                {
                }
            }
            return;
        }// end function

        private static function objectUpdate(param1, param2, param3, param4 = null)
        {
            switch(param2)
            {
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_HAIR:
                {
                    Recorder.pushAction(param4);
                    var _loc_5:* = param3;
                    param1.hairId = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CLIP:
                {
                    trace("OBJECT_UPDATE_TYPE_ENUM.TYPEID_CLIP", param3);
                    Recorder.pushAction(param4);
                    var _loc_5:* = param3;
                    param1.forceClip = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_LEVEL:
                {
                    Recorder.pushAction(param4);
                    var _loc_5:* = param3;
                    param1.level = param3;
                    Config.ui._teamUI.teamUpdate(param1.id, 4, param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EXP:
                {
                    var _loc_5:* = param3;
                    param1.exp = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EXP_UPDATE:
                {
                    var _loc_5:* = param3;
                    param1.expUpdate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_HP:
                {
                    Recorder.pushAction(param4);
                    var _loc_5:* = param3;
                    param1.hp = param3;
                    Config.ui._teamUI.teamUpdate(param1.id, 5, param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_HP_MAX:
                {
                    Recorder.pushAction(param4);
                    var _loc_5:* = param3;
                    param1.hpMax = param3;
                    Config.ui._teamUI.teamUpdate(param1.id, 6, param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_MP:
                {
                    var _loc_5:* = param3;
                    param1.mp = param3;
                    Config.ui._teamUI.teamUpdate(param1.id, 7, param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_MP_MAX:
                {
                    var _loc_5:* = param3;
                    param1.mpMax = param3;
                    Config.ui._teamUI.teamUpdate(param1.id, 8, param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATK_SPEED:
                {
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATK_SPEED_LEVEL:
                {
                    trace("TYPEID_ATK_SPEED_LEVEL", param3);
                    var _loc_5:* = param3;
                    param1.atkSpeedLevel = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_MOVE_SPEED:
                {
                    Recorder.pushAction(param4);
                    var _loc_5:* = param3;
                    param1.speed = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATK:
                {
                    var _loc_5:* = param3;
                    param1.atk = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DEF:
                {
                    var _loc_5:* = param3;
                    param1.def = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATK_RANGE:
                {
                    var _loc_5:* = param3;
                    param1.normalRange = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DODGE:
                {
                    var _loc_5:* = param3;
                    param1.evade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_RATE:
                {
                    var _loc_5:* = param3;
                    param1.rate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_PROB:
                {
                    var _loc_5:* = param3;
                    param1.criticalRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_VALUE:
                {
                    var _loc_5:* = param3;
                    param1.criticalMulti = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_MATK:
                {
                    var _loc_5:* = param3;
                    param1.atkMagic = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_MDEF:
                {
                    var _loc_5:* = param3;
                    param1.defMagic = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_RESIST:
                {
                    var _loc_5:* = param3;
                    param1.criticalResist = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATK_RANGED:
                {
                    var _loc_5:* = param3;
                    param1.atkRanged = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DEF_RANGED:
                {
                    var _loc_5:* = param3;
                    param1.defRanged = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATK_ADD:
                {
                    var _loc_5:* = param3;
                    param1.atkAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DEF_ADD:
                {
                    var _loc_5:* = param3;
                    param1.defAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATKRANGE_ADD:
                {
                    var _loc_5:* = param3;
                    param1.atkRangedAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DEFRANGE_ADD:
                {
                    var _loc_5:* = param3;
                    param1.defRangedAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATKMAGIC_ADD:
                {
                    var _loc_5:* = param3;
                    param1.atkMagicAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DEFMAGIC_ADD:
                {
                    var _loc_5:* = param3;
                    param1.defMagicAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_DODGE:
                {
                    var _loc_5:* = param3;
                    param1.criticalEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_ADD:
                {
                    var _loc_5:* = param3;
                    param1.criticalAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_MINUS:
                {
                    var _loc_5:* = param3;
                    param1.criticalMinus = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_PROB_MAGIC:
                {
                    var _loc_5:* = param3;
                    param1.skillCriticalRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_DODGE_MAGIC:
                {
                    var _loc_5:* = param3;
                    param1.skillCriticalEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_VALUE_MAGIC:
                {
                    var _loc_5:* = param3;
                    param1.skillCriticalMulti = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_CRITICAL_RESIST_MAGIC:
                {
                    var _loc_5:* = param3;
                    param1.skillCriticalResist = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DODGE_SKILL:
                {
                    var _loc_5:* = param3;
                    param1.skillEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_RATE_SKILL:
                {
                    var _loc_5:* = param3;
                    param1.skillRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATK_SKILL:
                {
                    var _loc_5:* = param3;
                    param1.atkSkill = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DEF_SKILL:
                {
                    var _loc_5:* = param3;
                    param1.defSkill = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_GOLDCOIN:
                {
                    var _loc_5:* = param3;
                    param1.money1 = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_SILVERCOIN:
                {
                    var _loc_5:* = param3;
                    param1.money2 = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_MONEY:
                {
                    var _loc_5:* = param3;
                    param1.money3 = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TITLEID_UPDATE:
                {
                    var _loc_5:* = param3;
                    param1.titleId = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DAYTASK_REFASH:
                {
                    var _loc_5:* = param3;
                    Config.ui._taskpanel.daytaskflag = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_DAYTASK_NUM:
                {
                    Config.ui._taskpanel.setdaynum(param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_GILDTASK_NUM:
                {
                    var _loc_5:* = param3;
                    Config.ui._gangs.downgildtasknum = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EQUIPLUCKY_NUM:
                {
                    var _loc_5:* = param3;
                    Config.ui._equiomadepanel.equipfinelucky = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_BIND_MONEY:
                {
                    var _loc_5:* = param3;
                    param1.money4 = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EXPBALL_HADE:
                {
                    Config.ui._expball.setvalue("has", param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EXPBALL_ENDEXP:
                {
                    Config.ui._expball.setvalue("leftpoint", param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EXPBALL_LEFT:
                {
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_PICKS_SOUL:
                {
                    if (param3 == 0)
                    {
                        Config.ui._quickUI._soulUI.close();
                    }
                    else if (param3 == 1)
                    {
                        Config.ui._quickUI._soulUI.open();
                    }
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_PICKS_ALLNUM:
                {
                    var _loc_5:* = param3;
                    Config.ui._quickUI._soulUI.num = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_PICKS_TYPE:
                {
                    Config.ui._quickUI._soulUI.setSoul(param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_PICKS_NUM:
                {
                    var _loc_5:* = param3;
                    Config.ui._quickUI._soulUI.amount = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_PICKS_AWARD:
                {
                    var _loc_5:* = param3;
                    Config.ui._quickUI._soulUI.award = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.GOLD_HAND_NUM:
                {
                    var _loc_5:* = param3;
                    Skill.goldhandTime = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PICKS_SOUL_NUM:
                {
                    var _loc_5:* = param3;
                    Skill.picksoulTime = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_BELONG_TEAM:
                {
                    var _loc_5:* = param3;
                    param1.belongTeam = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_BELONG_PLAYER:
                {
                    var _loc_5:* = param3;
                    param1.belongPlayer = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EXTRA_ATK:
                {
                    var _loc_5:* = param3;
                    param1.otheratk = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_EXTRA_DEF:
                {
                    var _loc_5:* = param3;
                    param1.otherdef = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_TEAM_LEADER:
                {
                    Config.ui._teamUI.leaderFlag(param1.id, param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_WOLF_ID:
                {
                    if (param1.id == Config.player.id)
                    {
                        var _loc_5:* = param3;
                        Config.ui._wolfactive.wolfId = param3;
                    }
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_WOLF_NUM:
                {
                    if (param1.id == Config.player.id)
                    {
                        var _loc_5:* = param3;
                        Config.ui._wolfactive.wolfNum = param3;
                    }
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_FIELD_OPENBAG:
                {
                    Config.ui._bagUI.BagCount(param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_FCM_STATUS:
                {
                    var _loc_5:* = param3;
                    Config.ui._playerHead.fcmstatus = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_ATTACK_LUKY:
                {
                    var _loc_5:* = param3;
                    param1.lucky = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_ATTACK:
                {
                    var _loc_5:* = param3;
                    param1.comAtk = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_DEFENCE:
                {
                    var _loc_5:* = param3;
                    param1.comDef = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_PHY_HIT_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_PHY_SHUN_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_SPELL_HIT_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comSkillRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_SPELL_SHUN_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comSkillEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_MBIGHIT_VALUE_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comSkillCritical = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_MBIGHIT_RESIST_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comSkillCriticalDef = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_BIGHIT_VALUE_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comCritical = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_BIGHIT_RESIST_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comCriticalDef = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_ATK_ADD:
                {
                    var _loc_5:* = param3;
                    param1.comAtkAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_DEF_ADD:
                {
                    var _loc_5:* = param3;
                    param1.comDefAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_FIELD_SKILL_DMG_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comSkillAtk = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_SKILL_ADDHIT_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comSkillCriticalAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_SKILL_REDUCEHIT_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comSkillCriticalDel = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_ATTACK_ADDHIT_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comAtkCriticalAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_UNIT_ATTACK_REDUCEHIT_KILO:
                {
                    var _loc_5:* = param3;
                    param1.comAtkCriticalDel = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_PLAYER_FIELD_HUNTKILLERID:
                {
                    Config.ui._wolfactive.updateKill(param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_ATK:
                {
                    var _loc_5:* = param3;
                    param1.dispAtk = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_DEF:
                {
                    var _loc_5:* = param3;
                    param1.dispDef = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_DMG_ADD:
                {
                    var _loc_5:* = param3;
                    param1.dispDmgAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_DMG_REDUCE:
                {
                    var _loc_5:* = param3;
                    param1.dispDmgReduce = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_DMG_ATK_SPEED:
                {
                    var _loc_5:* = param3;
                    param1.dispAtkSpeed = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_ADD:
                {
                    var _loc_5:* = param3;
                    param1.dispSkillAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_ATK_HIT:
                {
                    var _loc_5:* = param3;
                    param1.dispRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_HIT:
                {
                    var _loc_5:* = param3;
                    param1.dispSkillRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_ATK_SHUN:
                {
                    var _loc_5:* = param3;
                    param1.dispEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_SHUN:
                {
                    var _loc_5:* = param3;
                    param1.dispSkillEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_ATK_BIGHIT_RATE:
                {
                    var _loc_5:* = param3;
                    param1.dispCriticalRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_BIGHIT_RATE:
                {
                    var _loc_5:* = param3;
                    param1.dispSkillCriticalRate = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_ATK_BIGHIT_REDUCE:
                {
                    var _loc_5:* = param3;
                    param1.dispCriticalEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_BIGHIT_REDUCE:
                {
                    var _loc_5:* = param3;
                    param1.dispSkillCriticalEvade = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_ATK_BIGHIT_VALUEADD:
                {
                    var _loc_5:* = param3;
                    param1.dispCriticalAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_BIGHIT_VALUEADD:
                {
                    var _loc_5:* = param3;
                    param1.dispSkillCriticalAdd = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_ATK_BIGHIT_VALUEREDUCE:
                {
                    var _loc_5:* = param3;
                    param1.dispCriticalReduce = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_BIGHIT_VALUEREDUCE:
                {
                    var _loc_5:* = param3;
                    param1.dispSkillCriticalReduce = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_DMG_GOD:
                {
                    var _loc_5:* = param3;
                    param1.dispGodAtk = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_SPELL_DMG_LUCK:
                {
                    var _loc_5:* = param3;
                    param1.dispLuck = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.TYPEID_PLAYER_HUE:
                {
                    var _loc_5:* = param3;
                    param1.forceHue = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.GO_FIELD_BLOCK:
                {
                    Recorder.pushAction(param4);
                    if (param3 == 0)
                    {
                        var _loc_5:* = true;
                        param1.opening = true;
                    }
                    else
                    {
                        var _loc_5:* = false;
                        param1.opening = false;
                    }
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_INSTANCESCORE:
                {
                    var _loc_5:* = param3;
                    param1.instanceSore = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_HONOR:
                {
                    var _loc_5:* = param3;
                    param1.honor = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.UNIT_MOVE_SPEED_LEVEL:
                {
                    var _loc_5:* = param3;
                    param1.speedLevel = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.DISP_MOVE_SPEED:
                {
                    var _loc_5:* = param3;
                    param1.dispSpeed = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_BALL1:
                {
                    Config.ui._fbEntranceUI.updateFbTime(param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_BALL2:
                {
                    Config.ui._fbEntranceUI.updateFbPayTime(param3);
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_BALL3:
                {
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_BALL4:
                {
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_BALL5:
                {
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_RELIVECOUNT:
                {
                    var _loc_5:* = param3;
                    Config.player.moneyLifeNum = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.UNIT_FIELD_FACTION:
                {
                    var _loc_5:* = param3;
                    param1.monsterCamp = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_AUTOHP_STORE:
                {
                    var _loc_5:* = param3;
                    param1.autoHp = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_AUTOMP_STORE:
                {
                    var _loc_5:* = param3;
                    param1.autoMp = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_ACTIVESCORE:
                {
                    var _loc_5:* = param3;
                    Config.ui._recomPanel.daySc = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_ACTIVESCORE_YDAY:
                {
                    var _loc_5:* = param3;
                    Config.ui._recomPanel.ydaySc = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_ACTGIFT:
                {
                    var _loc_5:* = param3;
                    Config.ui._recomPanel.dayType = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_ACTGIFT_YDAY:
                {
                    var _loc_5:* = param3;
                    Config.ui._recomPanel.ydayType = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_GUILDSCORE:
                {
                    var _loc_5:* = param3;
                    Config.player.gildCoin = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_ESCORTTRA:
                {
                    var _loc_5:* = param3;
                    Config.player.escortra = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_ESCORTROB:
                {
                    var _loc_5:* = param3;
                    Config.player.escortrob = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_ESCORT_STATUS:
                {
                    var _loc_5:* = param3;
                    Config.player.escortstatus = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_FIELD_ESCORT_ENTRYID:
                {
                    var _loc_5:* = param3;
                    Config.player.escortentryId = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_ARENA1V1_SCORE:
                {
                    var _loc_5:* = param3;
                    Config.ui._interPkPanel.pkSource = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_ARENA1V1_TODAY:
                {
                    var _loc_5:* = param3;
                    Config.ui._interPkPanel.DayMoneyNum = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_ARENA1V1_COMBO:
                {
                    var _loc_5:* = param3;
                    Config.ui._interPkPanel.winNum = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_PET_MERGE_TEMP_ATTACK:
                {
                    var _loc_5:* = param3;
                    Config.ui._petPanel.tempAtk = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_PET_MERGE_TEMP_DEFEND:
                {
                    var _loc_5:* = param3;
                    Config.ui._petPanel.tempDef = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_PET_MERGE_TEMP_HP:
                {
                    var _loc_5:* = param3;
                    Config.ui._petPanel.tempHp = param3;
                    break;
                }
                case OBJECT_UPDATE_TYPE_ENUM.PLAYER_PET_MERGE_TEMP_MP:
                {
                    var _loc_5:* = param3;
                    Config.ui._petPanel.tempMp = param3;
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private static function getAppear(param1:ByteArray)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = {};
            var _loc_4:* = param1.readByte();
            _loc_2.death = param1.readByte();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_3 = param1.readUnsignedShort();
            var _loc_4:* = param1.readUTFBytes(_loc_3);
            _loc_2.name = param1.readUTFBytes(_loc_3);
            var _loc_4:* = param1.readUnsignedShort();
            _loc_2.titleId = param1.readUnsignedShort();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_3 = param1.readUnsignedShort();
            var _loc_4:* = param1.readUTFBytes(_loc_3);
            _loc_2.guildName = param1.readUTFBytes(_loc_3);
            var _loc_4:* = param1.readByte();
            _loc_2.job = param1.readByte();
            var _loc_4:* = param1.readByte();
            _loc_2.sex = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.hp = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.hpMax = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.mp = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.mpMax = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_2.level = param1.readUnsignedShort();
            var _loc_4:* = param1.readByte();
            _loc_2.fighting = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.speed = param1.readUnsignedInt();
            var _loc_4:* = param1.readByte();
            _loc_2.isTeamLeader = param1.readByte();
            var _loc_4:* = param1.readByte();
            _loc_2.pkmode = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.weaponId = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.clothId = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.horseId = param1.readUnsignedInt();
            var _loc_4:* = param1.readByte();
            _loc_2.horseStar = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.wingId = param1.readUnsignedInt();
            var _loc_4:* = param1.readByte();
            _loc_2.wingStar = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.avatarId = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.avatarColor = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.hair = param1.readUnsignedInt();
            var _loc_4:* = param1.readByte();
            _loc_2.booth = param1.readByte();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_3 = param1.readUnsignedShort();
            var _loc_4:* = param1.readUTFBytes(_loc_3);
            _loc_2.boothNote = param1.readUTFBytes(_loc_3);
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.guildId = param1.readUnsignedInt();
            var _loc_4:* = param1.readByte();
            _loc_2.guildPower = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.camp = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.gildTeam = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.warTeam = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedByte();
            _loc_2.elementID = param1.readUnsignedByte();
            var _loc_4:* = param1.readUnsignedByte();
            _loc_2.elementLevel = param1.readUnsignedByte();
            return _loc_2;
        }// end function

        private static function getStandStill(param1:ByteArray)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = {};
            var _loc_4:* = param1.readByte();
            _loc_2.standStillType = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.standStillPeriod = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.standStillTimeLeft = param1.readUnsignedInt();
            return _loc_2;
        }// end function

        private static function getWalk(param1:ByteArray)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = {};
            var _loc_4:* = param1.readByte();
            _loc_2.walkFlag = param1.readByte();
            var _loc_4:* = param1.readUnsignedInt();
            _loc_2.time = param1.readUnsignedInt();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_2.x = param1.readUnsignedShort();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_2.y = param1.readUnsignedShort();
            var _loc_4:* = param1.readFloat();
            _loc_2.angle = param1.readFloat();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_2.desX = param1.readUnsignedShort();
            var _loc_4:* = param1.readUnsignedShort();
            _loc_2.desY = param1.readUnsignedShort();
            return _loc_2;
        }// end function

    }
}
