class mx.data.binding.Log
{
    var level, name;
    function Log(logLevel, logName)
    {
        level = logLevel == undefined ? (mx.data.binding.Log.BRIEF) : (logLevel);
        name = name == undefined ? ("") : (name);
    } // End of the function
    function logInfo(msg, level)
    {
        if (level == undefined)
        {
            level = mx.data.binding.Log.BRIEF;
        } // end if
        this.onLog(this.getDateString() + " " + name + ": " + mx.data.binding.ObjectDumper.toString(msg));
    } // End of the function
    function logData(target, message, info, level)
    {
        if (level == undefined)
        {
            level = mx.data.binding.Log.VERBOSE;
        } // end if
        var _loc6 = name.length > 0 ? (" " + name + ": ") : (" ");
        var _loc4 = target == null ? ("") : (target + ": ");
        if (_loc4.indexOf("_level0.") == 0)
        {
            _loc4 = _loc4.substr(8);
        } // end if
        var _loc3 = this.getDateString() + _loc6 + _loc4 + mx.data.binding.Log.substituteIntoString(message, info, 50);
        if (showDetails && info != null)
        {
            _loc3 = _loc3 + ("\n    " + mx.data.binding.ObjectDumper.toString(info));
        }
        else
        {
            for (var _loc2 = 0; _loc2 < nestLevel; ++_loc2)
            {
                _loc3 = "    " + _loc3;
            } // end of for
        } // end else if
        this.onLog(_loc3);
    } // End of the function
    function onLog(message)
    {
        trace (message);
    } // End of the function
    function getDateString()
    {
        var _loc1 = new Date();
        return (_loc1.getMonth() + 1 + "/" + _loc1.getDate() + " " + _loc1.getHours() + ":" + _loc1.getMinutes() + ":" + _loc1.getSeconds());
    } // End of the function
    static function substituteIntoString(message, info, maxlen, rawDataType)
    {
        var _loc9 = "";
        if (info == null)
        {
            return (message);
        } // end if
        var _loc11 = message.split("<");
        if (_loc11 == null)
        {
            return (message);
        } // end if
        _loc9 = _loc9 + _loc11[0];
        for (var _loc7 = 1; _loc7 < _loc11.length; ++_loc7)
        {
            var _loc8 = _loc11[_loc7].split(">");
            var _loc5 = _loc8[0].split(".");
            var _loc1 = info;
            var _loc4 = rawDataType;
            for (var _loc2 = 0; _loc2 < _loc5.length; ++_loc2)
            {
                var _loc3 = _loc5[_loc2];
                if (_loc3 != "")
                {
                    _loc4 = mx.data.binding.FieldAccessor.findElementType(_loc4, _loc3);
                    var _loc6 = new mx.data.binding.FieldAccessor(null, null, _loc1, _loc3, _loc4, null, null);
                    _loc1 = _loc6.getValue();
                } // end if
            } // end of for
            if (typeof(_loc1) != "string")
            {
                _loc1 = mx.data.binding.ObjectDumper.toString(_loc1);
            } // end if
            if (_loc1.indexOf("_level0.") == 0)
            {
                _loc1 = _loc1.substr(8);
            } // end if
            if (maxlen != null && _loc1.length > maxlen)
            {
                _loc1 = _loc1.substr(0, maxlen) + "...";
            } // end if
            _loc9 = _loc9 + _loc1;
            _loc9 = _loc9 + _loc8[1];
        } // end of for
        var _loc14 = _loc9.split("&gt;");
        _loc9 = _loc14.join(">");
        _loc14 = _loc9.split("&lt;");
        _loc9 = _loc14.join("<");
        return (_loc9);
    } // End of the function
    static var NONE = -1;
    static var BRIEF = 0;
    static var VERBOSE = 1;
    static var DEBUG = 2;
    static var INFO = 2;
    static var WARNING = 1;
    static var ERROR = 0;
    var showDetails = false;
    var nestLevel = 0;
} // End of Class
