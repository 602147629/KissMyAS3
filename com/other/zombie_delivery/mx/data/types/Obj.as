class mx.data.types.Obj extends mx.data.binding.DataType
{
    var location, type, property, component, validationError;
    function Obj()
    {
        super();
    } // End of the function
    function gettableTypes()
    {
        return (["Object"]);
    } // End of the function
    function settableTypes()
    {
        return ([null]);
    } // End of the function
    function validate(value)
    {
        var _loc7 = new Array();
        if (location instanceof Array)
        {
            _loc7 = _loc7.concat(location);
        }
        else if (location != null)
        {
            return;
        } // end else if
        for (var _loc4 = 0; _loc4 < type.elements.length; ++_loc4)
        {
            var _loc2 = type.elements[_loc4];
            if (_loc2.name == "[n]")
            {
                continue;
            } // end if
            var _loc5 = component.getField(property, _loc7.concat(_loc2.name));
            var _loc3 = _loc5.validateAndNotify(null, true);
            for (var _loc6 in _loc3)
            {
                this.validationError(_loc2.name + ":" + _loc3[_loc6]);
            } // end of for...in
        } // end of for
    } // End of the function
} // End of Class
