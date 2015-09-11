class pjam.fight.DamageGet
{
    function DamageGet()
    {
    } // End of the function
    static function normal(state, hit, data1, data2)
    {
        var _loc1 = data1[state];
        if (hit == "H")
        {
            _loc1 = _loc1 + _loc1 * 0.100000;
        }
        else if (hit == "M")
        {
            _loc1 = _loc1 + _loc1 * 0.070000;
        }
        else if (hit == "S")
        {
            _loc1 = _loc1 + _loc1 * 0.040000;
        } // end else if
        var _loc3 = Math.floor(Math.random() * 10);
        if (Math.floor(Math.random() * 2) == 0)
        {
            _loc1 = _loc1 + _loc3;
        }
        else
        {
            _loc1 = _loc1 - _loc3;
        } // end else if
        _loc1 = Math.floor(_loc1 * 0.300000 + data1.lv * 0.150000 - data2.defense * 0.200000);
        if (_loc1 <= 0)
        {
            _loc1 = 0;
            if (data1.lv < 100)
            {
                _loc1 = Math.floor(Math.random() * 4) + 1;
            }
            else if (data1.lv < 300)
            {
                _loc1 = Math.floor(Math.random() * 7) + 1;
            }
            else if (data1.lv < 600)
            {
                _loc1 = Math.floor(Math.random() * 10) + 1;
            }
            else
            {
                _loc1 = Math.floor(Math.random() * 15) + 1;
            } // end else if
        } // end else if
        return (_loc1);
    } // End of the function
    static function power(hit, data1, data2)
    {
        var _loc1 = Math.floor(Math.random() * 2);
        var _loc2 = _loc1 == 0 ? (pjam.fight.player.Player.ATTACK_STATE) : (pjam.fight.player.Player.MAGIC_STATE);
        return (Math.ceil(pjam.fight.DamageGet.normal(_loc2, hit, data1, data2) * 0.800000));
    } // End of the function
    static function smashCheck(luck)
    {
        return (Math.floor(Math.random() * 500) < luck ? (true) : (false));
    } // End of the function
    static function smash(state, data1)
    {
        var _loc1 = Math.floor(data1[state]);
        var _loc2 = Math.floor(Math.random() * 10);
        if (Math.floor(Math.random() * 2) == 0)
        {
            _loc1 = _loc1 + _loc2;
        }
        else
        {
            _loc1 = _loc1 - _loc2;
        } // end else if
        return (_loc1);
    } // End of the function
} // End of Class
