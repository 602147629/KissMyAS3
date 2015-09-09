class pjam.PlayerData
{
    var root, so;
    function PlayerData(root)
    {
        this.root = root;
        so = SharedObject.getLocal("OH_DANGO_JAM", "/");
    } // End of the function
    function checkKey()
    {
        return (so.data.id == undefined ? (false) : (true));
    } // End of the function
    function create(charNum, name, charName, hp, attack, magic, defense, url)
    {
        so.data.id = -1;
        so.data.money = 0;
        so.data.lv = 1;
        so.data.ex = 0;
        so.data.charNum = charNum;
        so.data.name = name;
        so.data.charName = charName;
        so.data.hp = hp;
        so.data.attack = attack;
        so.data.magic = magic;
        so.data.defense = defense;
        so.data.url = url;
        so.data.item0 = charNum;
        so.data.item1 = -1;
        so.data.item2 = -1;
        so.data.exc = 0;
        so.data.control = -1;
        so.data.sp = 0;
        this.codeExe();
    } // End of the function
    function firstRegistData()
    {
        return (so.data.money + "," + so.data.lv + "," + so.data.ex + "," + so.data.charNum + "," + so.data.name + "," + so.data.charName + "," + so.data.hp + "," + so.data.attack + "," + so.data.magic + "," + so.data.defense + "," + so.data.url + "," + so.data.item0 + "," + so.data.item1 + "," + so.data.item2 + "," + so.data.sp);
    } // End of the function
    function createRegistData()
    {
        return (so.data.id + "," + this.firstRegistData());
    } // End of the function
    function createUseItemData(num)
    {
        return ("-1," + so.data.money + "," + so.data.lv + "," + so.data.ex + "," + num + "," + so.data.name + "," + so.data.charName + "," + so.data.hp + "," + so.data.attack + "," + so.data.magic + "," + so.data.defense + "," + so.data.url + "," + so.data.item0 + "," + so.data.item1 + "," + so.data.item2 + "," + so.data.sp);
    } // End of the function
    function checkRegistTime()
    {
        if (so.data.time == undefined)
        {
            so.data.time = getTimer();
            return (REGIST_TIME);
        } // end if
        var _loc2 = getTimer() - so.data.time;
        return (_loc2 > REGIST_TIME ? (0) : (REGIST_TIME - _loc2));
    } // End of the function
    function setFightData(money, up, ex, exc, hp, attack, magic, defense, sp)
    {
        so.data.money = so.data.money + money;
        so.data.lv = so.data.lv + up;
        so.data.ex = so.data.ex + ex;
        so.data.exc = exc;
        so.data.hp = so.data.hp + hp;
        so.data.attack = so.data.attack + attack;
        so.data.magic = so.data.magic + magic;
        so.data.defense = so.data.defense + defense;
        so.data.sp = sp;
        so.data.attack = this.cutStatus(so.data.attack);
        so.data.magic = this.cutStatus(so.data.magic);
        so.data.defense = this.cutStatus(so.data.defense);
        this.codeExe();
    } // End of the function
    function checkCode()
    {
        if (this.checkKey() == false)
        {
            return (true);
        } // end if
        if (so.data.maru == undefined)
        {
            this.codeExe();
            return (true);
        } // end if
        var _loc3 = this.decodeExe(so.data.maru);
        var _loc2 = _loc3.split(",");
        if (_loc2[0] - KEY2 == so.data.money && _loc2[1] - KEY2 == so.data.lv && _loc2[2] - KEY2 == so.data.ex && _loc2[3] - KEY2 == so.data.charNum && _loc2[4] - KEY2 == so.data.hp && _loc2[5] - KEY2 == Math.floor(so.data.attack) && _loc2[6] - KEY2 == Math.floor(so.data.magic) && _loc2[7] - KEY2 == Math.floor(so.data.defense) && _loc2[8] - KEY2 == so.data.item0 && _loc2[9] - KEY2 == so.data.item1 && _loc2[10] - KEY2 == so.data.item2)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function cutStatus(num)
    {
        var _loc1 = num.toString().indexOf(".");
        if (_loc1 == -1)
        {
            return (num);
        } // end if
        return (Number(num.toString().substring(0, _loc1 + 3)));
    } // End of the function
    function setFakeFlg(flg)
    {
        so.data.fakeFlg = flg;
    } // End of the function
    function checkFakeFlg()
    {
        if (so.data.fakeFlg == true)
        {
            var _loc2 = pjam.fight.LvUp.getDownPer(so.data.lv);
            so.data.money = so.data.money - Math.floor(so.data.money * _loc2);
            so.data.fakeFlg = false;
            this.codeExe();
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function setRegistTime()
    {
        so.data.time = getTimer();
    } // End of the function
    function checkItemFull()
    {
        if (so.data.item0 == -1)
        {
            return (0);
        } // end if
        if (so.data.item1 == -1)
        {
            return (1);
        } // end if
        if (so.data.item2 == -1)
        {
            return (2);
        } // end if
        return (-1);
    } // End of the function
    function getItemList()
    {
        return ([so.data.item0, so.data.item1, so.data.item2]);
    } // End of the function
    function setItem(num, item)
    {
        so.data["item" + num] = item;
        this.codeExe();
    } // End of the function
    function checkItemNum()
    {
        var _loc3 = 0;
        for (var _loc2 = 0; _loc2 < 3; ++_loc2)
        {
            if (so.data["item" + _loc2] == -1)
            {
                ++_loc3;
            } // end if
        } // end of for
        if (_loc3 > 1)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function setMoney(n)
    {
        so.data.money = so.data.money + n;
        this.codeExe();
    } // End of the function
    function setCharNum(num)
    {
        so.data.charNum = num;
        this.codeExe();
    } // End of the function
    function getID()
    {
        return (so.data.id);
    } // End of the function
    function setID(n)
    {
        so.data.id = n;
    } // End of the function
    function deleteID()
    {
        so.data.id = undefined;
    } // End of the function
    function setUrl(url)
    {
        so.data.url = url;
    } // End of the function
    function changeControl()
    {
        so.data.control = so.data.control * -1;
    } // End of the function
    function getControl()
    {
        return (so.data.control);
    } // End of the function
    function getLv()
    {
        return (so.data.lv);
    } // End of the function
    function getEx()
    {
        return (so.data.ex);
    } // End of the function
    function getExc()
    {
        return (so.data.exc);
    } // End of the function
    function getCharNum()
    {
        return (so.data.charNum);
    } // End of the function
    function getName()
    {
        return (so.data.name);
    } // End of the function
    function codeExe()
    {
        var _loc3 = so.data.money + KEY2 + "," + (so.data.lv + KEY2) + "," + (so.data.ex + KEY2) + "," + (so.data.charNum + KEY2) + "," + (so.data.hp + KEY2) + "," + (Math.floor(so.data.attack) + KEY2) + "," + (Math.floor(so.data.magic) + KEY2) + "," + (Math.floor(so.data.defense) + KEY2) + "," + (so.data.item0 + KEY2) + "," + (so.data.item1 + KEY2) + "," + (so.data.item2 + KEY2);
        var _loc4 = "";
        for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
        {
            _loc4 = _loc4 + (_loc3.charCodeAt(_loc2) + KEY + KEY_STR);
        } // end of for
        so.data.maru = _loc4;
    } // End of the function
    function decodeExe(code)
    {
        var _loc4 = code.split(KEY_STR);
        var _loc5 = "";
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            var _loc3 = String(Number(_loc4[_loc2]) - KEY);
            _loc5 = _loc5 + String.fromCharCode(_loc3);
        } // end of for
        return (_loc5);
    } // End of the function
    var REGIST_TIME = 300000;
    var KEY = 14;
    var KEY_STR = "%";
    var KEY2 = 4;
} // End of Class
