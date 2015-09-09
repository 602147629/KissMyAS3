class pjam.fight.Bonus
{
    function Bonus()
    {
    } // End of the function
    function action(str)
    {
        if (str == pjam.fight.player.Player.ATTACK_STATE)
        {
            attack = attack + 0.020000;
            return (7);
        }
        else if (str == pjam.fight.player.Player.MAGIC_STATE)
        {
            magic = magic + 0.020000;
            return (10);
        }
        else
        {
            defense = defense + 0.030000;
            return (50);
        } // end else if
    } // End of the function
    function setCombo(combo)
    {
        if (combo > comboMax)
        {
            comboMax = combo;
        } // end if
    } // End of the function
    function getBonus(num, eObj, root)
    {
        var _loc9 = 0;
        var _loc11 = 0;
        var _loc13 = -1;
        var _loc3 = 0;
        if (num == pjam.fight.player.Player.PLAYER_EN)
        {
            if (eObj.kind == pjam.Charactor.KIND_CPU)
            {
                _loc9 = eObj.ex;
                _loc11 = eObj.money;
            }
            else
            {
                var _loc5 = pjam.fight.Bonus.getExMoney(eObj.lv);
                _loc9 = _loc5.ex;
                _loc11 = _loc5.money;
            } // end else if
            var _loc6 = eObj.various == pjam.Charactor.VARIOUS_REA ? (REA_ITEM_PER) : (ITEM_PER);
            if (Math.floor(Math.random() * _loc6) == 0)
            {
                _loc13 = this.getItem(eObj);
            } // end if
            if (_loc13 != -1 && eObj.kind == pjam.Charactor.KIND_PLAYER)
            {
                var _loc2 = root.charSet;
                _loc2.first();
                while (_loc2.hasNext())
                {
                    if (_loc2.currentItem.charNum == _loc13)
                    {
                        break;
                    } // end if
                    _loc2.next();
                } // end while
                if (_loc2.currentItem.various == pjam.Charactor.VARIOUS_REA)
                {
                    _loc13 = -1;
                } // end if
            } // end if
            _loc3 = this.getComboBonus(_loc11);
        } // end if
        if (typeof(_loc9) != "number")
        {
            _loc9 = 0;
        } // end if
        if (typeof(_loc11) != "number")
        {
            _loc11 = 0;
        } // end if
        if (typeof(_loc13) != "number")
        {
            _loc13 = -1;
        } // end if
        if (typeof(_loc3) != "number")
        {
            _loc3 = 0;
        } // end if
        if (_loc9 == NaN)
        {
            _loc9 = 0;
        } // end if
        if (_loc11 == NaN)
        {
            _loc11 = 0;
        } // end if
        if (_loc13 == NaN)
        {
            _loc13 = -1;
        } // end if
        if (_loc3 == NaN)
        {
            _loc3 = 0;
        } // end if
        return ({ex: _loc9, money: _loc11, item: _loc13, attack: attack, magic: magic, defense: defense, combo: _loc3, comboMax: comboMax});
    } // End of the function
    static function getExMoney(lv)
    {
        var _loc2 = lv * 10 + Math.floor(Math.random() * lv / 10);
        _loc2 = Math.floor(_loc2 * 0.500000);
        var _loc3 = Math.floor(Math.random() * (lv * 10)) + 1;
        return ({ex: _loc2, money: _loc3});
    } // End of the function
    function getItem(eObj)
    {
        var _loc2 = eObj["item" + Math.floor(Math.random() * 3)];
        if (_loc2 == -1)
        {
            _loc2 = this.getItem(eObj);
        } // end if
        return (_loc2);
    } // End of the function
    function getComboBonus(money)
    {
        return (comboMax <= 2 ? (0) : (Math.floor(money / 10 * comboMax)));
    } // End of the function
    var attack = 0;
    var magic = 0;
    var defense = 0;
    var ITEM_PER = 35;
    var REA_ITEM_PER = 75;
    var comboMax = 0;
} // End of Class
