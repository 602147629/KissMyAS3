class util.ArrayEx
{
    function ArrayEx()
    {
    } // End of the function
    static function checkList(data, list)
    {
        for (var _loc1 = 0; _loc1 < list.length; ++_loc1)
        {
            if (list[_loc1] == data)
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static function randomList(list)
    {
        var _loc3 = new Array();
        while (true)
        {
            if (_loc3.length >= list.length)
            {
                break;
            } // end if
            var _loc1 = Math.floor(Math.random() * list.length);
            if (util.ArrayEx.checkList(list[_loc1], _loc3) == true)
            {
                continue;
            } // end if
            _loc3.push(list[_loc1]);
        } // end while
        return (_loc3);
    } // End of the function
    static function checkListNum(list, max)
    {
        var _loc3 = Math.floor(Math.random() * max);
        for (var _loc1 = 0; _loc1 < list.length; ++_loc1)
        {
            if (list[_loc1] == _loc3)
            {
                _loc3 = util.ArrayEx.checkListNum(list, max);
            } // end if
        } // end of for
        return (_loc3);
    } // End of the function
    static function getRandomData(list, max)
    {
        var _loc5 = new Array();
        var _loc3 = new Array();
        for (var _loc2 = 0; _loc2 < max; ++_loc2)
        {
            var _loc1 = util.ArrayEx.checkListNum(_loc3, max);
            _loc3.push(_loc1);
            _loc5.push(list[_loc1]);
        } // end of for
        return (_loc5);
    } // End of the function
} // End of Class
