class pjam.Charactor
{
    function Charactor()
    {
    } // End of the function
    static function getCharData(root, data)
    {
        var _loc2 = data.split(",");
        var _loc3 = false;
        var _loc1 = root.charSet;
        _loc1.first();
        while (_loc1.hasNext())
        {
            if (_loc1.currentItem.charNum == _loc2[4])
            {
                _loc3 = true;
                break;
            } // end if
            _loc1.next();
        } // end while
        if (_loc3 == false)
        {
            _loc1.selectedIndex = 0;
        } // end if
        return ({id: _loc1.currentItem.id, uid: Number(_loc2[0]), money: Number(_loc2[1]), lv: Number(_loc2[2]), ex: Number(_loc2[3]), charNum: Number(_loc2[4]), name: _loc2[5], charName: _loc2[6], hp: Number(_loc2[7]) + _loc1.currentItem.plusHp, attack: Number(_loc2[8]) + _loc1.currentItem.plusAttack, magic: Number(_loc2[9]) + _loc1.currentItem.plusMagic, defense: Number(_loc2[10]) + _loc1.currentItem.plusDefense, speed: _loc1.currentItem.speed, luck: _loc1.currentItem.luck, jump: _loc1.currentItem.jump, spMove: _loc1.currentItem.spMove, url: _loc2[11], item0: Number(_loc2[12]), item1: Number(_loc2[13]), item2: Number(_loc2[14]), sp: Number(_loc2[15]), kind: pjam.Charactor.KIND_PLAYER, various: _loc1.currentItem.various});
    } // End of the function
    static function getCpuData(root)
    {
        var _loc2 = root.charSet;
        var _loc3 = Math.floor(Math.random() * _loc2.getLength());
        _loc2.selectedIndex = _loc3;
        if (_loc2.currentItem.various == pjam.Charactor.VARIOUS_REA && Math.floor(Math.random() * pjam.Charactor.REA_PER) != 0)
        {
            _loc2.selectedIndex = 0;
        } // end if
        var _loc1 = _loc2.currentItem;
        return ({id: _loc1.id, money: _loc1.money, lv: _loc1.lv, ex: _loc1.ex, charNum: _loc1.charNum, name: "CPU", charName: _loc1.charName, hp: _loc1.hp, attack: _loc1.attack, magic: _loc1.magic, defense: _loc1.defense, speed: _loc1.speed, luck: _loc1.luck, jump: _loc1.jump, spMove: _loc1.spMove, url: _loc1.url, item0: _loc1.charNum, item1: -1, item2: -1, sp: 0, kind: pjam.Charactor.KIND_CPU, various: _loc1.various});
    } // End of the function
    static function getNearCpuData(root, pdata)
    {
        var _loc3 = root.charSet;
        var _loc6 = Math.floor(Math.random() * _loc3.getLength());
        _loc3.selectedIndex = _loc6;
        if (_loc3.currentItem.various == pjam.Charactor.VARIOUS_REA)
        {
            _loc3.selectedIndex = 0;
        } // end if
        var _loc28 = Math.floor(Math.random() * pdata.getLv());
        var _loc5 = Math.floor(Math.random() * pjam.Charactor.NEAR_LV);
        _loc28 = _loc28 + (Math.floor(Math.random() * 2) == 0 ? (_loc5) : (-_loc5));
        if (_loc28 < 1)
        {
            _loc28 = 1;
        } // end if
        var _loc4 = pjam.fight.Bonus.getExMoney(_loc28);
        var _loc7 = _loc28 * pjam.fight.LvUp.BONUS;
        var _loc2 = pjam.Charactor.getNearUpData(_loc7);
        var _loc19 = 10 + _loc2.up;
        _loc2 = pjam.Charactor.getNearUpData(_loc2.rest);
        var _loc10 = 10 + _loc2.up;
        _loc2 = pjam.Charactor.getNearUpData(_loc2.rest);
        var _loc20 = 10 + _loc2.up;
        var _loc8 = 10 + _loc2.rest;
        _loc19 = _loc19 + Math.floor(_loc28 / 2);
        var _loc1 = _loc3.currentItem;
        return ({id: _loc1.id, money: _loc4.money, lv: _loc28, ex: _loc4.ex, charNum: _loc1.charNum, name: "CPU", charName: _loc1.charName, hp: _loc19, attack: _loc10, magic: _loc20, defense: _loc8, speed: _loc1.speed, luck: _loc1.luck, jump: _loc1.jump, spMove: _loc1.spMove, url: _loc1.url, item0: _loc1.charNum, item1: -1, item2: -1, sp: 0, kind: pjam.Charactor.KIND_CPU, various: _loc1.various});
    } // End of the function
    static function getNearUpData(rest)
    {
        var _loc1 = Math.floor(Math.random() * rest);
        return ({up: _loc1, rest: rest - _loc1});
    } // End of the function
    static function getItemName(root, num)
    {
        if (num == -1)
        {
            return ("");
        } // end if
        var _loc1 = root.charSet;
        _loc1.first();
        while (_loc1.hasNext())
        {
            if (_loc1.currentItem.charNum == num)
            {
                break;
            } // end if
            _loc1.next();
        } // end while
        return (_loc1.currentItem.item);
    } // End of the function
    static function getItemPrice(root, num)
    {
        var _loc1 = root.charSet;
        _loc1.first();
        while (_loc1.hasNext())
        {
            if (_loc1.currentItem.charNum == num)
            {
                break;
            } // end if
            _loc1.next();
        } // end while
        return (_loc1.currentItem.sell);
    } // End of the function
    static var KIND_PLAYER = 1;
    static var KIND_CPU = 2;
    static var VARIOUS_NORMAL = 0;
    static var VARIOUS_REA = 2;
    static var NEAR_LV = 10;
    static var REA_PER = 5;
} // End of Class
