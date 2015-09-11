class mx.data.formatters.NumberFormatter extends mx.data.binding.Formatter
{
    var dataAccessor, precision, isInt;
    function NumberFormatter()
    {
        super();
    } // End of the function
    function getTypedValue(requestedType)
    {
        if (requestedType == "String" || requestedType == null)
        {
            var _loc3 = dataAccessor.getTypedValue();
            if (_loc3.value != null)
            {
                var _loc2;
                if (precision > 0)
                {
                    var _loc6 = isInt ? (1) : (Math.pow(10, precision));
                    _loc2 = (Math.round(_loc3.value * _loc6) / _loc6).toString();
                    if (_loc2.length > 0)
                    {
                        var _loc5 = _loc2.lastIndexOf(".");
                        var _loc4 = 0;
                        if (_loc5 < 0)
                        {
                            _loc2 = _loc2 + ".";
                            _loc4 = precision;
                        }
                        else
                        {
                            _loc4 = precision - (_loc2.length - (_loc5 + 1));
                        } // end else if
                        _loc2 = _loc2 + "0000000000000000000000000000".substring(0, _loc4);
                    } // end if
                }
                else
                {
                    _loc2 = Math.round(_loc3.value).toString();
                } // end else if
                return (new mx.data.binding.TypedValue(_loc2, "String"));
            }
            else
            {
                return (new mx.data.binding.TypedValue("", "String"));
            } // end if
        } // end else if
    } // End of the function
    function getGettableTypes()
    {
        return (["String"]);
    } // End of the function
    function setTypedValue(newValue)
    {
        if (newValue.typeName == "String")
        {
            if (newValue.value.length == 0)
            {
                return (dataAccessor.setTypedValue(new mx.data.binding.TypedValue(null, "Number")));
            }
            else
            {
                var _loc3 = mx.data.types.Num.convertStringToNumber(isInt, newValue);
                var _loc4 = dataAccessor.setTypedValue(newValue);
                return (_loc3 == null ? (_loc4) : (_loc3));
            } // end else if
        }
        else
        {
            return ([mx.data.binding.DataAccessor.conversionFailed(newValue, "Number")]);
        } // end else if
    } // End of the function
    function getSettableTypes()
    {
        return (["String"]);
    } // End of the function
} // End of Class
