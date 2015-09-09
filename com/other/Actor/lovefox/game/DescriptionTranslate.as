package lovefox.game
{
    import flash.events.*;
    import flash.net.*;
    import flash.text.*;
    import lovefox.socket.*;
    import lovefox.unit.*;

    public class DescriptionTranslate extends Object
    {

        public function DescriptionTranslate()
        {
            return;
        }// end function

        public static function handleTextClick(event:TextEvent = null, param2:String = "")
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = [];
            if (event == null)
            {
                _loc_3 = param2.split(":");
            }
            else
            {
                _loc_3 = event.text.split(":");
            }
            var _loc_4:* = String(_loc_3[0]);
            var _loc_5:* = Number(_loc_3[1]);
            switch(_loc_4)
            {
                case "monster":
                {
                    if (_loc_5 == 50009)
                    {
                        Hang.hangMonster(70025);
                    }
                    else
                    {
                        Hang.hangMonster(_loc_5);
                    }
                    break;
                }
                case "gather":
                {
                    Hang.hangGather(_loc_5);
                    break;
                }
                case "item":
                {
                    if (_loc_5 == 10002)
                    {
                        Hang.hangNpc(30001);
                    }
                    else if (_loc_5 == 60011)
                    {
                        Hang.hangMonster(10002);
                    }
                    else if (_loc_5 == 60013)
                    {
                        Hang.hangGather(5001);
                    }
                    else if (_loc_5 == 29001)
                    {
                        Config.ui._producepanel.showItem(1004);
                    }
                    else if (_loc_5 == 26001)
                    {
                        Config.ui._producepanel.showItem(1005);
                    }
                    else if (_loc_5 == 25001)
                    {
                        Config.ui._producepanel.showItem(1006);
                    }
                    else if (_loc_5 == 27001)
                    {
                        Config.ui._producepanel.showItem(1007);
                    }
                    else if (_loc_5 == 23001)
                    {
                        Config.ui._producepanel.showItem(1008);
                    }
                    else if (_loc_5 == 24001)
                    {
                        Config.ui._producepanel.showItem(1009);
                    }
                    else if (_loc_5 == 22001)
                    {
                        Config.ui._producepanel.showItem(1010);
                    }
                    else if (_loc_5 == 28001)
                    {
                        Config.ui._producepanel.showItem(1011);
                    }
                    else if (_loc_5 == 21101)
                    {
                        Config.ui._producepanel.showItem(1001);
                    }
                    else if (_loc_5 == 21401)
                    {
                        Config.ui._producepanel.showItem(1002);
                    }
                    else if (_loc_5 == 21201)
                    {
                        Config.ui._producepanel.showItem(1003);
                    }
                    else if (_loc_5 == 61001)
                    {
                        Config.ui._producepanel.showItem(300000);
                    }
                    else if (_loc_5 == 21130)
                    {
                        Config.ui._producepanel.showItem(3000);
                    }
                    else if (_loc_5 == 21230)
                    {
                        Config.ui._producepanel.showItem(3032);
                    }
                    else if (_loc_5 == 21430)
                    {
                        Config.ui._producepanel.showItem(3064);
                    }
                    break;
                }
                case "npc":
                {
                    Hang.hangNpc(_loc_5);
                    break;
                }
                case "map":
                {
                    Hang.hangMap(_loc_5);
                }
                case "link":
                {
                    _loc_6 = "";
                    if (Number(_loc_5) == 646)
                    {
                        _loc_6 = Config._ogfs;
                    }
                    else if (Number(_loc_5) == 647)
                    {
                        _loc_6 = Config._credits;
                    }
                    else if (Number(_loc_5) == 648)
                    {
                        _loc_6 = Config._bandemail;
                    }
                    else if (Number(_loc_5) == 649)
                    {
                        _loc_6 = Config._bandmobile;
                    }
                    _loc_7 = new URLRequest(_loc_6);
                    navigateToURL(_loc_7);
                    break;
                }
                case "check":
                {
                    _loc_8 = new DataSet();
                    _loc_8.addHead(CONST_ENUM.C2G_QUEST_FCM_QUERY);
                    _loc_8.add32(_loc_5);
                    ClientSocket.send(_loc_8);
                    Config.message(Config.language("DescriptionTranslate", 1));
                    break;
                }
                case "task":
                {
                    Config.ui._taskpanel.opendaytask(Number(_loc_5));
                    break;
                }
                case "holdwar":
                {
                    Config.ui._gildwar.gildwarauction();
                    break;
                }
                case "hotLink":
                {
                    switch(int(_loc_5))
                    {
                        case 10001:
                        {
                            Config.ui._blackmarket.open();
                            Config.ui._blackmarket.panelb();
                            break;
                        }
                        case 11003:
                        case 11004:
                        case 11005:
                        {
                            Config.ui._gildwar.gildwarauction();
                            break;
                        }
                        case 12001:
                        case 12002:
                        {
                            Config.ui._activePanel.setPosition(20);
                            break;
                        }
                        case 13001:
                        case 13002:
                        case 13003:
                        case 13004:
                        case 13005:
                        case 13006:
                        {
                            AlertUI.alert(Config.language("DescriptionTranslate", 2), Config.language("DescriptionTranslate", 6), [Config.language("DescriptionTranslate", 4), Config.language("DescriptionTranslate", 5)], [goThere, null], {npc:60008});
                            break;
                        }
                        case 14001:
                        case 14002:
                        {
                            Config.ui._radar.entermap();
                            break;
                        }
                        case 15001:
                        case 15002:
                        case 15003:
                        case 15004:
                        case 15005:
                        case 15006:
                        case 15007:
                        case 15008:
                        {
                            Config.ui._activePanel.setPosition(52);
                            break;
                        }
                        case 15101:
                        case 15102:
                        {
                            Config.ui._activePanel.setPosition(12);
                            break;
                        }
                        case 15201:
                        case 15202:
                        case 15203:
                        {
                            AlertUI.alert(Config.language("DescriptionTranslate", 2), Config.language("DescriptionTranslate", 9), [Config.language("DescriptionTranslate", 4), Config.language("DescriptionTranslate", 5)], [goThere, null], {npc:60007});
                            break;
                        }
                        case 15401:
                        {
                            Config.ui._bigWar.onwar();
                            break;
                        }
                        case 91001:
                        case 91002:
                        {
                            Config.ui._activePanel.setPosition(65);
                            break;
                        }
                        case 17001:
                        case 17002:
                        {
                            Config.ui._activePanel.setPosition(78);
                            break;
                        }
                        case 90006:
                        {
                            Config.ui._activePanel.setPosition(100);
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public static function replace(param1:String, param2:int, param3:String) : String
        {
            var _loc_4:* = /%a""%a/g;
            switch(param2)
            {
                case 0:
                {
                    _loc_4 = /%a""%a/g;
                    break;
                }
                case 1:
                {
                    _loc_4 = /%b""%b/g;
                    break;
                }
                case 2:
                {
                    _loc_4 = /%c""%c/g;
                    break;
                }
                case 3:
                {
                    _loc_4 = /%d""%d/g;
                    break;
                }
                default:
                {
                    break;
                }
            }
            param1 = param1.replace(_loc_4, param3);
            return translate(param1);
        }// end function

        public static function translate(param1:String, param2:TextField = null) : String
        {
            var section:String;
            var cmd:String;
            var param:String;
            var newSection:String;
            var str:* = param1;
            var tf:* = param2;
            if (str == null)
            {
                return null;
            }
            var beginPos:int;
            var count:uint;
            if (tf != null)
            {
                tf.removeEventListener(TextEvent.LINK, handleTextClick);
                tf.addEventListener(TextEvent.LINK, handleTextClick);
            }
            do
            {
                
                count = (count + 1);
                section = str.substring(beginPos, (str.indexOf("|", (beginPos + 1)) + 1));
                if (section.indexOf(":") != -1)
                {
                    cmd = str.substring((beginPos + 1), str.indexOf(":", (beginPos + 1)));
                    param = str.substring((str.indexOf(":", beginPos) + 1), str.indexOf("|", (beginPos + 1)));
                }
                else
                {
                    cmd = str.substring((beginPos + 1), str.indexOf("|", (beginPos + 1)));
                }
                try
                {
                    switch(cmd)
                    {
                        case "monster":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(String(Config._monsterMap[Number(param)].name), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, String(Config._monsterMap[Number(param)].name));
                            }
                            break;
                        }
                        case "gather":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(String(Config._gatherMap[Number(param)].name), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, String(Config._gatherMap[Number(param)].name));
                            }
                            break;
                        }
                        case "item":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(String(Config._itemMap[Number(param)].name), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, String(Config._itemMap[Number(param)].name));
                            }
                            break;
                        }
                        case "npc":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(String(Config._npcMap[Number(param)].name), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, String(Config._npcMap[Number(param)].name));
                            }
                            break;
                        }
                        case "map":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(String(Config._mapMap[Number(param)].mapData.name), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, String(Config._mapMap[Number(param)].mapData.name));
                            }
                            break;
                        }
                        case "player_name":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, "<font color=\'#cc0000\'><b>" + Player.name + "</b></font>");
                            }
                            else
                            {
                                str = str.replace(section, Player.name);
                            }
                            break;
                        }
                        case "player_title":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, "<font color=\'#cc0000\'><b>" + Player.title + "</b></font>");
                            }
                            else
                            {
                                str = str.replace(section, Player.title);
                            }
                            break;
                        }
                        case "player_job":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, "<font color=\'#cc0000\'><b>" + Player.job + "</b></font>");
                            }
                            else
                            {
                                str = str.replace(section, Player.job);
                            }
                            break;
                        }
                        case "player_sex":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, "<font color=\'#cc0000\'><b>" + Player.sex + "</b></font>");
                            }
                            else
                            {
                                str = str.replace(section, Player.sex);
                            }
                            break;
                        }
                        case "link":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 10), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, Config.language("DescriptionTranslate", 10));
                            }
                            break;
                        }
                        case "check":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 11), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, Config.language("DescriptionTranslate", 11));
                            }
                            break;
                        }
                        case "task":
                        {
                            if (tf != null)
                            {
                                if (Number(param) == 17 || Number(param) == 18)
                                {
                                    str = str.replace(section, TextLink.link(String(Config._recomList[Number(param)].name), cmd + ":" + param));
                                }
                                else
                                {
                                    str = str.replace(section, TextLink.link(String(Config._taskMap[Number(param)].title), cmd + ":" + param));
                                }
                            }
                            break;
                        }
                        case "holdwar":
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 10), cmd + ":" + param));
                            }
                            else
                            {
                                str = str.replace(section, Config.language("DescriptionTranslate", 10));
                            }
                            break;
                        }
                        case "hotLink":
                        {
                            switch(int(param))
                            {
                                case 10001:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 12), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 12));
                                    }
                                    break;
                                }
                                case 11003:
                                case 11004:
                                case 11005:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 13), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 13));
                                    }
                                    break;
                                }
                                case 12001:
                                case 12002:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 14), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 14));
                                    }
                                    break;
                                }
                                case 13001:
                                case 13002:
                                case 13003:
                                case 13004:
                                case 13005:
                                case 13006:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 15), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 15));
                                    }
                                    break;
                                }
                                case 14001:
                                case 14002:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 169), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 169));
                                    }
                                    break;
                                }
                                case 15001:
                                case 15002:
                                case 15003:
                                case 15004:
                                case 15005:
                                case 15006:
                                case 15007:
                                case 15008:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 16), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 16));
                                    }
                                    break;
                                }
                                case 15101:
                                case 15102:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 17), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 17));
                                    }
                                    break;
                                }
                                case 15201:
                                case 15202:
                                case 15203:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 18), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 18));
                                    }
                                    break;
                                }
                                case 15401:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 19), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 19));
                                    }
                                    break;
                                }
                                case 91001:
                                case 91002:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 178), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 178));
                                    }
                                    break;
                                }
                                case 17001:
                                case 17002:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 209), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 209));
                                    }
                                    break;
                                }
                                case 90006:
                                {
                                    if (tf != null)
                                    {
                                        str = str.replace(section, TextLink.link(Config.language("DescriptionTranslate", 231), cmd + ":" + param));
                                    }
                                    else
                                    {
                                        str = str.replace(section, Config.language("DescriptionTranslate", 231));
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
                        default:
                        {
                            if (tf != null)
                            {
                                str = str.replace(section, "");
                            }
                            else
                            {
                                str = str.replace(section, "");
                            }
                            break;
                            break;
                        }
                    }
                }
                catch (e)
                {
                }
                var _loc_4:* = str.indexOf("|");
                beginPos = str.indexOf("|");
            }while (_loc_4 != -1 && count < 10)
            return str;
        }// end function

        public static function transSystem(param1:String)
        {
            var _loc_2:* = null;
            var _loc_4:* = undefined;
            var _loc_5:* = undefined;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            _loc_2 = param1.substring(5).split("|");
            var _loc_3:* = Number(_loc_2[0]);
            switch(_loc_3)
            {
                case 10001:
                {
                    return Config.language("DescriptionTranslate", 20);
                }
                case 10002:
                {
                    return Config.language("DescriptionTranslate", 21, Number(_loc_2[1]));
                }
                case 11001:
                {
                    return Config.language("DescriptionTranslate", 22, String(Config._warplist[Number(_loc_2[1])].name));
                }
                case 11002:
                {
                    return Config.language("DescriptionTranslate", 23, String(Config._warplist[Number(_loc_2[1])].name));
                }
                case 11003:
                {
                    return Config.language("DescriptionTranslate", 26);
                }
                case 11004:
                {
                    return Config.language("DescriptionTranslate", 27);
                }
                case 11005:
                {
                    return Config.language("DescriptionTranslate", 28);
                }
                case 11006:
                {
                    return Config.language("DescriptionTranslate", 29);
                }
                case 11007:
                {
                    return Config.language("DescriptionTranslate", 30, _loc_2[1], String(Config._warplist[Number(_loc_2[2])].name));
                }
                case 11008:
                {
                    return Config.language("DescriptionTranslate", 31, _loc_2[1], String(Config._warplist[Number(_loc_2[2])].name));
                }
                case 11009:
                {
                    return Config.language("DescriptionTranslate", 32, getWeek(Number(_loc_2[1])));
                }
                case 11010:
                {
                    return Config.language("DescriptionTranslate", 33, _loc_2[1], _loc_2[2], String(Config._warplist[Number(_loc_2[3])].name));
                }
                case 11011:
                {
                    return Config.language("DescriptionTranslate", 38);
                }
                case 11012:
                {
                    return Config.language("DescriptionTranslate", 3, _loc_2[1], String(Config._warplist[Number(_loc_2[2])].name));
                }
                case 12001:
                {
                    return Config.language("DescriptionTranslate", 40);
                }
                case 12002:
                {
                    if (Config.player.level >= 15)
                    {
                        _loc_6 = new Object();
                        _loc_6.type = 7;
                        _loc_6.fname = "active";
                        _loc_6.timenum = 900;
                        _loc_6.d = {position:30};
                        ListTip.addList(_loc_6);
                    }
                    return Config.language("DescriptionTranslate", 41);
                }
                case 12003:
                {
                    return Config.language("DescriptionTranslate", 42);
                }
                case 12004:
                {
                    return Config.language("DescriptionTranslate", 43);
                }
                case 12005:
                {
                    return Config.language("DescriptionTranslate", 44);
                }
                case 12006:
                {
                    return Config.language("DescriptionTranslate", 45, _loc_2[1]);
                }
                case 13001:
                {
                    return Config.language("DescriptionTranslate", 46);
                }
                case 13002:
                {
                    return Config.language("DescriptionTranslate", 47);
                }
                case 13003:
                {
                    return Config.language("DescriptionTranslate", 48);
                }
                case 13004:
                {
                    return Config.language("DescriptionTranslate", 49);
                }
                case 13005:
                {
                    return Config.language("DescriptionTranslate", 50);
                }
                case 13006:
                {
                    return Config.language("DescriptionTranslate", 51, _loc_2[1]);
                }
                case 14001:
                {
                    return Config.language("DescriptionTranslate", 52);
                }
                case 14002:
                {
                    return Config.language("DescriptionTranslate", 53);
                }
                case 14003:
                {
                    return Config.language("DescriptionTranslate", 54);
                }
                case 14004:
                {
                    return Config.language("DescriptionTranslate", 55);
                }
                case 15001:
                {
                    if (Config.player.level >= 40)
                    {
                        _loc_6 = new Object();
                        _loc_6.type = 7;
                        _loc_6.fname = "active";
                        _loc_6.timenum = 900;
                        _loc_6.d = {position:50};
                        ListTip.addList(_loc_6);
                    }
                    return Config.language("DescriptionTranslate", 56);
                }
                case 15002:
                {
                    return Config.language("DescriptionTranslate", 57);
                }
                case 15003:
                {
                    return Config.language("DescriptionTranslate", 58);
                }
                case 15004:
                {
                    return Config.language("DescriptionTranslate", 59);
                }
                case 15005:
                {
                    if (Config.player.level >= 40)
                    {
                        _loc_6 = new Object();
                        _loc_6.type = 7;
                        _loc_6.fname = "active";
                        _loc_6.timenum = 900;
                        _loc_6.d = {position:50};
                        ListTip.addList(_loc_6);
                    }
                    return Config.language("DescriptionTranslate", 60);
                }
                case 15006:
                {
                    return Config.language("DescriptionTranslate", 61);
                }
                case 15007:
                {
                    return Config.language("DescriptionTranslate", 62);
                }
                case 15008:
                {
                    return Config.language("DescriptionTranslate", 63);
                }
                case 15101:
                {
                    return Config.language("DescriptionTranslate", 64);
                }
                case 15102:
                {
                    if (Config.player.level >= 15)
                    {
                        _loc_6 = new Object();
                        _loc_6.type = 7;
                        _loc_6.fname = "active";
                        _loc_6.timenum = 900;
                        _loc_6.d = {position:0};
                        ListTip.addList(_loc_6);
                    }
                    return Config.language("DescriptionTranslate", 65);
                }
                case 15103:
                {
                    return Config.language("DescriptionTranslate", 66, _loc_2[1]);
                }
                case 15201:
                {
                    return Config.language("DescriptionTranslate", 67);
                }
                case 15202:
                {
                    _loc_6 = new Object();
                    _loc_6.type = 7;
                    _loc_6.fname = "active";
                    _loc_6.timenum = 900;
                    _loc_6.d = {position:0};
                    ListTip.addList(_loc_6);
                    return Config.language("DescriptionTranslate", 68);
                }
                case 15203:
                {
                    return Config.language("DescriptionTranslate", 69);
                }
                case 15204:
                {
                    return Config.language("DescriptionTranslate", 70);
                }
                case 15205:
                {
                    return Config.language("DescriptionTranslate", 71);
                }
                case 15301:
                {
                    return Config.language("DescriptionTranslate", 72, _loc_2[1], _loc_2[2]);
                }
                case 15302:
                {
                    return Config.language("DescriptionTranslate", 73, _loc_2[1], _loc_2[2]);
                }
                case 15303:
                {
                    if (Config.player.warTeam == Number(_loc_2[1]))
                    {
                        return Config.language("DescriptionTranslate", 74);
                    }
                    return Config.language("DescriptionTranslate", 75);
                }
                case 15304:
                {
                    if (Config.player.warTeam == Number(_loc_2[1]))
                    {
                        _loc_4 = Config.language("DescriptionTranslate", 76);
                    }
                    else
                    {
                        _loc_4 = Config.language("DescriptionTranslate", 77);
                    }
                    if (Number(_loc_2[2]) == 61 && Number(_loc_2[3]) == 49)
                    {
                        _loc_5 = Config.language("DescriptionTranslate", 78);
                    }
                    else if (Number(_loc_2[2]) == 21 && Number(_loc_2[3]) == 13)
                    {
                        _loc_5 = Config.language("DescriptionTranslate", 79);
                    }
                    else if (Number(_loc_2[2]) == 86 && Number(_loc_2[3]) == 9)
                    {
                        _loc_5 = Config.language("DescriptionTranslate", 80);
                    }
                    else if (Number(_loc_2[2]) == 9 && Number(_loc_2[3]) == 86)
                    {
                        _loc_5 = Config.language("DescriptionTranslate", 81);
                    }
                    else if (Number(_loc_2[2]) == 84 && Number(_loc_2[3]) == 76)
                    {
                        _loc_5 = Config.language("DescriptionTranslate", 82);
                    }
                    else
                    {
                        _loc_5 = Config.language("DescriptionTranslate", 83);
                    }
                    return Config.language("DescriptionTranslate", 84, _loc_4, _loc_5);
                }
                case 15401:
                {
                    if (Config.player.level >= 40)
                    {
                        _loc_6 = new Object();
                        _loc_6.type = 7;
                        _loc_6.fname = "active";
                        _loc_6.timenum = 900;
                        _loc_6.d = {position:50};
                        ListTip.addList(_loc_6);
                    }
                    return Config.language("DescriptionTranslate", 85);
                }
                case 15402:
                {
                    return Config.language("DescriptionTranslate", 86);
                }
                case 15403:
                {
                    return Config.language("DescriptionTranslate", 87);
                }
                case 15500:
                {
                    return Config.language("DescriptionTranslate", 159, _loc_2[1] + "^" + _loc_2[3] + "^" + _loc_2[5] + "^" + _loc_2[7], _loc_2[2] + "^" + _loc_2[4] + "^" + _loc_2[6] + "^" + _loc_2[8]);
                }
                case 15501:
                {
                    return Config.language("DescriptionTranslate", 160, _loc_2[1] + "^" + _loc_2[3] + "^" + _loc_2[5] + "^" + _loc_2[7], _loc_2[2] + "^" + _loc_2[4] + "^" + _loc_2[6] + "^" + _loc_2[8]);
                }
                case 16001:
                {
                    _loc_6 = new Object();
                    _loc_6.type = 7;
                    _loc_6.fname = "active";
                    _loc_6.timenum = 900;
                    _loc_6.d = {position:100};
                    ListTip.addList(_loc_6);
                    return Config.language("DescriptionTranslate", 161);
                }
                case 16002:
                {
                    return Config.language("DescriptionTranslate", 162);
                }
                case 16003:
                {
                    return Config.language("DescriptionTranslate", 163, _loc_2[1]);
                }
                case 16004:
                {
                    return Config.language("DescriptionTranslate", 164, _loc_2[1]);
                }
                case 16005:
                {
                    return Config.language("DescriptionTranslate", 165, _loc_2[1]);
                }
                case 16008:
                {
                    return Config.language("DescriptionTranslate", 167);
                }
                case 16009:
                {
                    return Config.language("DescriptionTranslate", 168, _loc_2[1]);
                }
                case 16010:
                {
                    return Config.language("DescriptionTranslate", 166, _loc_2[1]);
                }
                case 20001:
                {
                    return Config.language("DescriptionTranslate", 88);
                }
                case 20002:
                {
                    return Config.language("DescriptionTranslate", 89, String(Config._warplist[Number(_loc_2[1])].name));
                }
                case 20003:
                {
                    return Config.language("DescriptionTranslate", 90);
                }
                case 20004:
                {
                    return Config.language("DescriptionTranslate", 91, String(Config._warplist[Number(_loc_2[1])].name));
                }
                case 20005:
                {
                    return Config.language("DescriptionTranslate", 92);
                }
                case 20006:
                {
                    return Config.language("DescriptionTranslate", 93, _loc_2[1], String(Config._warplist[Number(_loc_2[2])].name), _loc_2[3]);
                }
                case 20007:
                {
                    return Config.language("DescriptionTranslate", 94);
                }
                case 20008:
                {
                    return Config.language("DescriptionTranslate", 95, _loc_2[1], _loc_2[2], String(Config._warplist[Number(_loc_2[3])].name), _loc_2[4]);
                }
                case 20009:
                {
                    return Config.language("DescriptionTranslate", 96);
                }
                case 20010:
                {
                    return Config.language("DescriptionTranslate", 97, getJob(Number(_loc_2[1])));
                }
                case 20011:
                {
                    return Config.language("DescriptionTranslate", 98);
                }
                case 20012:
                {
                    return Config.language("DescriptionTranslate", 99, _loc_2[1], _loc_2[2], _loc_2[3]);
                }
                case 20013:
                {
                    return Config.language("DescriptionTranslate", 101);
                }
                case 20014:
                {
                    return Config.language("DescriptionTranslate", 100, _loc_2[1]);
                }
                case 20015:
                {
                    return Config.language("DescriptionTranslate", 102);
                }
                case 20016:
                {
                    return Config.language("DescriptionTranslate", 103, _loc_2[1]);
                }
                case 20017:
                {
                    return Config.language("DescriptionTranslate", 104, _loc_2[1], _loc_2[2], _loc_2[3]);
                }
                case 20101:
                {
                    return Config.language("DescriptionTranslate", 105);
                }
                case 20102:
                {
                    return Config.language("DescriptionTranslate", 106, _loc_2[1], _loc_2[2]);
                }
                case 20103:
                {
                    return Config.language("DescriptionTranslate", 107);
                }
                case 20104:
                {
                    return Config.language("DescriptionTranslate", 108, _loc_2[1]);
                }
                case 20105:
                {
                    return Config.language("DescriptionTranslate", 109);
                }
                case 20106:
                {
                    return Config.language("DescriptionTranslate", 110, _loc_2[1], _loc_2[2]);
                }
                case 20107:
                {
                    return Config.language("DescriptionTranslate", 111);
                }
                case 20108:
                {
                    return Config.language("DescriptionTranslate", 112);
                }
                case 20301:
                {
                    return Config.language("DescriptionTranslate", 113, _loc_2[1]);
                }
                case 20302:
                {
                    return Config.language("DescriptionTranslate", 114);
                }
                case 20303:
                {
                    return Config.language("DescriptionTranslate", 115);
                }
                case 80001:
                {
                    return Config.language("DescriptionTranslate", 116);
                }
                case 80002:
                {
                    return Config.language("DescriptionTranslate", 117);
                }
                case 80003:
                {
                    return Config.language("DescriptionTranslate", 118);
                }
                case 80004:
                {
                    return Config.language("DescriptionTranslate", 119);
                }
                case 20401:
                {
                    return Config.language("DescriptionTranslate", 120);
                }
                case 20402:
                {
                    return Config.language("DescriptionTranslate", 121);
                }
                case 50001:
                {
                    return Config.language("DescriptionTranslate", 122);
                }
                case 50002:
                {
                    return Config.language("DescriptionTranslate", 123);
                }
                case 80005:
                {
                    return Config.language("DescriptionTranslate", 170);
                }
                case 80006:
                {
                    return Config.language("DescriptionTranslate", 171, _loc_2[1]);
                }
                case 90001:
                {
                    return Config.language("DescriptionTranslate", 180);
                }
                case 90002:
                {
                    return Config.language("DescriptionTranslate", 179, _loc_2[1], _loc_2[2]);
                }
                case 90003:
                {
                    return Config.language("DescriptionTranslate", 181);
                }
                case 90004:
                {
                    return Config.language("DescriptionTranslate", 182, _loc_2[1], _loc_2[2], _loc_2[3]);
                }
                case 90005:
                {
                    return Config.language("DescriptionTranslate", 183, _loc_2[1], _loc_2[2], _loc_2[3]);
                }
                case 90006:
                {
                    return Config.language("DescriptionTranslate", 184);
                }
                case 90007:
                {
                    return Config.language("DescriptionTranslate", 185);
                }
                case 90008:
                {
                    return Config.language("DescriptionTranslate", 186, _loc_2[1]);
                }
                case 90009:
                {
                    return Config.language("DescriptionTranslate", 227);
                }
                case 90010:
                {
                    return Config.language("DescriptionTranslate", 228);
                }
                case 90011:
                {
                    return Config.language("DescriptionTranslate", 229, _loc_2[1], _loc_2[2]);
                }
                case 30001:
                {
                    switch(Number(_loc_2[1]))
                    {
                        case 60001:
                        {
                            return Config.language("DescriptionTranslate", 124);
                        }
                        case 60003:
                        {
                            return Config.language("DescriptionTranslate", 125);
                        }
                        case 60005:
                        {
                            return Config.language("DescriptionTranslate", 126);
                        }
                        case 60007:
                        {
                            return Config.language("DescriptionTranslate", 127);
                        }
                        case 60009:
                        {
                            return Config.language("DescriptionTranslate", 128);
                        }
                        case 60011:
                        {
                            return Config.language("DescriptionTranslate", 129);
                        }
                        case 60013:
                        {
                            return Config.language("DescriptionTranslate", 130);
                        }
                        case 60015:
                        {
                            return Config.language("DescriptionTranslate", 131);
                        }
                        case 60017:
                        {
                            return Config.language("DescriptionTranslate", 223);
                        }
                        case 63010:
                        {
                            return Config.language("DescriptionTranslate", 254);
                        }
                        case 63014:
                        {
                            return Config.language("DescriptionTranslate", 261);
                        }
                        case 63015:
                        {
                            return Config.language("DescriptionTranslate", 264);
                        }
                        case 60018:
                        {
                            return Config.language("DescriptionTranslate", 294);
                        }
                        case 60019:
                        {
                            return Config.language("DescriptionTranslate", 297);
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 30002:
                {
                    switch(Number(_loc_2[1]))
                    {
                        case 60001:
                        {
                            return Config.language("DescriptionTranslate", 132);
                        }
                        case 60003:
                        {
                            return Config.language("DescriptionTranslate", 133);
                        }
                        case 60005:
                        {
                            return Config.language("DescriptionTranslate", 134);
                        }
                        case 60007:
                        {
                            return Config.language("DescriptionTranslate", 135);
                        }
                        case 60009:
                        {
                            return Config.language("DescriptionTranslate", 136);
                        }
                        case 60011:
                        {
                            return Config.language("DescriptionTranslate", 137);
                        }
                        case 60013:
                        {
                            return Config.language("DescriptionTranslate", 138);
                        }
                        case 60015:
                        {
                            return Config.language("DescriptionTranslate", 139);
                        }
                        case 60017:
                        {
                            return Config.language("DescriptionTranslate", 224);
                        }
                        case 63010:
                        {
                            return Config.language("DescriptionTranslate", 255);
                        }
                        case 63014:
                        {
                            return Config.language("DescriptionTranslate", 262);
                        }
                        case 63015:
                        {
                            return Config.language("DescriptionTranslate", 265);
                        }
                        case 60018:
                        {
                            return Config.language("DescriptionTranslate", 295);
                        }
                        case 60019:
                        {
                            return Config.language("DescriptionTranslate", 298);
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 30003:
                {
                    switch(Number(_loc_2[1]))
                    {
                        case 60001:
                        case 63001:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60001);
                            }
                            return Config.language("DescriptionTranslate", 140, Base64.encode(_loc_2[2]));
                        }
                        case 60003:
                        case 63002:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60003);
                            }
                            return Config.language("DescriptionTranslate", 141, Base64.encode(_loc_2[2]));
                        }
                        case 60005:
                        case 63003:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60005);
                            }
                            return Config.language("DescriptionTranslate", 142, Base64.encode(_loc_2[2]));
                        }
                        case 60007:
                        case 63004:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60007);
                            }
                            return Config.language("DescriptionTranslate", 143, Base64.encode(_loc_2[2]));
                        }
                        case 60009:
                        case 63005:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60009);
                            }
                            return Config.language("DescriptionTranslate", 144, Base64.encode(_loc_2[2]));
                        }
                        case 60011:
                        case 63006:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60011);
                            }
                            return Config.language("DescriptionTranslate", 158, Base64.encode(_loc_2[2]));
                        }
                        case 60013:
                        case 63007:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60013);
                            }
                            return Config.language("DescriptionTranslate", 145, Base64.encode(_loc_2[2]));
                        }
                        case 60015:
                        case 63008:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60015);
                            }
                            return Config.language("DescriptionTranslate", 146, Base64.encode(_loc_2[2]));
                        }
                        case 60017:
                        case 63009:
                        {
                            if (Config.player != null && _loc_2[2] == Config.player.name)
                            {
                                Bard.killBoss(60017);
                            }
                            return Config.language("DescriptionTranslate", 225, Base64.encode(_loc_2[2]));
                        }
                        case 63010:
                        {
                            return Config.language("DescriptionTranslate", 256, Base64.encode(_loc_2[2]));
                        }
                        case 63014:
                        {
                            return Config.language("DescriptionTranslate", 263, Base64.encode(_loc_2[2]));
                        }
                        case 63015:
                        {
                            return Config.language("DescriptionTranslate", 266, Base64.encode(_loc_2[2]));
                        }
                        case 60018:
                        {
                            return Config.language("DescriptionTranslate", 296, Base64.encode(_loc_2[2]));
                        }
                        case 60019:
                        {
                            return Config.language("DescriptionTranslate", 299, Base64.encode(_loc_2[2]));
                        }
                        default:
                        {
                            break;
                        }
                    }
                    break;
                }
                case 91001:
                {
                    return Config.language("DescriptionTranslate", 172);
                }
                case 91002:
                {
                    _loc_6 = new Object();
                    _loc_6.type = 7;
                    _loc_6.fname = "active";
                    _loc_6.timenum = 900;
                    _loc_6.d = {position:70};
                    ListTip.addList(_loc_6);
                    return Config.language("DescriptionTranslate", 173);
                }
                case 91003:
                {
                    return Config.language("DescriptionTranslate", 174);
                }
                case 91004:
                {
                    return Config.language("DescriptionTranslate", 175);
                }
                case 91005:
                {
                    return Config.language("DescriptionTranslate", 176);
                }
                case 91006:
                {
                    return Config.language("DescriptionTranslate", 177);
                }
                case 92001:
                {
                    return Config.language("DescriptionTranslate", 187);
                }
                case 92002:
                {
                    return Config.language("DescriptionTranslate", 188);
                }
                case 93001:
                {
                    return Config.language("DescriptionTranslate", 189, _loc_2[1], Config._mapMap[_loc_2[2]].mapData.name);
                }
                case 93002:
                {
                    return Config.language("DescriptionTranslate", 190, _loc_2[1], Config._mapMap[_loc_2[2]].mapData.name);
                }
                case 93003:
                {
                    return Config.language("DescriptionTranslate", 191, _loc_2[1], Config._mapMap[_loc_2[2]].mapData.name);
                }
                case 93004:
                {
                    return Config.language("DescriptionTranslate", 192, _loc_2[1], _loc_2[2], Config._mapMap[_loc_2[3]].mapData.name, _loc_2[4]);
                }
                case 93005:
                {
                    return Config.language("DescriptionTranslate", 193);
                }
                case 93006:
                {
                    return Config.language("DescriptionTranslate", 194);
                }
                case 93007:
                {
                    return Config.language("DescriptionTranslate", 195);
                }
                case 93008:
                {
                    return Config.language("DescriptionTranslate", 196);
                }
                case 93009:
                {
                    return Config.language("DescriptionTranslate", 197);
                }
                case 93010:
                {
                    return Config.language("DescriptionTranslate", 198);
                }
                case 17010:
                {
                    return Config.language("DescriptionTranslate", 199, _loc_2[1]);
                }
                case 17020:
                {
                    return Config.language("DescriptionTranslate", 200, _loc_2[1]);
                }
                case 17030:
                {
                    return Config.language("DescriptionTranslate", 201, _loc_2[1]);
                }
                case 17040:
                {
                    return Config.language("DescriptionTranslate", 202, _loc_2[1]);
                }
                case 17050:
                {
                    return Config.language("DescriptionTranslate", 203, _loc_2[1]);
                }
                case 17051:
                {
                    return Config.language("DescriptionTranslate", 204);
                }
                case 17052:
                {
                    return Config.language("DescriptionTranslate", 212);
                }
                case 17053:
                {
                    return Config.language("DescriptionTranslate", 213);
                }
                case 17001:
                {
                    return Config.language("DescriptionTranslate", 207);
                }
                case 17002:
                {
                    _loc_6 = new Object();
                    _loc_6.type = 7;
                    _loc_6.fname = "active";
                    _loc_6.timenum = 900;
                    _loc_6.d = {position:80};
                    ListTip.addList(_loc_6);
                    return Config.language("DescriptionTranslate", 208);
                }
                case 17003:
                {
                    return Config.language("DescriptionTranslate", 210);
                }
                case 17004:
                {
                    return Config.language("DescriptionTranslate", 211);
                }
                case 17005:
                {
                    return Config.language("DescriptionTranslate", 205, _loc_2[1], Config._territoryMap[int(_loc_2[2])].name);
                }
                case 17006:
                {
                    return Config.language("DescriptionTranslate", 206, Config._territoryMap[int(_loc_2[1])].name);
                }
                case 94001:
                {
                    return Config.language("DescriptionTranslate", 214);
                }
                case 94002:
                {
                    return Config.language("DescriptionTranslate", 215);
                }
                case 94003:
                {
                    return Config.language("DescriptionTranslate", 216);
                }
                case 94004:
                {
                    return Config.language("DescriptionTranslate", 217);
                }
                case 94005:
                {
                    return Config.language("DescriptionTranslate", 218);
                }
                case 94006:
                {
                    return Config.language("DescriptionTranslate", 219);
                }
                case 94008:
                {
                    return Config.language("DescriptionTranslate", 230, _loc_2[1]);
                }
                case 94009:
                {
                    _loc_7 = Config._itemMap[int(_loc_2[3])];
                    _loc_8 = new Item(_loc_7, 0, 0, UNIT_TYPE_ENUM.TYPEID_ITEMCLONE, 94009);
                    _loc_6 = {};
                    _loc_9 = ["", Config.language("ProducePanel", 70), Config.language("ProducePanel", 71), Config.language("ProducePanel", 72), Config.language("ProducePanel", 73), Config.language("ProducePanel", 111)];
                    _loc_6.qual = _loc_8._itemData.addEffect.length;
                    _loc_6.name = _loc_8._itemData.name + _loc_9[_loc_6.qual];
                    _loc_6.id = _loc_8._itemData.id;
                    _loc_6.binding = _loc_8._itemData.binding;
                    _loc_6.washgrade = _loc_8._itemData.washgrade;
                    _loc_6.finegrade = _loc_8._itemData.finegrade;
                    _loc_6.amount = _loc_8._itemData.amount;
                    _loc_6.timeout = _loc_8._itemData.timeout;
                    _loc_6.suitID = _loc_8._itemData.suitID;
                    _loc_6.addEffect = _loc_8._itemData.addEffect;
                    _loc_6.gem = _loc_8._itemData.gem;
                    _loc_6._petBookObj = _loc_8._petBookObj;
                    _loc_6._petObj = _loc_8._petObj;
                    _loc_8.destroy();
                    return Config.language("DescriptionTranslate", 226, _loc_2[2] + "^" + _loc_2[1], JSON.encode(_loc_6));
                }
                case 94010:
                {
                    return Config.language("DescriptionTranslate", 222, _loc_2[1]);
                }
                case 18001:
                {
                    return Config.language("DescriptionTranslate", 221, _loc_2[1], _loc_2[2]);
                }
                case 19001:
                {
                    return Config.language("DescriptionTranslate", 232, _loc_2[1]);
                }
                case 19002:
                {
                    return Config.language("DescriptionTranslate", 233);
                }
                case 19003:
                {
                    return Config.language("DescriptionTranslate", 234);
                }
                case 19004:
                {
                    return Config.language("DescriptionTranslate", 235);
                }
                case 19005:
                {
                    return Config.language("DescriptionTranslate", 236);
                }
                case 19101:
                {
                    return Config.language("DescriptionTranslate", 237);
                }
                case 19102:
                {
                    return Config.language("DescriptionTranslate", 238);
                }
                case 19201:
                {
                    return Config.language("DescriptionTranslate", 239);
                }
                case 19202:
                {
                    return Config.language("DescriptionTranslate", 240);
                }
                case 19300:
                {
                    return Config.language("DescriptionTranslate", 252);
                }
                case 19301:
                {
                    return Config.language("DescriptionTranslate", 253);
                }
                case 95001:
                {
                    return Config.language("DescriptionTranslate", 241);
                }
                case 95002:
                {
                    return Config.language("DescriptionTranslate", 242);
                }
                case 95003:
                {
                    return Config.language("DescriptionTranslate", 243);
                }
                case 95004:
                {
                    return Config.language("DescriptionTranslate", 244);
                }
                case 95005:
                {
                    return Config.language("DescriptionTranslate", 245);
                }
                case 95006:
                {
                    return Config.language("DescriptionTranslate", 246);
                }
                case 95007:
                {
                    return Config.language("DescriptionTranslate", 247);
                }
                case 95008:
                {
                    return Config.language("DescriptionTranslate", 248);
                }
                case 95009:
                {
                    return Config.language("DescriptionTranslate", 249);
                }
                case 95010:
                {
                    return Config.language("DescriptionTranslate", 250);
                }
                case 95011:
                {
                    return Config.language("DescriptionTranslate", 251, _loc_2[1], _loc_2[2]);
                }
                case 95099:
                {
                    _loc_10 = [Config.language("DescriptionTranslate", 258), Config.language("DescriptionTranslate", 259), Config.language("DescriptionTranslate", 260)];
                    return Config.language("DescriptionTranslate", 257, _loc_2[1], _loc_10[int((_loc_2[2] - 1))]);
                }
                case 96001:
                {
                    return Config.language("DescriptionTranslate", 267);
                }
                case 96002:
                {
                    return Config.language("DescriptionTranslate", 268);
                }
                case 96003:
                {
                    return Config.language("DescriptionTranslate", 269);
                }
                case 96004:
                {
                    return Config.language("DescriptionTranslate", 270);
                }
                case 96005:
                {
                    return Config.language("DescriptionTranslate", 271);
                }
                case 96006:
                {
                    return Config.language("DescriptionTranslate", 272);
                }
                case 96007:
                {
                    return Config.language("DescriptionTranslate", 279);
                }
                case 96008:
                {
                    return Config.language("DescriptionTranslate", 280);
                }
                case 96010:
                {
                    return Config.language("DescriptionTranslate", 281);
                }
                case 96011:
                {
                    _loc_11 = "";
                    if (_loc_2[1] == 0)
                    {
                        _loc_11 = Config.language("DescriptionTranslate", 283);
                    }
                    else if (_loc_2[1] == 1)
                    {
                        _loc_11 = Config.language("DescriptionTranslate", 284);
                    }
                    else if (_loc_2[1] == 2)
                    {
                        _loc_11 = Config.language("DescriptionTranslate", 285);
                    }
                    else if (_loc_2[1] == 3)
                    {
                        _loc_11 = Config.language("DescriptionTranslate", 286);
                    }
                    else if (_loc_2[1] == 4)
                    {
                        _loc_11 = Config.language("DescriptionTranslate", 287);
                    }
                    else if (_loc_2[1] == 5)
                    {
                        _loc_11 = Config.language("DescriptionTranslate", 288);
                    }
                    return Config.language("DescriptionTranslate", 282, _loc_11);
                }
                case 96100:
                {
                    return Config.language("DescriptionTranslate", 273);
                }
                case 96101:
                {
                    return Config.language("DescriptionTranslate", 274);
                }
                case 96110:
                {
                    return Config.language("DescriptionTranslate", 275);
                }
                case 96111:
                {
                    return Config.language("DescriptionTranslate", 276);
                }
                case 96120:
                {
                    return Config.language("DescriptionTranslate", 277);
                }
                case 96121:
                {
                    return Config.language("DescriptionTranslate", 278);
                }
                case 96130:
                {
                    return Config.language("DescriptionTranslate", 293, _loc_2[1], _loc_2[2]);
                }
                case 96140:
                {
                    return Config.language("DescriptionTranslate", 300, _loc_2[1], Config._itemMap[_loc_2[2]].name);
                }
                case 97001:
                {
                    return Config.language("DescriptionTranslate", 289);
                }
                case 97002:
                {
                    return Config.language("DescriptionTranslate", 290);
                }
                case 97021:
                {
                    return Config.language("DescriptionTranslate", 291);
                }
                case 97022:
                {
                    return Config.language("DescriptionTranslate", 292);
                }
                default:
                {
                    return param1;
                    break;
                }
            }
            return;
        }// end function

        private static function getWeek(param1)
        {
            switch(param1)
            {
                case 1:
                {
                    return Config.language("DescriptionTranslate", 147);
                }
                case 2:
                {
                    return Config.language("DescriptionTranslate", 148);
                }
                case 3:
                {
                    return Config.language("DescriptionTranslate", 149);
                }
                case 4:
                {
                    return Config.language("DescriptionTranslate", 150);
                }
                case 5:
                {
                    return Config.language("DescriptionTranslate", 151);
                }
                case 6:
                {
                    return Config.language("DescriptionTranslate", 152);
                }
                default:
                {
                    return Config.language("DescriptionTranslate", 153);
                    break;
                }
            }
        }// end function

        private static function getJob(param1)
        {
            switch(param1)
            {
                case 1:
                {
                    return Config.language("DescriptionTranslate", 154);
                }
                case 2:
                {
                    return Config.language("DescriptionTranslate", 155);
                }
                case 3:
                {
                    return Config.language("DescriptionTranslate", 156);
                }
                case 4:
                {
                    return Config.language("DescriptionTranslate", 157);
                }
                default:
                {
                    return "";
                    break;
                }
            }
        }// end function

        private static function goThere(param1) : void
        {
            Hang.hangNpc(param1.npc);
            return;
        }// end function

        private static function flyThere(param1) : void
        {
            switch(param1.id)
            {
                case 1:
                {
                    Config.ui._farmpanel.sendformin();
                    break;
                }
                case 2:
                {
                    Config.ui._wolfactive.sendeLitein();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

    }
}
