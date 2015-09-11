class mx.data.binding.DataAccessor
{
    var dataAccessor, component, property, location, type;
    function DataAccessor()
    {
    } // End of the function
    function getAnyTypedValue(suggestedTypes)
    {
        for (var _loc3 = 0; _loc3 < suggestedTypes.length; ++_loc3)
        {
            var _loc5 = this.getTypedValue(suggestedTypes[_loc3]);
            if (_loc5 != null)
            {
                return (_loc5);
            } // end if
        } // end of for
        _loc5 = this.getTypedValue();
        for (var _loc3 = 0; _loc3 < suggestedTypes.length; ++_loc3)
        {
            var _loc2 = suggestedTypes[_loc3];
            if (_loc2 == "String")
            {
                return (new mx.data.binding.TypedValue(String(_loc5.value), _loc2));
            } // end if
            if (_loc2 == "Number")
            {
                return (new mx.data.binding.TypedValue(Number(_loc5.value), _loc2));
            } // end if
            if (_loc2 == "Boolean")
            {
                return (new mx.data.binding.TypedValue(Boolean(_loc5.value), _loc2));
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
    function setAnyTypedValue(newValue)
    {
        var _loc7 = this.getSettableTypes();
        if (_loc7 == null || mx.data.binding.DataAccessor.findString(newValue.typeName, _loc7) != -1)
        {
            return (this.setTypedValue(newValue));
        }
        else
        {
            for (var _loc3 = 0; _loc3 < _loc7.length; ++_loc3)
            {
                var _loc2 = _loc7[_loc3];
                if (_loc2 == "String")
                {
                    return (this.setTypedValue(new mx.data.binding.TypedValue(String(newValue.value), _loc2)));
                } // end if
                if (_loc2 == "Number")
                {
                    var _loc5 = Number(newValue.value);
                    var _loc6 = this.setTypedValue(new mx.data.binding.TypedValue(_loc5, _loc2));
                    if (_loc5.toString() == "NaN")
                    {
                        return (["Failed to convert \'" + newValue.value + "\' to a number"]);
                    }
                    else
                    {
                        return (_loc6);
                    } // end if
                } // end else if
                if (_loc2 == "Boolean")
                {
                    return (this.setTypedValue(new mx.data.binding.TypedValue(Boolean(newValue.value), _loc2)));
                } // end if
            } // end of for
        } // end else if
        return (dataAccessor.setTypedValue(newValue));
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc2 = dataAccessor.getTypedValue(requestedType);
        return (_loc2);
    } // End of the function
    function getGettableTypes()
    {
        return (null);
    } // End of the function
    function setTypedValue(newValue)
    {
        return (dataAccessor.setTypedValue(newValue));
    } // End of the function
    function getSettableTypes()
    {
        return (null);
    } // End of the function
    function findLastAccessor()
    {
        return (dataAccessor == null ? (this) : (dataAccessor.findLastAccessor()));
    } // End of the function
    function setupDataAccessor(component, property, location)
    {
        this.component = component;
        this.property = property;
        this.location = location;
        type = component.findSchema(property, location);
    } // End of the function
    static function findString(str, arr)
    {
        var _loc3 = str.toLowerCase();
        for (var _loc1 = 0; _loc1 < arr.length; ++_loc1)
        {
            if (arr[_loc1].toLowerCase() == _loc3)
            {
                return (_loc1);
            } // end if
        } // end of for
        return (-1);
    } // End of the function
    static function conversionFailed(newValue, target)
    {
        return ("Failed to convert to " + target + ": \'" + newValue.value + "\'");
    } // End of the function
} // End of Class
