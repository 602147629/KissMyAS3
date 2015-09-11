class util.StringEx
{
    function StringEx()
    {
    } // End of the function
    static function cutStr(str, clm)
    {
        var _loc1 = str.indexOf(clm);
        if (_loc1 == -1)
        {
            return ([str, null]);
        } // end if
        var _loc4 = str.substring(0, _loc1);
        var _loc3 = str.substring(_loc1 + clm.length);
        return ([_loc4, _loc3]);
    } // End of the function
    static function insert(str, num, ins)
    {
        var _loc2 = str.substring(0, num);
        var _loc1 = str.substring(num);
        return (_loc2 + ins + _loc1);
    } // End of the function
    static function placeFillNum(place, num, fill)
    {
        var _loc5 = place.toString();
        var _loc2 = num.toString();
        var _loc3 = fill.toString();
        for (var _loc1 = _loc2.length; _loc1 < place; ++_loc1)
        {
            _loc2 = _loc3 + _loc2;
        } // end of for
        return (_loc2);
    } // End of the function
    static function removeList(str, list)
    {
        for (var _loc1 = 0; _loc1 < list.length; ++_loc1)
        {
            str = util.StringEx.remove(str, list[_loc1]);
        } // end of for
        return (str);
    } // End of the function
    static function remove(str, rem)
    {
        while (true)
        {
            var _loc1 = util.StringEx.cutStr(str, rem);
            if (_loc1[1] == null)
            {
                return (_loc1[0]);
                continue;
            } // end if
            str = _loc1[0] + _loc1[1];
        } // end while
    } // End of the function
    static function checkHan(str)
    {
        for (var _loc1 = 0; _loc1 < str.length; ++_loc1)
        {
            if (str.charCodeAt(_loc1) > 127)
            {
                return (false);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static function cutLineList(checkList, cut)
    {
        var _loc4 = new Array();
        for (var _loc3 = 0; _loc3 < checkList.length; ++_loc3)
        {
            var _loc2 = checkList[_loc3];
            while (true)
            {
                var _loc1 = util.StringEx.cutStr(_loc2, cut);
                _loc4.push(_loc1[0]);
                _loc2 = _loc1[1];
                if (_loc1[1] == null)
                {
                    break;
                } // end if
            } // end while
        } // end of for
        return (_loc4);
    } // End of the function
} // End of Class
