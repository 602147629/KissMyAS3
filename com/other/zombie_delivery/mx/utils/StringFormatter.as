class mx.utils.StringFormatter
{
    var __extractToken, __infuseToken, __tokenInfo, __format;
    function StringFormatter(format, tokens, extractTokenFunc, infuseTokenFunc)
    {
        this.setFormat(format, tokens);
        __extractToken = extractTokenFunc;
        __infuseToken = infuseTokenFunc;
    } // End of the function
    function extractValue(formattedData, result)
    {
        if (result != null)
        {
            var _loc3 = null;
            for (var _loc2 = 0; _loc2 < __tokenInfo.length; ++_loc2)
            {
                _loc3 = __tokenInfo[_loc2];
                this.__infuseToken(formattedData.substring(_loc3.begin, _loc3.end), _loc3, result);
            } // end of for
        } // end if
    } // End of the function
    function formatValue(value)
    {
        var _loc5 = "";
        if (value != null)
        {
            var _loc3 = __tokenInfo[0];
            _loc5 = __format.substring(0, _loc3.begin) + this.__extractToken(value, _loc3);
            var _loc4 = _loc3;
            for (var _loc2 = 1; _loc2 < __tokenInfo.length; ++_loc2)
            {
                _loc3 = __tokenInfo[_loc2];
                _loc5 = _loc5 + (__format.substring(_loc4.end, _loc3.begin) + this.__extractToken(value, _loc3));
                _loc4 = _loc3;
            } // end of for
        } // end if
        return (_loc5);
    } // End of the function
    function getFormat()
    {
        return (__format);
    } // End of the function
    function setFormat(format, tokens)
    {
        function compareValues(a, b)
        {
            if (a.begin < b.begin)
            {
                return (-1);
            }
            else if (a.begin > b.begin)
            {
                return (1);
            }
            else
            {
                return (0);
            } // end else if
        } // End of the function
        if (format != __format)
        {
            __format = format;
            var _loc5 = tokens.split(",");
            __tokenInfo = new Array();
            var _loc4 = 0;
            var _loc3 = 0;
            var _loc7 = 0;
            for (var _loc2 = 0; _loc2 < _loc5.length; ++_loc2)
            {
                _loc4 = format.indexOf(_loc5[_loc2]);
                if (_loc4 >= 0 && _loc4 < format.length)
                {
                    _loc3 = format.lastIndexOf(_loc5[_loc2]);
                    _loc3 = _loc3 >= 0 ? (_loc3 + 1) : (_loc4 + 1);
                    __tokenInfo.splice(_loc7, 0, {token: _loc5[_loc2], begin: _loc4, end: _loc3});
                    ++_loc7;
                } // end if
            } // end of for
            __tokenInfo.sort(compareValues);
        } // end if
    } // End of the function
} // End of Class
