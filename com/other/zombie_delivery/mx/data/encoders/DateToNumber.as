class mx.data.encoders.DateToNumber extends mx.data.binding.DataAccessor
{
    var dataAccessor;
    function DateToNumber()
    {
        super();
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc4;
        if (requestedType == "Date" || requestedType == null)
        {
            var _loc3 = dataAccessor.getTypedValue("Number");
            var _loc2;
            if (_loc3.value != null)
            {
                _loc2 = new Date(_loc3.value);
            }
            else
            {
                _loc2 = null;
            } // end else if
            _loc4 = new mx.data.binding.TypedValue(_loc2, "Date");
        } // end if
        return (_loc4);
    } // End of the function
    function getGettableTypes()
    {
        return (["Date"]);
    } // End of the function
    function setTypedValue(newValue)
    {
        if (newValue.typeName == "Date")
        {
            var _loc2;
            if (newValue.value != null)
            {
                _loc2 = newValue.value.getTime();
            }
            else
            {
                _loc2 = null;
            } // end else if
            return (dataAccessor.setTypedValue(new mx.data.binding.TypedValue(_loc2, "Number")));
        }
        else
        {
            return ([mx.data.binding.DataAccessor.conversionFailed(newValue, "Date")]);
        } // end else if
    } // End of the function
    function getSettableTypes()
    {
        return (["Date"]);
    } // End of the function
} // End of Class
