class mx.utils.ClassFinder
{
    function ClassFinder()
    {
    } // End of the function
    static function findClass(fullClassName)
    {
        if (fullClassName == null)
        {
            return (null);
        } // end if
        var _loc3 = _global;
        var _loc4 = fullClassName.split(".");
        for (var _loc2 = 0; _loc2 < _loc4.length; ++_loc2)
        {
            _loc3 = _loc3[_loc4[_loc2]];
        } // end of for
        if (_loc3 == null)
        {
            _global.__dataLogger.logData(null, "Could not find class \'<classname>\'", {classname: fullClassName}, mx.data.binding.Log.BRIEF);
        } // end if
        return (_loc3);
    } // End of the function
} // End of Class
