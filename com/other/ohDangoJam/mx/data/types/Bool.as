class mx.data.types.Bool extends mx.data.binding.DataType
{
    var formatter, dataAccessor, type;
    function Bool()
    {
        super();
    } // End of the function
    function gettableTypes()
    {
        return (["Boolean"]);
    } // End of the function
    function settableTypes()
    {
        return (["Number", "Boolean", "String"]);
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc2;
        if (requestedType == "String")
        {
            if (formatter != null)
            {
                _loc2 = formatter.getTypedValue(requestedType);
            }
            else
            {
                _loc2 = dataAccessor.getTypedValue();
                if (_loc2.value == null)
                {
                    _loc2.value = "";
                    _loc2.typeName = "String";
                } // end if
            } // end else if
        }
        else
        {
            _loc2 = dataAccessor.getTypedValue(requestedType);
            if (_loc2.type == null)
            {
                _loc2.type = type;
            } // end if
            if (_loc2.typeName == null)
            {
                _loc2.typeName = type.name;
            } // end if
            if (_loc2.typeName != requestedType && requestedType != null)
            {
                _loc2 = null;
            } // end if
        } // end else if
        return (_loc2);
    } // End of the function
    function setTypedValue(newValue)
    {
        var _loc3 = null;
        if (newValue.value != null)
        {
            if (newValue.typeName == "Boolean" || newValue.typeName == "Number")
            {
                _loc3 = Boolean(newValue.value);
            }
            else if (newValue.typeName == "String")
            {
                if (newValue.value.length > 0)
                {
                    if (formatter != null)
                    {
                        return (formatter.setTypedValue(newValue));
                    }
                    else
                    {
                        var _loc4 = newValue.value.toLowerCase();
                        _loc3 = _loc4 == "true";
                        if (!_loc3 && _loc4 != "false")
                        {
                            var _loc5 = Number(_loc4);
                            if (isNaN(_loc5))
                            {
                                return ([mx.data.binding.DataAccessor.conversionFailed(newValue, "Boolean")]);
                            }
                            else
                            {
                                _loc3 = Boolean(_loc5);
                            } // end if
                        } // end if
                    } // end else if
                } // end else if
            }
            else
            {
                return ([mx.data.binding.DataAccessor.conversionFailed(newValue, "Boolean")]);
            } // end else if
        } // end else if
        return (dataAccessor.setTypedValue(new mx.data.binding.TypedValue(_loc3, "Boolean")));
    } // End of the function
} // End of Class
