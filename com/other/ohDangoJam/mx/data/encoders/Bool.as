class mx.data.encoders.Bool extends mx.data.binding.DataAccessor
{
    var dataAccessor, trueStrings, falseStrings;
    function Bool()
    {
        super();
    } // End of the function
    function getTypedValue(requestedType)
    {
        if (requestedType == "Boolean" || requestedType == null)
        {
            var _loc2 = dataAccessor.getTypedValue("String");
            var _loc3 = null;
            if (_loc2.value != null && _loc2.value.length > 0)
            {
                var _loc4 = trueStrings.indexOf(String(_loc2.value));
                _loc3 = _loc4 != -1;
            } // end if
            return (new mx.data.binding.TypedValue(_loc3, "Boolean"));
        } // end if
    } // End of the function
    function getGettableTypes()
    {
        return (["Boolean"]);
    } // End of the function
    function setTypedValue(newValue)
    {
        if (newValue.typeName == "Boolean")
        {
            var _loc2 = "";
            if (newValue.value != null)
            {
                var _loc4 = newValue.value ? (trueStrings) : (falseStrings);
                var _loc5 = _loc4.split(",");
                _loc2 = _loc5[0];
            } // end if
            return (dataAccessor.setTypedValue(new mx.data.binding.TypedValue(_loc2, "String")));
        }
        else
        {
            return ([mx.data.binding.DataAccessor.conversionFailed(newValue, "Boolean")]);
        } // end else if
    } // End of the function
    function getSettableTypes()
    {
        return (["Boolean"]);
    } // End of the function
} // End of Class
