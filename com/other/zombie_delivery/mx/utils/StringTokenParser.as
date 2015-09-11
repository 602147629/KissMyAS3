class mx.utils.StringTokenParser
{
    var _source, _skipChars, __get__token;
    function StringTokenParser(source, skipChars)
    {
        _source = source;
        _skipChars = skipChars == undefined ? (null) : (skipChars);
    } // End of the function
    function get token()
    {
        return (_token);
    } // End of the function
    function getPos()
    {
        return (_index);
    } // End of the function
    function nextToken()
    {
        var _loc4;
        var _loc2;
        var _loc3 = _source.length;
        this.skipBlanks();
        if (_index >= _loc3)
        {
            return (mx.utils.StringTokenParser.tkEOF);
        } // end if
        _loc2 = _source.charCodeAt(_index);
        if (_loc2 >= 65 && _loc2 <= 90 || _loc2 >= 97 && _loc2 <= 122 || _loc2 >= 192 && _loc2 <= Number.POSITIVE_INFINITY || _loc2 == 95)
        {
            _loc4 = _index;
            ++_index;
            for (var _loc2 = _source.charCodeAt(_index); (_loc2 >= 65 && _loc2 <= 90 || _loc2 >= 97 && _loc2 <= 122 || _loc2 >= 48 && _loc2 <= 57 || _loc2 >= 192 && _loc2 <= Number.POSITIVE_INFINITY || _loc2 == 95) && _index < _loc3; _loc2 = _source.charCodeAt(_index))
            {
                ++_index;
            } // end of for
            _token = _source.substring(_loc4, _index);
            return (mx.utils.StringTokenParser.tkSymbol);
        }
        else if (_loc2 == 34 || _loc2 == 39)
        {
            ++_index;
            _loc4 = _index;
            for (var _loc2 = _source.charCodeAt(_loc4); _loc2 != 34 && _loc2 != 39 && _index < _loc3; _loc2 = _source.charCodeAt(_index))
            {
                ++_index;
            } // end of for
            _token = _source.substring(_loc4, _index);
            ++_index;
            return (mx.utils.StringTokenParser.tkString);
        }
        else if (_loc2 == 45 || _loc2 >= 48 && _loc2 <= 57)
        {
            var _loc5 = mx.utils.StringTokenParser.tkInteger;
            _loc4 = _index;
            ++_index;
            for (var _loc2 = _source.charCodeAt(_index); _loc2 >= 48 && _loc2 <= 57 && _index < _loc3; _loc2 = _source.charCodeAt(_index))
            {
                ++_index;
            } // end of for
            if (_index < _loc3)
            {
                if (_loc2 >= 48 && _loc2 <= 57 || _loc2 == 46 || _loc2 == 43 || _loc2 == 45 || _loc2 == 101 || _loc2 == 69)
                {
                    _loc5 = mx.utils.StringTokenParser.tkFloat;
                } // end if
                while ((_loc2 >= 48 && _loc2 <= 57 || _loc2 == 46 || _loc2 == 43 || _loc2 == 45 || _loc2 == 101 || _loc2 == 69) && _index < _loc3)
                {
                    ++_index;
                    _loc2 = _source.charCodeAt(_index);
                } // end while
            } // end if
            _token = _source.substring(_loc4, _index);
            return (_loc5);
        }
        else
        {
            _token = _source.charAt(_index);
            ++_index;
            return (mx.utils.StringTokenParser.tkSymbol);
        } // end else if
    } // End of the function
    function skipBlanks()
    {
        if (_index < _source.length)
        {
            for (var _loc2 = _source.charAt(_index); _loc2 == " " || _skipChars != null && this.skipChar(_loc2); _loc2 = _source.charAt(_index))
            {
                ++_index;
            } // end of for
        } // end if
    } // End of the function
    function skipChar(ch)
    {
        for (var _loc2 = 0; _loc2 < _skipChars.length; ++_loc2)
        {
            if (ch == _skipChars[_loc2])
            {
                return (true);
            } // end if
        } // end of for
        return (false);
    } // End of the function
    static var tkEOF = -1;
    static var tkSymbol = 0;
    static var tkString = 1;
    static var tkInteger = 2;
    static var tkFloat = 3;
    var _index = 0;
    var _token = "";
} // End of Class
