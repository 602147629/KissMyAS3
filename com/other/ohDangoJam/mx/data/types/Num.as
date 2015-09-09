class mx.data.types.Num extends mx.data.binding.DataType
{
    var formatter, dataAccessor, type, maxValue, validationError, minValue;
    function Num()
    {
        super();
    } // End of the function
    function gettableTypes()
    {
        return (["Number", "Integer", "String"]);
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc2;
        if (requestedType == "String")
        {
            if (formatter != null)
            {
                if (formatter instanceof mx.data.formatters.NumberFormatter)
                {
                    (mx.data.formatters.NumberFormatter)(formatter).isInt = int;
                } // end if
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
            if (requestedType == "Integer")
            {
                requestedType = "Number";
            } // end if
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
            if (_loc2.value != null && int)
            {
                _loc2.value = Math.round(_loc2.value);
            } // end if
        } // end else if
        return (_loc2);
    } // End of the function
    function settableTypes()
    {
        return (["Number", "Integer", "String", "Boolean", null]);
    } // End of the function
    function setTypedValue(newValue)
    {
        if (newValue.value != null)
        {
            if (newValue.typeName == "String")
            {
                if (formatter != null)
                {
                    return (formatter.setTypedValue(newValue));
                }
                else
                {
                    var _loc3;
                    if (newValue.value.length == 0)
                    {
                        newValue.value = null;
                        newValue.typeName = "Number";
                        _loc3 = dataAccessor.setTypedValue(newValue);
                    }
                    else
                    {
                        var _loc4 = mx.data.types.Num.convertStringToNumber(int, newValue);
                        _loc3 = dataAccessor.setTypedValue(newValue);
                    } // end else if
                    return (_loc4 == null ? (_loc3) : (_loc4));
                } // end else if
            }
            else if (int)
            {
                newValue.value = Math.round(newValue.value);
            } // end if
        } // end else if
        return (dataAccessor.setTypedValue(newValue));
    } // End of the function
    static function convertStringToNumber(isInt, newValue)
    {
        newValue.typeName = isInt ? ("Integer") : ("Number");
        if (isInt)
        {
            newValue.value = parseInt(newValue.value);
        }
        else
        {
            newValue.value = parseFloat(newValue.value);
        } // end else if
        if (isNaN(newValue.value))
        {
            newValue.value = 0;
            return ([mx.data.binding.DataAccessor.conversionFailed(newValue, isInt ? ("Integer") : ("Number"))]);
        } // end if
        return (null);
    } // End of the function
    function validate(value)
    {
        var _loc2 = Number(value);
        if (maxValue != null && _loc2 > maxValue)
        {
            this.validationError(exceedsMaxError);
        } // end if
        if (minValue != null && _loc2 < minValue)
        {
            this.validationError(lowerThanMinError);
        } // end if
        if (int && _loc2 != Math.round(_loc2))
        {
            this.validationError(integerError);
        } // end if
    } // End of the function
    var exceedsMaxError = "This number exceeds the maximum allowed value.";
    var lowerThanMinError = "This number is lower than the minimum allowed value.";
    var integerError = "This number must be an integer.";
    var int = false;
} // End of Class
