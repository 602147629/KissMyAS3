package lovefox.game
{
    import flash.events.*;
    import flash.net.*;

    public class Bard extends Object
    {
        public static var LOCAL_TALE:uint = 0;
        public static var KILL_BOSS:uint = 1;
        public static var KILL_MONSTER:uint = 2;
        public static var TRAPPED:uint = 3;
        private static var _callBack:Function;
        private static var _loader:URLLoader;
        private static var _reqVar:URLVariables;
        private static var _npcid:Object;
        private static var _killMonsterCount:int = 0;
        private static var _killMonsterType:int = 0;
        private static var _preKillMonsterType:int = 0;
        private static var _beKillCount:int = 0;
        private static var _beKillType:int = 0;
        private static var _regExp1:RegExp = /[$]+name""[$]+name/g;
        private static var _regExp2:RegExp = /[$]+job""[$]+job/g;
        private static var _regExp3:RegExp = /[$]+weapon""[$]+weapon/g;
        private static var _regExp4:RegExp = /[$]+title""[$]+title/g;
        private static var _regExp5:RegExp = /[$]+monster""[$]+monster/g;
        private static var _regExp6:RegExp = /[$]+map""[$]+map/g;
        private static var _regExp7:RegExp = /[$]+he""[$]+he/g;
        private static var _regExp8:RegExp = /[$]+teamname""[$]+teamname/g;
        private static var _regExp9:RegExp = /[$]+teamtitle""[$]+teamtitle/g;
        private static var _regExp10:RegExp = /[$]+teamall""[$]+teamall/g;
        private static var _regExp11:RegExp = /[$]+teamnumber""[$]+teamnumber/g;
        public static var _bardMusicList:Array = ["stuff/music/bgm022.mp3", "stuff/music/bgm001.mp3", "stuff/music/bgm003.mp3", "stuff/music/bgm005.mp3", "stuff/music/bgm006.mp3", "stuff/music/bgm010.mp3", "stuff/music/bgm014.mp3", "stuff/music/bgm015.mp3", "stuff/music/bgm016.mp3", "stuff/music/bgm017.mp3", "stuff/music/bgm019.mp3"];

        public function Bard()
        {
            return;
        }// end function

        public static function clear()
        {
            _killMonsterCount = 0;
            return;
        }// end function

        public static function killMon(param1)
        {
            if (_preKillMonsterType == param1)
            {
                return;
            }
            if (_killMonsterType != param1)
            {
                _killMonsterType = param1;
            }
            else
            {
                var _loc_3:* = _killMonsterCount + 1;
                _killMonsterCount = _loc_3;
            }
            if (_killMonsterCount >= 1000)
            {
                _killMonsterCount = 0;
                _preKillMonsterType = _killMonsterType;
                record(KILL_MONSTER, param1);
            }
            return;
        }// end function

        public static function killBoss(param1)
        {
            record(KILL_BOSS, param1);
            return;
        }// end function

        public static function beKill(param1)
        {
            return;
        }// end function

        public static function getBard(param1, param2)
        {
            var _loc_3:* = undefined;
            _npcid = param1;
            _callBack = param2;
            if (_loader == null)
            {
                _loader = new URLLoader();
                _loader.addEventListener(IOErrorEvent.IO_ERROR, getErrorHandler);
                _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, getErrorHandler);
                _loader.addEventListener(Event.COMPLETE, getCompleteHandler);
                _reqVar = new URLVariables();
                _reqVar.server = Config.serverName;
            }
            var _loc_4:* = new URLRequest(Config.bardURL + "bard_get.php?ran=" + Math.floor(Math.random() * 1000));
            new URLRequest(Config.bardURL + "bard_get.php?ran=" + Math.floor(Math.random() * 1000)).data = _reqVar;
            _loc_4.method = URLRequestMethod.POST;
            _loader.load(_loc_4);
            return;
        }// end function

        private static function getCompleteHandler(event:Event) : void
        {
            var song:*;
            var msg:*;
            var music:*;
            var name:*;
            var type:*;
            var param:*;
            var info:*;
            var event:* = event;
            if (Config.debug)
            {
                Config.ui._chatUI.showSys(String(event.target.data));
            }
            var xml:* = XML(event.target.data);
            var rs:* = Number(xml.rs);
            if (rs == 2)
            {
                msg = String(xml.msg);
                music = String(xml.music);
                name = String(xml.name);
                _callBack(["现在是<t:" + name + ",cc0000>的点播:"].concat(msg.split("|")), music, "sing", true, Number(xml.effect));
            }
            else if (rs == 1)
            {
                if (Math.random() < 0.5)
                {
                    song = getSong(_npcid, LOCAL_TALE, 0);
                    _callBack(song.tale, song.music, song.action);
                }
                else
                {
                    type = Number(xml.type);
                    param = Number(xml.param);
                    try
                    {
                        info = JSON.decode(String(xml.info));
                        song = getSong(_npcid, type, param, info);
                        _callBack(song.tale, song.music, song.action);
                    }
                    catch (e)
                    {
                        song = getSong(_npcid, LOCAL_TALE, 0);
                        _callBack(song.tale, song.music, song.action);
                        return;
                    }
                }
            }
            else
            {
                song = getSong(_npcid, LOCAL_TALE, 0);
                _callBack(song.tale, song.music, song.action);
            }
            return;
        }// end function

        private static function getSong(param1, param2, param3, param4 = null)
        {
            var _loc_7:* = undefined;
            var _loc_10:* = null;
            var _loc_5:* = Config._bardSong[param2][param3];
            if (Config._bardSong[param2][param3] == null)
            {
                _loc_5 = Config._bardSong[param2][0];
                if (_loc_5 == null)
                {
                    return null;
                }
            }
            var _loc_6:* = _loc_5[Math.floor(_loc_5.length * Math.random())];
            var _loc_8:* = _loc_5[Math.floor(_loc_5.length * Math.random())].tale.split("|");
            if (param4 != null)
            {
                if (param4.team != null)
                {
                    if (_loc_6.team != null && _loc_6.team != "")
                    {
                        _loc_8 = _loc_8.concat(_loc_6.team.split("|"));
                    }
                    else if (_loc_6.solo != null && _loc_6.solo != "")
                    {
                        _loc_8 = _loc_8.concat(_loc_6.solo.split("|"));
                    }
                }
                else if (_loc_6.solo != null && _loc_6.solo != "")
                {
                    _loc_8 = _loc_8.concat(_loc_6.solo.split("|"));
                }
            }
            var _loc_9:* = [];
            _loc_7 = 0;
            while (_loc_7 < _loc_8.length)
            {
                
                _loc_10 = _loc_8[_loc_7];
                if (param4 != null)
                {
                    _loc_10 = _loc_10.replace(_regExp1, "<t:" + getName(param4) + ",cc0000>");
                    _loc_10 = _loc_10.replace(_regExp2, getJob(param4));
                    _loc_10 = _loc_10.replace(_regExp3, "<t:" + getWeapon(param4) + ",cc0000>");
                    _loc_10 = _loc_10.replace(_regExp4, "<t:" + getTitle(param4) + ",cc0000>");
                    _loc_10 = _loc_10.replace(_regExp5, "<t:" + getMonster(param3) + ",cc0000>");
                    _loc_10 = _loc_10.replace(_regExp6, "<t:" + getMap(param4) + ",cc0000>");
                    _loc_10 = _loc_10.replace(_regExp7, getHe(param4));
                    _loc_10 = _loc_10.replace(_regExp8, getTeamName(param4));
                    _loc_10 = _loc_10.replace(_regExp9, getTeamTitle(param4));
                    _loc_10 = _loc_10.replace(_regExp10, getTeamTitleName(param4));
                    _loc_10 = _loc_10.replace(_regExp11, getTeamNumber(param4));
                }
                _loc_9.push(_loc_10);
                _loc_7 = _loc_7 + 1;
            }
            var _loc_11:* = "stuff/music/bard/" + _loc_6.music + ".mp3";
            var _loc_12:* = _loc_6.action;
            return {tale:_loc_9, music:null, action:_loc_12};
        }// end function

        private static function getTeamNumber(param1)
        {
            if (param1.team != null)
            {
                if (param1.team.length == 1)
                {
                    return Config.language("Bard", 1);
                }
                if (param1.team.length == 2)
                {
                    return Config.language("Bard", 2);
                }
                if (param1.team.length == 3)
                {
                    return Config.language("Bard", 3);
                }
                if (param1.team.length == 4)
                {
                    return Config.language("Bard", 4);
                }
                return Config.language("Bard", 5);
            }
            else
            {
                return Config.language("Bard", 5);
            }
        }// end function

        private static function getTeamName(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (param1.team != null)
            {
                _loc_3 = "<t:" + param1.name + ",cc0000>";
                _loc_2 = 0;
                while (_loc_2 < param1.team.length)
                {
                    
                    if (_loc_2 == (param1.team.length - 1))
                    {
                        _loc_3 = _loc_3 + (Config.language("Bard", 6) + "<t:" + param1.team[_loc_2].name + ",cc0000>");
                    }
                    else
                    {
                        _loc_3 = _loc_3 + ("、" + "<t:" + param1.team[_loc_2].name + ",cc0000>");
                    }
                    _loc_2 = _loc_2 + 1;
                }
                return _loc_3;
            }
            else
            {
                return "";
            }
        }// end function

        private static function getTeamTitle(param1)
        {
            return getTeamTitleName(param1);
        }// end function

        private static function getTeamTitleName(param1)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            if (param1.team != null)
            {
                _loc_3 = "<t:" + getTitle(param1) + " " + param1.name + ",cc0000>";
                _loc_2 = 0;
                while (_loc_2 < param1.team.length)
                {
                    
                    if (_loc_2 == (param1.team.length - 1))
                    {
                        _loc_3 = _loc_3 + (Config.language("Bard", 6) + "<t:" + getTitle(param1.team[_loc_2]) + " " + param1.team[_loc_2].name + ",cc0000>");
                    }
                    else
                    {
                        _loc_3 = _loc_3 + ("、" + "<t:" + getTitle(param1.team[_loc_2]) + " " + param1.team[_loc_2].name + ",cc0000>");
                    }
                    _loc_2 = _loc_2 + 1;
                }
                return _loc_3;
            }
            else
            {
                return "";
            }
        }// end function

        private static function getName(param1)
        {
            return param1.name;
        }// end function

        private static function getWeapon(param1)
        {
            if (param1.weapon == null)
            {
                return Config.language("Bard", 7);
            }
            return Config._itemMap[param1.weapon].name;
        }// end function

        private static function getJob(param1)
        {
            return Config._jobTitleMap[param1.job];
        }// end function

        public static function getPlayerTitle()
        {
            return getTitle(Config.player);
        }// end function

        private static function getTitle(param1)
        {
            switch(param1.job)
            {
                case 1:
                {
                    if (param1.sex == 1)
                    {
                        if (param1.level < 20)
                        {
                            return Config.language("Bard", 8);
                        }
                        if (param1.level < 30)
                        {
                            return Config.language("Bard", 9);
                        }
                        if (param1.level < 40)
                        {
                            return Config.language("Bard", 10);
                        }
                        if (param1.level < 50)
                        {
                            return Config.language("Bard", 11);
                        }
                        if (param1.level < 60)
                        {
                            return Config.language("Bard", 12);
                        }
                        if (param1.level < 70)
                        {
                            return Config.language("Bard", 13);
                        }
                        if (param1.level < 80)
                        {
                            return Config.language("Bard", 14);
                        }
                        if (param1.level < 90)
                        {
                            return Config.language("Bard", 15);
                        }
                        if (param1.level == 100)
                        {
                            return Config.language("Bard", 16);
                        }
                    }
                    else if (param1.sex == 2)
                    {
                        if (param1.level < 20)
                        {
                            return Config.language("Bard", 8);
                        }
                        if (param1.level < 30)
                        {
                            return Config.language("Bard", 9);
                        }
                        if (param1.level < 40)
                        {
                            return Config.language("Bard", 17);
                        }
                        if (param1.level < 50)
                        {
                            return Config.language("Bard", 18);
                        }
                        if (param1.level < 60)
                        {
                            return Config.language("Bard", 19);
                        }
                        if (param1.level < 70)
                        {
                            return Config.language("Bard", 20);
                        }
                        if (param1.level < 80)
                        {
                            return Config.language("Bard", 21);
                        }
                        if (param1.level < 90)
                        {
                            return Config.language("Bard", 22);
                        }
                        if (param1.level == 100)
                        {
                            return Config.language("Bard", 23);
                        }
                    }
                    break;
                }
                case 4:
                {
                    if (param1.sex == 1)
                    {
                        if (param1.level < 20)
                        {
                            return Config.language("Bard", 8);
                        }
                        if (param1.level < 30)
                        {
                            return Config.language("Bard", 24);
                        }
                        if (param1.level < 40)
                        {
                            return Config.language("Bard", 25);
                        }
                        if (param1.level < 50)
                        {
                            return Config.language("Bard", 26);
                        }
                        if (param1.level < 60)
                        {
                            return Config.language("Bard", 27);
                        }
                        if (param1.level < 70)
                        {
                            return Config.language("Bard", 28);
                        }
                        if (param1.level < 80)
                        {
                            return Config.language("Bard", 29);
                        }
                        if (param1.level < 90)
                        {
                            return Config.language("Bard", 30);
                        }
                        if (param1.level == 100)
                        {
                            return Config.language("Bard", 57);
                        }
                    }
                    else if (param1.sex == 2)
                    {
                        if (param1.level < 20)
                        {
                            return Config.language("Bard", 8);
                        }
                        if (param1.level < 30)
                        {
                            return Config.language("Bard", 24);
                        }
                        if (param1.level < 40)
                        {
                            return Config.language("Bard", 31);
                        }
                        if (param1.level < 50)
                        {
                            return Config.language("Bard", 32);
                        }
                        if (param1.level < 60)
                        {
                            return Config.language("Bard", 33);
                        }
                        if (param1.level < 70)
                        {
                            return Config.language("Bard", 34);
                        }
                        if (param1.level < 80)
                        {
                            return Config.language("Bard", 35);
                        }
                        if (param1.level < 90)
                        {
                            return Config.language("Bard", 36);
                        }
                        if (param1.level == 100)
                        {
                            return Config.language("Bard", 37);
                        }
                    }
                    break;
                }
                case 7:
                {
                    break;
                }
                case 10:
                {
                    if (param1.sex == 1)
                    {
                        if (param1.level < 20)
                        {
                            return Config.language("Bard", 8);
                        }
                        if (param1.level < 30)
                        {
                            return Config.language("Bard", 38);
                        }
                        if (param1.level < 40)
                        {
                            return Config.language("Bard", 39);
                        }
                        if (param1.level < 50)
                        {
                            return Config.language("Bard", 40);
                        }
                        if (param1.level < 60)
                        {
                            return Config.language("Bard", 41);
                        }
                        if (param1.level < 70)
                        {
                            return Config.language("Bard", 42);
                        }
                        if (param1.level < 80)
                        {
                            return Config.language("Bard", 43);
                        }
                        if (param1.level < 90)
                        {
                            return Config.language("Bard", 44);
                        }
                        if (param1.level == 100)
                        {
                            return Config.language("Bard", 45);
                        }
                    }
                    else if (param1.sex == 2)
                    {
                        if (param1.level < 20)
                        {
                            return Config.language("Bard", 8);
                        }
                        if (param1.level < 30)
                        {
                            return Config.language("Bard", 46);
                        }
                        if (param1.level < 40)
                        {
                            return Config.language("Bard", 47);
                        }
                        if (param1.level < 50)
                        {
                            return Config.language("Bard", 48);
                        }
                        if (param1.level < 60)
                        {
                            return Config.language("Bard", 49);
                        }
                        if (param1.level < 70)
                        {
                            return Config.language("Bard", 50);
                        }
                        if (param1.level < 80)
                        {
                            return Config.language("Bard", 51);
                        }
                        if (param1.level < 90)
                        {
                            return Config.language("Bard", 52);
                        }
                        if (param1.level == 100)
                        {
                            return Config.language("Bard", 53);
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return Config._jobTitleMap[param1.job];
        }// end function

        private static function getMonster(param1)
        {
            return Config._monsterMap[Number(param1)].name;
        }// end function

        private static function getHe(param1)
        {
            if (param1.sex == 1)
            {
                return Config.language("Bard", 54);
            }
            return Config.language("Bard", 55);
        }// end function

        private static function getMap(param1)
        {
            var info:* = param1;
            try
            {
                return Config._mapMap[info.map].mapData.name;
            }
            catch (e)
            {
                return Config.language("Bard", 56);
            }
            return;
        }// end function

        private static function getErrorHandler(event:Event) : void
        {
            trace("getErrorHandler", event.target.data);
            return;
        }// end function

        public static function record(param1, param2)
        {
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_3:* = {};
            _loc_3.type = param1;
            _loc_3.id = param2;
            _loc_3.map = Config.map.id;
            _loc_3.name = Config.player.name;
            _loc_3.level = Config.player.level;
            _loc_3.job = Config.player.job;
            _loc_3.sex = Config.player.sex;
            _loc_3.weapon = Config.player.weaponId;
            var _loc_4:* = Config.ui._teamUI.getTeamArr();
            var _loc_7:* = Unit.getPlayerlist();
            _loc_6 = [];
            _loc_5 = 0;
            while (_loc_5 < _loc_4.length)
            {
                
                if (_loc_4[_loc_5].name != Config.player.name)
                {
                    _loc_7 = _loc_4[_loc_5];
                    _loc_6.push({name:_loc_7.name, level:_loc_7.level, job:_loc_7.job, sex:_loc_7.sex});
                }
                _loc_5 = _loc_5 + 1;
            }
            if (_loc_6.length > 0)
            {
                _loc_3.team = _loc_6;
            }
            var _loc_8:* = JSON.encode(_loc_3);
            var _loc_9:* = new URLVariables();
            new URLVariables().type = param1;
            _loc_9.param = param2;
            _loc_9.info = _loc_8;
            _loc_9.server = Config.serverName;
            var _loc_10:* = new URLRequest(Config.bardURL + "bard_record.php");
            new URLRequest(Config.bardURL + "bard_record.php").data = _loc_9;
            _loc_10.method = URLRequestMethod.POST;
            var _loc_11:* = new URLLoader();
            new URLLoader().addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            _loc_11.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            _loc_11.addEventListener(Event.COMPLETE, completeHandler);
            _loc_11.load(_loc_10);
            return;
        }// end function

        private static function completeHandler(event:Event) : void
        {
            return;
        }// end function

        private static function errorHandler(event:Event) : void
        {
            event.target.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            trace("errorHandler", event.target.data);
            return;
        }// end function

    }
}
