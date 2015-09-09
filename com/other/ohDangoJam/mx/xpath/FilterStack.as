class mx.xpath.FilterStack
{
    var __expr, __ops, __get__exprs, __get__ops;
    function FilterStack(filterVal)
    {
        __expr = new Array();
        __ops = new Array();
        var _loc2 = new mx.utils.StringTokenParser(filterVal);
        var _loc5 = _loc2.nextToken();
        var _loc4;
        for (var _loc3 = _loc2.__get__token(); _loc5 != mx.utils.StringTokenParser.tkEOF; _loc3 = _loc2.token)
        {
            if (_loc3 == "@")
            {
                _loc5 = _loc2.nextToken();
                _loc3 = _loc2.token;
                _loc4 = new mx.xpath.FilterExpr(true, _loc3, null);
                __expr.splice(0, 0, _loc4);
                if (_loc2.nextToken() == mx.utils.StringTokenParser.tkSymbol)
                {
                    if (_loc2.__get__token() == "=")
                    {
                        _loc5 = _loc2.nextToken();
                        _loc4.__set__value(_loc2.token);
                    } // end if
                } // end if
            }
            else if (_loc3 == "and" || _loc3 == "or")
            {
                __ops.splice(0, 0, _loc3);
            }
            else if (_loc3 != ")" && _loc3 != "(")
            {
                _loc4 = new mx.xpath.FilterExpr(false, _loc3, null);
                __expr.splice(0, 0, _loc4);
                if (_loc2.nextToken() == mx.utils.StringTokenParser.tkSymbol)
                {
                    if (_loc2.__get__token() == "=")
                    {
                        _loc5 = _loc2.nextToken();
                        _loc4.__set__value(_loc2.token);
                    } // end if
                } // end else if
            } // end else if
            _loc5 = _loc2.nextToken();
        } // end of for
    } // End of the function
    function get exprs()
    {
        return (__expr);
    } // End of the function
    function get ops()
    {
        return (__ops);
    } // End of the function
} // End of Class
