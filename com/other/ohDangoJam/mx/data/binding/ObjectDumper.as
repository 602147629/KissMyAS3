class mx.data.binding.ObjectDumper
{
    var inProgress;
    function ObjectDumper()
    {
        inProgress = new Array();
    } // End of the function
    static function toString(obj, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent)
    {
        var _loc3 = new mx.data.binding.ObjectDumper();
        if (maxLineLength == undefined)
        {
            maxLineLength = 100;
        } // end if
        if (indent == undefined)
        {
            indent = 0;
        } // end if
        return (_loc3.realToString(obj, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent));
    } // End of the function
    function realToString(obj, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent)
    {
        for (var _loc8 = 0; _loc8 < inProgress.length; ++_loc8)
        {
            if (inProgress[_loc8] == obj)
            {
                return ("***");
            } // end if
        } // end of for
        inProgress.push(obj);
        ++indent;
        var _loc16 = typeof(obj);
        var _loc5;
        if (obj instanceof XMLNode && showXMLstructures != true)
        {
            _loc5 = obj.toString();
        }
        else if (obj instanceof Date)
        {
            _loc5 = obj.toString();
        }
        else if (_loc16 == "object")
        {
            var _loc4 = new Array();
            if (obj instanceof Array)
            {
                _loc5 = "[";
                for (var _loc15 = 0; _loc15 < obj.length; ++_loc15)
                {
                    _loc4.push(_loc15);
                } // end of for
            }
            else
            {
                _loc5 = "{";
                for (var _loc15 in obj)
                {
                    _loc4.push(_loc15);
                } // end of for...in
                _loc4.sort();
            } // end else if
            var _loc9 = "";
            for (var _loc3 = 0; _loc3 < _loc4.length; ++_loc3)
            {
                var _loc6 = obj[_loc4[_loc3]];
                var _loc7 = true;
                if (typeof(_loc6) == "function")
                {
                    _loc7 = showFunctions == true;
                } // end if
                if (typeof(_loc6) == "undefined")
                {
                    _loc7 = showUndefined == true;
                } // end if
                if (_loc7)
                {
                    _loc5 = _loc5 + _loc9;
                    if (!(obj instanceof Array))
                    {
                        _loc5 = _loc5 + (_loc4[_loc3] + ": ");
                    } // end if
                    _loc5 = _loc5 + this.realToString(_loc6, showFunctions, showUndefined, showXMLstructures, maxLineLength, indent);
                    _loc9 = ", `";
                } // end if
            } // end of for
            if (obj instanceof Array)
            {
                _loc5 = _loc5 + "]";
            }
            else
            {
                _loc5 = _loc5 + "}";
            } // end else if
        }
        else if (_loc16 == "function")
        {
            _loc5 = "function";
        }
        else if (_loc16 == "string")
        {
            _loc5 = "\"" + obj + "\"";
        }
        else
        {
            _loc5 = String(obj);
        } // end else if
        if (_loc5 == "undefined")
        {
            _loc5 = "-";
        } // end if
        inProgress.pop();
        return (mx.data.binding.ObjectDumper.replaceAll(_loc5, "`", _loc5.length < maxLineLength ? ("") : ("\n" + this.doIndent(indent))));
    } // End of the function
    static function replaceAll(str, from, to)
    {
        var _loc3 = str.split(from);
        var _loc4 = "";
        var _loc2 = "";
        for (var _loc1 = 0; _loc1 < _loc3.length; ++_loc1)
        {
            _loc4 = _loc4 + (_loc2 + _loc3[_loc1]);
            _loc2 = to;
        } // end of for
        return (_loc4);
    } // End of the function
    function doIndent(indent)
    {
        var _loc2 = "";
        for (var _loc1 = 0; _loc1 < indent; ++_loc1)
        {
            _loc2 = _loc2 + "     ";
        } // end of for
        return (_loc2);
    } // End of the function
} // End of Class
