class comp.TextEffect.TextAlign
{
    function TextAlign()
    {
    } // End of the function
    static function setAlign(list, align)
    {
        if (align == comp.TextEffect.TextAlign.LEFT)
        {
            return;
        } // end if
        var _loc1 = comp.TextEffect.TextAlign.getStrLength(list);
        if (align == comp.TextEffect.TextAlign.CENTER)
        {
            comp.TextEffect.TextAlign.setCenter(list, _loc1);
        }
        else if (align == comp.TextEffect.TextAlign.RIGHT)
        {
            comp.TextEffect.TextAlign.setRight(list, _loc1);
        } // end else if
    } // End of the function
    static function getStrLength(list)
    {
        var _loc3 = 0;
        for (var _loc1 = 0; _loc1 < list.length; ++_loc1)
        {
            _loc3 = _loc3 + Math.ceil(list[_loc1].mc._width - 4);
        } // end of for
        return (_loc3);
    } // End of the function
    static function setCenter(list, len)
    {
        for (var _loc1 = 0; _loc1 < list.length; ++_loc1)
        {
            list[_loc1].mc._x = list[_loc1].mc._x - (Math.floor(len / 2) + 1);
        } // end of for
    } // End of the function
    static function setRight(list, len)
    {
        for (var _loc1 = 0; _loc1 < list.length; ++_loc1)
        {
            list[_loc1].mc._x = list[_loc1].mc._x - len;
        } // end of for
    } // End of the function
    static var LEFT = 0;
    static var CENTER = 1;
    static var RIGHT = 2;
} // End of Class
